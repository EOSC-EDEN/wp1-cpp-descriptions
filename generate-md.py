"""
generate-md.py

Script for generation of README.md files for each CPP-XYZ.xml file
"""

import os
import xml.etree.ElementTree as ET
import logging

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
    This version handles both paragraph structure and inline emphasis spacing.
    """
    if element is None:
        return ""

    # This iterator walks through the element's text and its children's text/tails
    parts = []
    # Start with the element's own text. Don't clean it yet.
    if element.text:
        parts.append(element.text)

    # Process each child element
    for child in element:
        tag = child.tag.split('}')[-1]
        child_content = element_to_markdown(child) # Recursive call

        # Apply formatting based on the tag
        if tag == 'p':
            # Paragraphs are block-level. Add newlines BEFORE the content.
            # The content itself is cleaned to handle internal line breaks from the XML source.
            parts.append(f"\n\n{clean_text(child_content)}")
        elif tag == 'em':
            # Emphasis is inline. Just wrap the raw content. No extra spaces or newlines.
            parts.append(f"*{child_content}*")
        elif tag == 'a':
            href = child.get('href', '')
            parts.append(f"[{child_content}]({href})")
        elif tag == 'ul':
            parts.append(f"\n{child_content}")
        elif tag == 'li':
            parts.append(f"\n* {clean_text(child_content)}")
        else: # Default for unknown tags
            parts.append(child_content)
        
        # Append the text that comes AFTER an element.
        if child.tail:
            parts.append(child.tail)
            
    # Join all the pieces together.
    # Then, clean the final string ONLY if we are at the top-level description element.
    # The recursion for <p> tags handles its own cleaning, preserving the \n\n.
    final_string = "".join(parts)

    # Only apply the aggressive clean_text at the block level (inside the <p> case above).
    # The final return for the whole description should be stripped, but not have its newlines collapsed.
    return final_string.strip()


def format_multiline_cell(text):
    """Replaces newlines with <br> for presentation in a Markdown table cell."""
    if not text:
        return ""
    # Convert paragraph breaks and list newlines to <br> tags.
    return text.replace('\n\n', '<br><br>').replace('\n*', '<br>*')


def format_markdown_table(headers, data):
    """Formats data into a perfectly aligned Markdown table without external libraries."""
    if not data:
        return ""

    col_widths = {header: len(header) for header in headers}
    for row in data:
        for header in headers:
            cell_content = row.get(header, "")
            # Find the longest line in case of multi-line content
            max_line_length = max((len(line) for line in cell_content.split('<br>')), default=0)
            col_widths[header] = max(col_widths[header], max_line_length)

    header_line = "| " + " | ".join(header.ljust(col_widths[header]) for header in headers) + " |"
    separator_line = "|:" + ":|:".join("-" * col_widths[header] for header in headers) + ":|"
    data_lines = []
    for row in data:
        row_cells = [row.get(header, "").ljust(col_widths[header]) for header in headers]
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

    # --- Definitive Namespace Handling ---
    ns_map = {}
    if '}' in root.tag:
        uri = root.tag.split('}')[0][1:]
        ns_map = {'ns': uri}

    def get_path(path_str):
        if not ns_map: return path_str
        return '/'.join(['ns:' + tag if tag and not tag.startswith('.') and tag != '*' else tag for tag in path_str.split('/')])

    def find(parent, path):
        if parent is None: return None
        return parent.find(get_path(path), ns_map)

    def findall(parent, path):
        if parent is None: return []
        return parent.findall(get_path(path), ns_map)

    def get_simple_text(element):
        """For simple, single-line text fields where no formatting is desired."""
        if element is not None:
            return clean_text("".join(element.itertext()))
        return ''

    # --- 1. Extract Header Information ---
    header = find(root, 'header')
    if not header:
        logging.warning(f"Could not find <header> element in {xml_file}.")
        label, authors, contributors, evaluators = os.path.splitext(os.path.basename(xml_file))[0], [], [], []
    else:
        label = get_simple_text(find(header, 'label'))
        authors = [get_simple_text(el) for el in findall(header, 'authors/author')]
        contributors = [get_simple_text(el) for el in findall(header, 'contributors/contributor')]
        evaluators = [get_simple_text(el) for el in findall(header, 'evaluators/evaluator')]

    # --- 2. Extract Main Content ---
    short_definition = get_simple_text(find(root, 'shortDefinition'))
    description_and_scope_raw = element_to_markdown(find(root, 'descriptionAndScope'))
    # Clean up the final block of text
    description_and_scope = '\n\n'.join([clean_text(p) for p in description_and_scope_raw.split('\n\n')])
    
    # --- 3. Build Markdown String ---
    markdown = f"# {label or 'No Label Found'}\n\n"
    if short_definition: markdown += f"**Short Definition:** {short_definition}\n\n"
    if description_and_scope: markdown += f"## Description and Scope\n{description_and_scope.strip()}\n\n"
    if authors: markdown += "## Authors\n" + "".join(f"- {author}\n" for author in authors) + "\n"
    if contributors: markdown += "## Contributors\n" + "".join(f"- {contributor}\n" for contributor in contributors) + "\n"
    if evaluators: markdown += "## Evaluators\n" + "".join(f"- {evaluator}\n" for evaluator in evaluators) + "\n"
        
    # --- 4. Process Steps into a Table ---
    steps = findall(root, './/step')
    if steps:
        markdown += "## Process Steps\n\n"
        table_data = []
        headers = ["Step", "Description", "Inputs", "Outputs"]
        
        for step in steps:
            desc_raw = element_to_markdown(find(step, 'stepDescription'))
            desc_md = '\n\n'.join([clean_text(p) for p in desc_raw.split('\n\n')])

            inputs_raw = [element_to_markdown(el) for el in findall(step, 'input/inputElement')]
            inputs_md = ['\n\n'.join([clean_text(p) for p in item.split('\n\n')]) for item in inputs_raw]

            outputs_raw = [element_to_markdown(el) for el in findall(step, 'output/outputElement')]
            outputs_md = ['\n\n'.join([clean_text(p) for p in item.split('\n\n')]) for item in outputs_raw]
            
            table_data.append({
                "Step": step.get('stepNumber', ""),
                "Description": format_multiline_cell(desc_md),
                "Inputs": format_multiline_cell('<br>'.join(f"- {item}" for item in inputs_md if item)),
                "Outputs": format_multiline_cell('<br>'.join(f"- {item}" for item in outputs_md if item))
            })
        
        markdown += format_markdown_table(headers, table_data) + "\n\n"
    else:
        logging.warning(f"No <step> elements found in {xml_file}.")
                
    return markdown

def main():
    """Main function to find XML files and generate a README.md in each directory."""
    start_dir = '.'
    logging.info(f"Starting script in directory: {os.path.abspath(start_dir)}")
    for root_dir, _, files in os.walk(start_dir):
        for file in files:
            if file.endswith('.xml'):
                xml_path = os.path.join(root_dir, file)
                markdown_content = parse_xml_to_markdown(xml_path)
                if markdown_content:
                    readme_path = os.path.join(root_dir, 'README.md')
                    try:
                        with open(readme_path, 'w', encoding='utf-8') as f: f.write(markdown_content)
                        logging.info(f"Successfully generated {readme_path}\n")
                    except IOError as e:
                        logging.error(f"Could not write to file {readme_path}. Error: {e}\n")

if __name__ == "__main__":
    main()