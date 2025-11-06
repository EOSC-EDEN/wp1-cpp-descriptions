"""
generate-md.py

Script for generation of README.md files for each CPP-XYZ.xml file.
"""

import os
import xml.etree.ElementTree as ET
import logging
import re
from html import unescape

# --- Setup basic logging ---
logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")


def clean_text(text):
    """Cleans block-level text by normalizing whitespace."""
    return " ".join(text.strip().split()) if text else ""


def element_to_markdown(element):
    """
    Recursively converts an XML element and its children to a Markdown string,
    preserving whitespace around inline elements.
    """
    if element is None:
        return ""

    parts = []
    # Preserve whitespace in the element's leading text
    if element.text:
        parts.append(element.text)

    for child in element:
        tag = child.tag.split("}")[-1]

        # Recursively get content of the child
        child_content = element_to_markdown(child)

        # Apply formatting based on the tag
        if tag == "p":
            # For paragraphs, clean the final concatenated content
            parts.append(f"\n\n{clean_text(child_content)}")
        elif tag == "em":
            parts.append(f"*{child_content}*")
        elif tag == "b":
            parts.append(f"**{child_content}**")
        elif tag == "a" or tag == "hyperlink":
            href = child.get("href", "") or (child.text if child.text else "")
            parts.append(f"[{child_content}]({href})")
        elif tag == "ul":
            parts.append(f"\n{child_content}")
        elif tag == "li":
            parts.append(f"\n* {clean_text(child_content)}")
        elif tag == "br":
            parts.append("\n")
        else:
            parts.append(child_content)

        # Preserve whitespace in the text following the child element
        if child.tail:
            parts.append(child.tail)

    return "".join(parts)


def format_multiline_cell(text):
    """Replaces newlines with <br> for presentation in a Markdown table cell."""
    if not text:
        return ""
    # Convert paragraph breaks and list newlines to <br> tags.
    formatted_text = text.replace("\n\n", "<br><br>").replace("\n*", "<br>• ")
    return formatted_text.replace("\n", "<br>")


def format_markdown_table(headers, data):
    """Formats data into a left-aligned Markdown table."""
    if not data:
        return ""

    safe_data = [{h: str(row.get(h, "")) for h in headers} for row in data]
    col_widths = {h: len(h) for h in headers}
    for row in safe_data:
        for h in headers:
            max_line_length = max(
                (len(line) for line in row[h].split("<br>")), default=0
            )
            col_widths[h] = max(col_widths[h], max_line_length)

    header_line = "| " + " | ".join(h.ljust(col_widths[h]) for h in headers) + " |"
    separator_line = (
        "| " + " | ".join(":" + "-" * (col_widths[h] - 1) for h in headers) + " |"
    )
    data_lines = [
        "| " + " | ".join(row.get(h, "").ljust(col_widths[h]) for h in headers) + " |"
        for row in safe_data
    ]

    return "\n".join([header_line, separator_line] + data_lines)


def parse_xml_to_markdown(xml_file):
    """Parses a single XML file and converts it to a Markdown string."""
    logging.info(f"--- Processing file: {xml_file} ---")
    try:
        tree = ET.parse(xml_file)
        root = tree.getroot()
    except ET.ParseError as e:
        logging.error(f"Failed to parse XML file: {xml_file}. Error: {e}")
        return None

    ns_map = {"cpp": "https://eden-fidelis.eu/cpp/cpp/"}

    def find(parent, path):
        return parent.find(path, ns_map)

    def findall(parent, path):
        return parent.findall(path, ns_map)

    def get_simple_text(element):
        return clean_text("".join(element.itertext())) if element is not None else ""

    header = find(root, "cpp:header")
    label = get_simple_text(find(header, "cpp:label"))
    authors = [get_simple_text(el) for el in findall(header, "cpp:authors/cpp:author")]
    contributors = [
        get_simple_text(el)
        for el in findall(header, "cpp:contributors/cpp:contributor")
    ]
    evaluators = [
        get_simple_text(el) for el in findall(header, "cpp:evaluators/cpp:evaluator")
    ]

    short_def = get_simple_text(find(root, "cpp:shortDefinition"))

    # Process description block, which can have mixed content
    desc_scope_raw = element_to_markdown(find(root, "cpp:descriptionAndScope"))
    desc_scope = "\n\n".join(
        [clean_text(p) for p in desc_scope_raw.split("\n\n") if p.strip()]
    )

    markdown = f"# {label or 'No Label Found'}\n\n"
    if short_def:
        markdown += f"**Short Definition:** {short_def}\n\n"
    if desc_scope:
        markdown += f"## Description and Scope\n{desc_scope}\n\n"
    if authors:
        markdown += (
            "## Authors\n" + "".join(f"- {author}\n" for author in authors) + "\n"
        )
    if contributors:
        markdown += (
            "## Contributors\n"
            + "".join(f"- {contributor}\n" for contributor in contributors)
            + "\n"
        )
    if evaluators:
        markdown += (
            "## Evaluators\n"
            + "".join(f"- {evaluator}\n" for evaluator in evaluators)
            + "\n"
        )

    process = find(root, "cpp:process")
    if process:
        markdown += "## Process Definition\n\n"
        inputs = findall(process, ".//cpp:dataElement") + findall(
            process, ".//cpp:guidanceElement"
        )
        if inputs:
            markdown += (
                "**Inputs:**\n"
                + "".join(f"- {get_simple_text(item)}\n" for item in inputs)
                + "\n"
            )
        outputs = findall(process, ".//cpp:metadataElement") + findall(
            process, ".//cpp:guidanceElement"
        )
        if outputs:
            markdown += (
                "**Outputs:**\n"
                + "".join(f"- {get_simple_text(item)}\n" for item in outputs)
                + "\n"
            )
        triggers = findall(process, ".//cpp:triggerEvent")
        if triggers:
            markdown += "**Trigger Events:**\n"
            for t in triggers:
                desc = clean_text(element_to_markdown(find(t, "cpp:description")))
                cpp = get_simple_text(find(t, "cpp:correspondingCPP"))
                markdown += f"- {desc}" + (f" (see `{cpp}`)\n" if cpp else "\n")
            markdown += "\n"

    steps = findall(process, ".//cpp:step") if process else []
    if steps:
        markdown += "## Process Steps\n\n"
        headers = ["Step", "Description", "Inputs", "Outputs"]
        table_data = []
        for step in steps:
            desc = element_to_markdown(find(step, "cpp:stepDescription"))
            ins = [
                element_to_markdown(el)
                for el in findall(step, "cpp:input/cpp:inputElement")
            ]
            outs = [
                element_to_markdown(el)
                for el in findall(step, "cpp:output/cpp:outputElement")
            ]
            table_data.append(
                {
                    "Step": step.get("stepNumber", ""),
                    "Description": format_multiline_cell(desc),
                    "Inputs": format_multiline_cell(
                        "<br>".join(f"- {i}" for i in ins if i)
                    ),
                    "Outputs": format_multiline_cell(
                        "<br>".join(f"- {o}" for o in outs if o)
                    ),
                }
            )
        markdown += format_markdown_table(headers, table_data) + "\n\n"

    rationale = find(root, "cpp:rationaleWorstCase")
    if rationale:
        markdown += "## Rationale / Worst Case\n\n"
        headers = ["Purpose", "Worst Case"]
        table_data = [
            {
                "Purpose": format_multiline_cell(
                    element_to_markdown(find(p, "cpp:purposeDescription"))
                ),
                "Worst Case": format_multiline_cell(
                    element_to_markdown(find(p, "cpp:worstCase"))
                ),
            }
            for p in findall(rationale, "cpp:purpose")
        ]
        markdown += format_markdown_table(headers, table_data) + "\n\n"

    relationships = find(root, "cpp:cppRelationships")
    if relationships:
        markdown += "## Relationships\n\n"
        headers = ["Type", "Related CPP", "Description"]
        table_data = [
            {
                "Type": get_simple_text(find(r, "cpp:relationshipType")),
                "Related CPP": get_simple_text(find(r, "cpp:relatedCPP")),
                "Description": format_multiline_cell(
                    element_to_markdown(find(r, "cpp:relationshipDescription"))
                ),
            }
            for r in findall(relationships, "cpp:relationship")
        ]
        markdown += format_markdown_table(headers, table_data) + "\n\n"

    mappings = find(root, "cpp:frameworkMappings")
    if mappings:
        markdown += "## Framework Mappings\n\n"
        for mapping in findall(mappings, "cpp:mapping"):
            name = get_simple_text(find(mapping, "cpp:frameworkName"))
            markdown += f"- **{name}**\n"
            term = element_to_markdown(find(mapping, "cpp:correspondingTerm"))
            if term:
                markdown += f"  - **Term:** {term}\n"
            section_element = find(mapping, "cpp:correspondingSection")
            if section_element is not None:
                section_text = element_to_markdown(section_element)
                indented_section = "  - **Section:** " + section_text.replace(
                    "\n", "\n    "
                )
                markdown += f"{indented_section}\n"
        markdown += "\n"

    references = find(root, "cpp:referenceImplementations")
    if references:
        markdown += "## Reference Implementations\n\n"
        use_cases = findall(references, "cpp:useCases/cpp:useCase")
        if use_cases:
            markdown += "### Use Cases\n"
            for case in use_cases:
                title = get_simple_text(find(case, "cpp:useCasetitle"))
                inst_lbl = get_simple_text(
                    find(case, "cpp:institution/cpp:institutionLabel")
                )
                link = element_to_markdown(find(case, ".//cpp:hyperlink"))
                prob = element_to_markdown(find(case, "cpp:problemStatement"))
                markdown += f"- **{title}**\n"
                markdown += f"  - **Institution:** {inst_lbl}\n"
                if link:
                    markdown += f"  - **Documentation:** {link}\n"
                if prob:
                    markdown += f"  - **Problem:** {prob}\n"

                solution_element = find(case, "cpp:proposedSolution")
                if solution_element is not None:
                    # Extract mixed content (text and <br>) from the solution tag
                    inner_html = (
                        ET.tostring(solution_element, encoding="unicode")
                        .split(">", 1)[1]
                        .rsplit("<", 1)[0]
                    )
                    text = re.sub(r"<br\s*/?>", "\n", inner_html, flags=re.IGNORECASE)
                    text = unescape(text).strip()
                    text = re.sub(r"\s*\.\.\.\s*$", "", text)  # Remove trailing '...'
                    markdown += f"  - **Solution:**\n```python\n{text}\n```\n"
            markdown += "\n"

        public_docs = findall(references, "cpp:publicDocumentation")
        if public_docs:
            markdown += "### Public Documentation\n"
            for doc in public_docs:
                inst_lbl = get_simple_text(
                    find(doc, "cpp:institution/cpp:institutionLabel")
                )
                link = element_to_markdown(find(doc, ".//cpp:hyperlink"))
                comment = get_simple_text(
                    find(doc, "cpp:linkToDocumentation/cpp:comment")
                )
                markdown += f"- **{inst_lbl}**\n"
                markdown += f"  - **Link:** {link}\n"
                if comment:
                    markdown += f"  - **Comment:** {comment}\n"
            markdown += "\n"

    return markdown


def main():
    """Finds all XML files in subdirectories and generates a single combined README.md."""
    start_dir = "."
    logging.info(f"Starting script in directory: {os.path.abspath(start_dir)}")

    xml_files = []
    for root_dir, _, files in os.walk(start_dir):
        for file in files:
            if file.endswith(".xml"):
                xml_files.append(os.path.join(root_dir, file))

    if not xml_files:
        logging.warning("No XML files found. No README.md will be generated.")
        return

    full_markdown = ""
    for xml_path in sorted(xml_files):
        markdown_content = parse_xml_to_markdown(xml_path)
        if markdown_content:
            full_markdown += markdown_content + "\n\n---\n\n"

    if full_markdown:
        # Save the combined README in the directory where the script was run
        readme_path = os.path.join(start_dir, "README.md")
        try:
            with open(readme_path, "w", encoding="utf-8") as f:
                f.write(full_markdown)
            logging.info(
                f"Successfully generated combined README.md from {len(xml_files)} XML file(s).\n"
            )
        except IOError as e:
            logging.error(f"Could not write to file {readme_path}. Error: {e}\n")


if __name__ == "__main__":
    main()
