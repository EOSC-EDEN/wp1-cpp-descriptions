"""
generate-md.py

Script for generation of README.md files for each CPP-XYZ.xml file
"""

import os
import xml.etree.ElementTree as ET
import logging
import re

# --- Setup basic logging ---
logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")


def clean_text(text):
    """The original cleaner for block-level text."""
    return " ".join(text.strip().split()) if text else ""


def element_to_markdown(element):
    """
    Recursively converts an XML element and its children to a Markdown string.
    This corrected version preserves whitespace around inline elements.
    """
    if element is None:
        return ""

    parts = []
    # Preserve the original text, including whitespace.
    if element.text:
        parts.append(element.text)

    for child in element:
        tag = child.tag.split("}")[-1]
        child_content = element_to_markdown(child)  # Recursive call

        # Apply formatting based on the tag
        if tag == "p":
            # Paragraphs are block-level. Add newlines and clean the entire content.
            parts.append(f"\n\n{clean_text(child_content)}")
        elif tag == "em":
            # Inline tags just wrap the content.
            parts.append(f"*{child_content}*")
        elif tag == "b":
            parts.append(f"**{child_content}**")
        elif tag == "a" or tag == "hyperlink":
            href = child.get("href", "") or child.text
            if child_content == href:
                parts.append(f"<{href}>")
            else:
                parts.append(f"[{child_content}]({href})")
        elif tag == "ul":
            parts.append(f"\n{child_content}")
        elif tag == "li":
            parts.append(f"\n* {clean_text(child_content)}")
        elif tag == "br":
            parts.append("\n")
        else:  # Default for unknown tags
            parts.append(child_content)

        # Preserve the original tail text, including whitespace.
        if child.tail:
            parts.append(child.tail)

    # Join all the pieces together.
    final_string = "".join(parts)

    # The final strip cleans the entire assembled string.
    return final_string.strip()


def format_multiline_cell(text):
    """Replaces newlines with <br> for presentation in a Markdown table cell."""
    if not text:
        return ""
    # Convert paragraph breaks and list newlines to <br> tags.
    # Also handle bullet points within cells.
    formatted_text = text.replace("\n\n", "<br><br>").replace("\n*", "<br>• ")
    if "<ul>" in text or "<li>" in text:
        return text  # Don't process html lists further
    return formatted_text.replace("\n", "<br>")


def format_markdown_table(headers, data):
    """Formats data into a perfectly aligned Markdown table without external libraries."""
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
    data_lines = []
    for row in safe_data:
        row_cells = [row.get(h, "").ljust(col_widths[h]) for h in headers]
        data_lines.append("| " + " | ".join(row_cells) + " |")

    return "\n".join([header_line, separator_line] + data_lines)


def parse_xml_to_markdown(xml_file):
    """
    Parses a single XML file and converts it to a Markdown string.
    """
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

    short_definition = get_simple_text(find(root, "cpp:shortDefinition"))
    description_and_scope_raw = element_to_markdown(
        find(root, "cpp:descriptionAndScope")
    )

    if description_and_scope_raw:
        description_and_scope = "\n\n".join(
            [
                clean_text(p)
                for p in description_and_scope_raw.split("\n\n")
                if p.strip()
            ]
        )
    else:
        description_and_scope = ""

    markdown = f"# {label or 'No Label Found'}\n\n"
    if short_definition:
        markdown += f"**Short Definition:** {short_definition}\n\n"
    if description_and_scope:
        markdown += f"## Description and Scope\n{description_and_scope}\n\n"
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

        # General Inputs
        data_inputs = findall(process, "cpp:inputs/cpp:data/cpp:dataElement")
        metadata_inputs = findall(process, "cpp:inputs/cpp:metadata/cpp:metadataElement")
        guidance_inputs = findall(process, "cpp:inputs/cpp:guidance/cpp:guidanceElement")
        if data_inputs or guidance_inputs or metadata_inputs:
            markdown += "### Inputs\n\n"
            headers = ["Type", "Input"]
            table_data = []
            for item in data_inputs:
                table_data.append({"Type": "Data", "Input": get_simple_text(item)})
            for item in metadata_inputs:
                table_data.append({"Type": "Metadata", "Input": get_simple_text(item)})
            for item in guidance_inputs:
                table_data.append({"Type": "Guidance", "Input": get_simple_text(item)})
            markdown += format_markdown_table(headers, table_data) + "\n\n"

        # General Outputs
        metadata_outputs = findall(process, "cpp:outputs/cpp:metadata/cpp:metadataElement")
        guidance_outputs = findall(process, "cpp:outputs/cpp:guidance/cpp:guidanceElement")
        if metadata_outputs or guidance_outputs:
            markdown += "### Outputs\n\n"
            headers = ["Type", "Output"]
            table_data = []
            for item in metadata_outputs:
                table_data.append({"Type": "Metadata", "Output": get_simple_text(item)})
            for item in guidance_outputs:
                table_data.append({"Type": "Guidance", "Output": get_simple_text(item)})
            markdown += format_markdown_table(headers, table_data) + "\n\n"

        # Trigger Events
        triggers = findall(process, "cpp:triggerEvents/cpp:triggerEvent")
        if triggers:
            markdown += "### Trigger Events\n\n"
            headers = ["Description", "Corresponding CPP"]
            table_data = []
            for trigger in triggers:
                desc = element_to_markdown(find(trigger, "cpp:description"))
                corr_cpp = get_simple_text(find(trigger, "cpp:correspondingCPP"))
                table_data.append({
                    "Description": format_multiline_cell(desc),
                    "Corresponding CPP": f"`{corr_cpp}`" if corr_cpp else ""
                })
            markdown += format_markdown_table(headers, table_data) + "\n\n"


    steps = findall(process, ".//cpp:step") if process else []
    if steps:
        markdown += "## Process Steps\n\n"
        table_data = []
        headers = ["Step", "Supplier(s)", "Input(s)", "Description", "Output(s)", "Customer(s)"]

        for step in steps:
            step_number = step.get("stepNumber", "")
            desc_md = element_to_markdown(find(step, "cpp:stepDescription"))

            # --- Inputs and Suppliers ---
            inputs_list = []
            suppliers_set = set()
            for inp in findall(step, "cpp:input"):
                element_md = element_to_markdown(find(inp, "cpp:inputElement"))
                if element_md:
                    inputs_list.append(f"- {element_md}")
                
                supplier = get_simple_text(find(inp, "cpp:supplier"))
                if supplier:
                    suppliers_set.add(f"`{supplier}`")

            # --- Outputs and Customers ---
            outputs_list = []
            customers_set = set()
            for outp in findall(step, "cpp:output"):
                element_md = element_to_markdown(find(outp, "cpp:outputElement"))
                if element_md:
                    outputs_list.append(f"- {element_md}")
                
                customers = [get_simple_text(c) for c in findall(outp, "cpp:customer")]
                for customer in customers:
                    if customer:
                        customers_set.add(f"`{customer}`")

            # --- Format for table ---
            suppliers_str = "<br>".join(sorted(list(suppliers_set)))
            inputs_str = "<br>".join(inputs_list)
            customers_str = "<br>".join(sorted(list(customers_set)))
            outputs_str = "<br>".join(outputs_list)

            table_data.append({
                "Step": step_number,
                "Supplier(s)": format_multiline_cell(suppliers_str),
                "Input(s)": format_multiline_cell(inputs_str),
                "Description": format_multiline_cell(desc_md),
                "Output(s)": format_multiline_cell(outputs_str),
                "Customer(s)": format_multiline_cell(customers_str),
            })

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
    if mappings and findall(mappings, "cpp:mapping"):
        markdown += "## Framework Mappings\n\n"
        headers = ["Framework", "Term", "Section"]
        table_data = []
        for mapping in findall(mappings, "cpp:mapping"):
            framework_name = get_simple_text(find(mapping, "cpp:frameworkName"))
            term = element_to_markdown(find(mapping, "cpp:correspondingTerm"))

            section_element = find(mapping, "cpp:correspondingSection")
            section_text = ""
            if section_element is not None:
                section_parts = [element_to_markdown(p) for p in section_element]
                section_text = "\n\n".join(p for p in section_parts if p)

            table_data.append({
                "Framework": framework_name,
                "Term": format_multiline_cell(term),
                "Section": format_multiline_cell(section_text)
            })
        markdown += format_markdown_table(headers, table_data) + "\n\n"


    references = find(root, "cpp:referenceImplementations")
    if references:
        markdown += "## Reference Implementations\n\n"
        
        use_cases = findall(references, "cpp:useCases/cpp:useCase")
        if use_cases:
            markdown += "### Use Cases\n\n"
            headers = ["Title", "Institution", "Documentation", "Problem", "Solution"]
            table_data = []
            for case in use_cases:
                solution_raw = element_to_markdown(find(case, "cpp:proposedSolution"))
                solution_clean = re.sub(r"\s*\.\.\.\s*$", "", solution_raw)
                solution_formatted = f"<pre><code>{solution_clean}</code></pre>" if solution_clean else ""

                table_data.append({
                    "Title": get_simple_text(find(case, "cpp:useCasetitle")),
                    "Institution": get_simple_text(find(case, "cpp:institution/cpp:institutionLabel")),
                    "Documentation": element_to_markdown(find(case, "cpp:linkToDocumentation/cpp:hyperlink")),
                    "Problem": format_multiline_cell(element_to_markdown(find(case, "cpp:problemStatement"))),
                    "Solution": solution_formatted,
                })
            markdown += format_markdown_table(headers, table_data) + "\n\n"

        public_docs = findall(references, "cpp:publicDocumentation")
        if public_docs:
            markdown += "### Public Documentation\n\n"
            headers = ["Institution", "Link", "Comment"]
            table_data = []
            for doc in public_docs:
                table_data.append({
                    "Institution": get_simple_text(find(doc, "cpp:institution/cpp:institutionLabel")),
                    "Link": element_to_markdown(find(doc, "cpp:linkToDocumentation/cpp:hyperlink")),
                    "Comment": get_simple_text(find(doc, "cpp:linkToDocumentation/cpp:comment")),
                })
            markdown += format_markdown_table(headers, table_data) + "\n\n"

    return markdown


def main():
    start_dir = "."
    logging.info(f"Starting script in directory: {os.path.abspath(start_dir)}")
    for root_dir, _, files in os.walk(start_dir):
        xml_files_in_dir = [f for f in files if f.endswith(".xml")]
        if xml_files_in_dir:
            full_markdown = ""
            for file in sorted(xml_files_in_dir):
                xml_path = os.path.join(root_dir, file)
                markdown_content = parse_xml_to_markdown(xml_path)
                if markdown_content:
                    full_markdown += markdown_content + "\n\n---\n\n"

            if full_markdown:
                readme_path = os.path.join(root_dir, "README.md")
                try:
                    with open(readme_path, "w", encoding="utf-8") as f:
                        f.write(full_markdown)
                    logging.info(
                        f"Successfully generated {readme_path} from {len(xml_files_in_dir)} XML file(s).\n"
                    )
                except IOError as e:
                    logging.error(
                        f"Could not write to file {readme_path}. Error: {e}\n"
                    )


if __name__ == "__main__":
    main()