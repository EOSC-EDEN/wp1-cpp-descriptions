"""
generate-md.py

Script for generation of README.md files for each CPP-XYZ.xml file
"""

import os
import xml.etree.ElementTree as ET
import logging
import re

# --- Setup basic logging ---
logging.basicConfig(
    level=logging.INFO,
    format='%(levelname)s: %(message)s'
)

def clean_text(text):
    """The original cleaner for block-level text."""
    return ' '.join(text.strip().split()) if text else ''

def element_to_markdown(element):
    """
    Recursively converts an XML element and its children to a Markdown string.
    This version handles paragraph structure and inline emphasis spacing.
    """
    if element is None:
        return ""

    parts = []
    if element.text:
        if element.tag.endswith('proposedSolution'):
            parts.append(element.text)
        else:
            parts.append(element.text.strip())


    for child in element:
        tag = child.tag.split('}')[-1]
        child_content = element_to_markdown(child)

        if tag == 'p':
            parts.append(f"\n\n{clean_text(child_content)}")
        elif tag == 'em':
            parts.append(f"*{child_content}*")
        elif tag == 'b':
            parts.append(f"**{child_content}**")
        elif tag == 'a' or tag == 'hyperlink':
            href = child.get('href', '') or child.text
            if child_content == href:
                parts.append(f"<{href}>")
            else:
                parts.append(f"[{child_content}]({href})")
        elif tag == 'ul':
            parts.append(f"\n{child_content}")
        elif tag == 'li':
            parts.append(f"\n* {clean_text(child_content)}")
        elif tag == 'br':
            parts.append("\n")
        else:
            parts.append(child_content)
        
        if child.tail:
            if element.tag.endswith('proposedSolution'):
                 parts.append(child.tail)
            else:
                 parts.append(child.tail.strip())
            
    final_string = "".join(parts)
    return final_string.strip()


def format_multiline_cell(text):
    """Replaces newlines with <br> for presentation in a Markdown table cell."""
    if not text:
        return ""
    # Convert paragraph breaks and list newlines to <br> tags.
    # Also handle bullet points within cells.
    formatted_text = text.replace('\n\n', '<br><br>').replace('\n*', '<br>• ')
    if '<ul>' in text or '<li>' in text:
        return text # Don't process html lists further
    return formatted_text.replace('\n', '<br>')


def format_markdown_table(headers, data):
    """Formats data into a perfectly aligned Markdown table without external libraries."""
    if not data:
        return ""

    safe_data = [{h: str(row.get(h, "")) for h in headers} for row in data]

    col_widths = {h: len(h) for h in headers}
    for row in safe_data:
        for h in headers:
            max_line_length = max((len(line) for line in row[h].split('<br>')), default=0)
            col_widths[h] = max(col_widths[h], max_line_length)

    header_line = "| " + " | ".join(h.ljust(col_widths[h]) for h in headers) + " |"
    separator_line = "| " + " | ".join(":" + "-" * (col_widths[h] - 1) for h in headers) + " |"
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

    ns_map = {'cpp': "https://eden-fidelis.eu/cpp/cpp/"}

    def find(parent, path):
        return parent.find(path, ns_map)
    def findall(parent, path):
        return parent.findall(path, ns_map)
    def get_simple_text(element):
        return clean_text("".join(element.itertext())) if element is not None else ''

    header = find(root, 'cpp:header')
    label = get_simple_text(find(header, 'cpp:label'))
    authors = [get_simple_text(el) for el in findall(header, 'cpp:authors/cpp:author')]
    contributors = [get_simple_text(el) for el in findall(header, 'cpp:contributors/cpp:contributor')]
    evaluators = [get_simple_text(el) for el in findall(header, 'cpp:evaluators/cpp:evaluator')]

    short_definition = get_simple_text(find(root, 'cpp:shortDefinition'))
    description_and_scope = element_to_markdown(find(root, 'cpp:descriptionAndScope'))
    
    markdown = f"# {label or 'No Label Found'}\n\n"
    if short_definition: markdown += f"**Short Definition:** {short_definition}\n\n"
    if description_and_scope: markdown += f"## Description and Scope\n{description_and_scope}\n\n"
    if authors: markdown += "## Authors\n" + "".join(f"- {author}\n" for author in authors) + "\n"
    if contributors: markdown += "## Contributors\n" + "".join(f"- {contributor}\n" for contributor in contributors) + "\n"
    if evaluators: markdown += "## Evaluators\n" + "".join(f"- {evaluator}\n" for evaluator in evaluators) + "\n"

    process = find(root, 'cpp:process')
    if process:
        markdown += "## Process Definition\n\n"
        
        # General Inputs
        inputs = findall(process, 'cpp:inputs/cpp:data/cpp:dataElement') + findall(process, 'cpp:inputs/cpp:guidance/cpp:guidanceElement')
        if inputs:
            markdown += "**Inputs:**\n"
            for item in inputs:
                markdown += f"- {get_simple_text(item)}\n"
            markdown += "\n"

        # General Outputs
        outputs = findall(process, 'cpp:outputs/cpp:metadata/cpp:metadataElement') + findall(process, 'cpp:outputs/cpp:guidance/cpp:guidanceElement')
        if outputs:
            markdown += "**Outputs:**\n"
            for item in outputs:
                markdown += f"- {get_simple_text(item)}\n"
            markdown += "\n"

        # Trigger Events
        triggers = findall(process, 'cpp:triggerEvents/cpp:triggerEvent')
        if triggers:
            markdown += "**Trigger Events:**\n"
            for trigger in triggers:
                desc = element_to_markdown(find(trigger, 'cpp:description'))
                corr_cpp = get_simple_text(find(trigger, 'cpp:correspondingCPP'))
                markdown += f"- {desc} (see `{corr_cpp}`)\n" if corr_cpp else f"- {desc}\n"
            markdown += "\n"

    steps = findall(process, './/cpp:step') if process else []
    if steps:
        markdown += "## Process Steps\n\n"
        table_data = []
        headers = ["Step", "Description", "Inputs", "Outputs"]
        
        for step in steps:
            desc_md = element_to_markdown(find(step, 'cpp:stepDescription'))
            inputs_md = [element_to_markdown(el) for el in findall(step, 'cpp:input/cpp:inputElement')]
            outputs_md = [element_to_markdown(el) for el in findall(step, 'cpp:output/cpp:outputElement')]
            
            table_data.append({
                "Step": step.get('stepNumber', ""),
                "Description": format_multiline_cell(desc_md),
                "Inputs": format_multiline_cell('<br>'.join(f"- {item}" for item in inputs_md if item)),
                "Outputs": format_multiline_cell('<br>'.join(f"- {item}" for item in outputs_md if item))
            })
        
        markdown += format_markdown_table(headers, table_data) + "\n\n"

    rationale = find(root, 'cpp:rationaleWorstCase')
    if rationale:
        markdown += "## Rationale / Worst Case\n\n"
        headers = ["Purpose", "Worst Case"]
        table_data = [{
            "Purpose": format_multiline_cell(element_to_markdown(find(p, 'cpp:purposeDescription'))),
            "Worst Case": format_multiline_cell(element_to_markdown(find(p, 'cpp:worstCase')))
        } for p in findall(rationale, 'cpp:purpose')]
        markdown += format_markdown_table(headers, table_data) + "\n\n"

    relationships = find(root, 'cpp:cppRelationships')
    if relationships:
        markdown += "## Relationships\n\n"
        headers = ["Type", "Related CPP", "Description"]
        table_data = [{
            "Type": get_simple_text(find(r, 'cpp:relationshipType')),
            "Related CPP": get_simple_text(find(r, 'cpp:relatedCPP')),
            "Description": format_multiline_cell(element_to_markdown(find(r, 'cpp:relationshipDescription')))
        } for r in findall(relationships, 'cpp:relationship')]
        markdown += format_markdown_table(headers, table_data) + "\n\n"

    mappings = find(root, 'cpp:frameworkMappings')
    if mappings:
        markdown += "## Framework Mappings\n\n"
        for mapping in findall(mappings, 'cpp:mapping'):
            framework_name = get_simple_text(find(mapping, 'cpp:frameworkName'))
            markdown += f"- **{framework_name}**\n"
            term = element_to_markdown(find(mapping, 'cpp:correspondingTerm'))
            if term: markdown += f"  - **Term:** {term}\n"
            
            section_element = find(mapping, 'cpp:correspondingSection')
            if section_element is not None:
                section_parts = [element_to_markdown(p) for p in section_element]
                section_text = "\n\n".join(section_parts)
                # Indent every line for proper list formatting
                indented_section = "  - **Section:** " + section_text.replace("\n", "\n    ")
                markdown += f"{indented_section}\n"
        markdown += "\n"

    references = find(root, 'cpp:referenceImplementations')
    if references:
        markdown += "## Reference Implementations\n\n"
        use_cases = findall(references, 'cpp:useCases/cpp:useCase')
        if use_cases:
            markdown += "### Use Cases\n"
            for case in use_cases:
                title = get_simple_text(find(case, 'cpp:useCasetitle'))
                institution_label = get_simple_text(find(case, 'cpp:institution/cpp:institutionLabel'))
                link = element_to_markdown(find(case, 'cpp:linkToDocumentation/cpp:hyperlink'))
                markdown += f"- **{title}**\n"
                markdown += f"  - **Institution:** {institution_label}\n"
                if link: markdown += f"  - **Documentation:** {link}\n"
                problem = element_to_markdown(find(case, 'cpp:problemStatement'))
                solution_raw = element_to_markdown(find(case, 'cpp:proposedSolution'))
                if problem: markdown += f"  - **Problem:** {problem}\n"
                if solution_raw:
                    solution_clean = re.sub(r'\s*\.\.\.\s*$', '', solution_raw) # Remove trailing '...'
                    markdown += f"  - **Solution:**\n```python\n{solution_clean}\n```\n"
            markdown += "\n"

        public_docs = findall(references, 'cpp:publicDocumentation')
        if public_docs:
            markdown += "### Public Documentation\n"
            for doc in public_docs:
                institution_label = get_simple_text(find(doc, 'cpp:institution/cpp:institutionLabel'))
                link = element_to_markdown(find(doc, 'cpp:linkToDocumentation/cpp:hyperlink'))
                comment = get_simple_text(find(doc, 'cpp:linkToDocumentation/cpp:comment'))
                markdown += f"- **{institution_label}**\n"
                markdown += f"  - **Link:** {link}\n"
                if comment: markdown += f"  - **Comment:** {comment}\n"
            markdown += "\n"
                
    return markdown

def main():
    start_dir = '.'
    logging.info(f"Starting script in directory: {os.path.abspath(start_dir)}")
    for root_dir, _, files in os.walk(start_dir):
        # Create one README per directory, assuming one primary XML source
        xml_files_in_dir = [f for f in files if f.endswith('.xml')]
        if xml_files_in_dir:
            # We will generate one README from all XMLs in a directory
            full_markdown = ""
            for file in sorted(xml_files_in_dir): # Sort to ensure consistent order
                 xml_path = os.path.join(root_dir, file)
                 markdown_content = parse_xml_to_markdown(xml_path)
                 if markdown_content:
                     full_markdown += markdown_content + "\n\n---\n\n"

            if full_markdown:
                readme_path = os.path.join(root_dir, 'README.md')
                try:
                    with open(readme_path, 'w', encoding='utf-8') as f:
                        f.write(full_markdown)
                    logging.info(f"Successfully generated {readme_path} from {len(xml_files_in_dir)} XML file(s).\n")
                except IOError as e:
                    logging.error(f"Could not write to file {readme_path}. Error: {e}\n")

if __name__ == "__main__":
    main()
