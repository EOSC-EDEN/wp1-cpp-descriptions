import os
import xml.etree.ElementTree as ET

def clean_text(text):
    """Remove extra whitespace and newline characters from text."""
    return ' '.join(text.strip().split()) if text else ''

def parse_xml_to_markdown(xml_file):
    """Parse an XML file and convert it to a Markdown string."""
    try:
        tree = ET.parse(xml_file)
        root = tree.getroot()
    except ET.ParseError as e:
        return f"Error parsing XML file: {e}"

    ns = {'cpp': 'https://eden-fidelis.eu/cpp/cpp/'}

    # Helper function to find all text in an element, including nested tags
    def get_all_text(element):
        text = ''
        if element is not None:
            text = ''.join(element.itertext()).strip()
        return clean_text(text)

    # Extracting header information
    label = get_all_text(root.find('cpp:header/cpp:label', ns))
    authors = [get_all_text(author) for author in root.findall('cpp:header/cpp:authors/cpp:author', ns)]
    contributors = [get_all_text(contributor) for contributor in root.findall('cpp:header/cpp:contributors/cpp:contributor', ns)]
    evaluators = [get_all_text(evaluator) for evaluator in root.findall('cpp:header/cpp:evaluators/cpp:evaluator', ns)]

    # Extracting main content
    short_definition = get_all_text(root.find('cpp:shortDefinition', ns))
    description_and_scope = get_all_text(root.find('cpp:descriptionAndScope', ns))
    
    # Start building the Markdown string
    markdown = f"# {label}\n\n"
    markdown += f"**Short Definition:** {short_definition}\n\n"
    markdown += f"## Description and Scope\n{description_and_scope}\n\n"

    # Add authors, contributors, and evaluators if they exist
    if authors:
        markdown += "## Authors\n"
        for author in authors:
            markdown += f"- {author}\n"
        markdown += "\n"

    if contributors:
        markdown += "## Contributors\n"
        for contributor in contributors:
            markdown += f"- {contributor}\n"
        markdown += "\n"

    if evaluators:
        markdown += "## Evaluators\n"
        for evaluator in evaluators:
            markdown += f"- {evaluator}\n"
        markdown += "\n"
        
    # Process steps
    steps = root.findall('.//cpp:step', ns)
    if steps:
        markdown += "## Process Steps\n\n"
        for step in steps:
            step_number = step.get('stepNumber')
            step_description = get_all_text(step.find('cpp:stepDescription', ns))
            
            markdown += f"### Step {step_number}\n"
            markdown += f"{step_description}\n\n"

            # Inputs for the step
            inputs = step.findall('cpp:input', ns)
            if inputs:
                markdown += "**Inputs:**\n"
                for i in inputs:
                    input_element = get_all_text(i.find('cpp:inputElement', ns))
                    markdown += f"- {input_element}\n"
                markdown += "\n"

            # Outputs for the step
            outputs = step.findall('cpp:output', ns)
            if outputs:
                markdown += "**Outputs:**\n"
                for o in outputs:
                    output_element = get_all_text(o.find('cpp:outputElement', ns))
                    markdown += f"- {output_element}\n"
                markdown += "\n"
                
    return markdown

def main():
    """Main function to find XML files and generate README.md."""
    # Walk through the current directory and all subdirectories
    for root_dir, _, files in os.walk('.'):
        for file in files:
            if file.endswith('.xml'):
                xml_path = os.path.join(root_dir, file)
                markdown_content = parse_xml_to_markdown(xml_path)
                
                # Write the markdown content to a README.md file in the same directory
                with open(os.path.join(root_dir, 'README.md'), 'w', encoding='utf-8') as f:
                    f.write(markdown_content)
                print(f"Generated README.md for {xml_path}")

if __name__ == "__main__":
    main()