import os
import xml.etree.ElementTree as ET
import logging

# --- Setup basic logging ---
logging.basicConfig(
    level=logging.INFO,
    format='%(levelname)s: %(message)s'
)

def clean_text(text):
    """A lighter touch cleaner that preserves intentional whitespace for lists."""
    return ' '.join(text.strip().split()) if text else ''

def element_to_markdown(element):
    """
    Recursively converts an XML element and its children to a Markdown string,
    preserving paragraphs, lists, links, and emphasis.
    """
    if element is None:
        return ""

    markdown_parts = []

    # Start with the element's own text (text before the first child)
    if element.text:
        markdown_parts.append(clean_text(element.text))

    # Process each child element
    for child in element:
        # Get the tag name without the namespace
        tag = child.tag.split('}')[-1]
        
        # Recursively get the content of the child
        child_content = element_to_markdown(child)

        # Apply formatting based on the tag
        if tag == 'p':
            markdown_parts.append(f"\n\n{child_content}")
        elif tag == 'em':
            markdown_parts.append(f"*{child_content}*")
        elif tag == 'a':
            href = child.get('href', '')
            markdown_parts.append(f"[{child_content}]({href})")
        elif tag == 'ul':
            markdown_parts.append(f"\n{child_content}")
        elif tag == 'li':
            markdown_parts.append(f"\n* {child_content}")
        else: # Default for unknown tags
            markdown_parts.append(child_content)

        # Append the text that comes *after* the child element (its tail)
        if child.tail:
            markdown_parts.append(clean_text(child.tail))
            
    # Join all parts and clean up resulting whitespace
    return ''.join(markdown_parts).strip()


def format_multiline_cell(text):
    """Replaces newlines with <br> for presentation in a Markdown table cell."""
    if not text:
        return ""
    # Convert paragraph breaks and list newlines to <br> tags
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
    Parses a single XML file and converts it to a Markdown string, now with
    rich text formatting for content fields.
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

    # --- 2. Extract Main Content (using the new rich text parser) ---
    short_definition = get_simple_text(find(root, 'shortDefinition'))
    description_and_scope = element_to_markdown(find(root, 'descriptionAndScope'))
    
    # --- 3. Build Markdown String ---
    markdown = f"# {label or 'No Label Found'}\n\n"
    if short_definition: markdown += f"**Short Definition:** {short_definition}\n\n"
    if description_and_scope: markdown += f"## Description and Scope\n{description_and_scope}\n\n"
    if authors: markdown += "## Authors\n" + "".join(f"- {author}\n" for author in authors) + "\n"
    if contributors: markdown += "## Contributors\n" + "".join(f"- {contributor}\n" for contributor in contributors) + "\n"
    if evaluators: markdown += "## Evaluators\n" + "".join(f"- {evaluator}\n" for evaluator in evaluators) + "\n"
        
    # --- 4. Process Steps into a Table (using the new rich text parser) ---
    steps = findall(root, './/step')
    if steps:
        markdown += "## Process Steps\n\n"
        table_data = []
        headers = ["Step", "Description", "Inputs", "Outputs"]
        
        for step in steps:
            # Parse the rich text content first
            desc_md = element_to_markdown(find(step, 'stepDescription'))
            inputs_md = [element_to_markdown(el) for el in findall(step, 'input/inputElement')]
            outputs_md = [element_to_markdown(el) for el in findall(step, 'output/outputElement')]
            
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