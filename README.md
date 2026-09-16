# wp1-cpp-descriptions

This repository contains the descriptions of the 30 Core Preservation Processes developped by the [EOSC EDEN Project](https://eden-fidelis.eu/). It serves as the maintenance platform for the documents accessible on the CPP website: **https://eosc-eden.github.io/cpps**. 

## Contributing

Feedback is sought by the CPP maintainers both on the structure and the content of the CPP descriptions. Please then refer to the [contribution instructions](CONTRIBUTING.md).

## Source files and formats in the repository

The source file of each CPP a single XML file. The XML file lives in a subdirectory named after the CPP-Identifier in upper case. The source file itself has also the name of the CPP-Identifier, but this time in lower case. The file extension is `.xml`. For example, CPP-001's source document is `/CPP-001/cpp-001.xml`.

From that XML file, several derivative files are produced:
* An HTML page, located in the `docs`repository, is served to readers who visit the CPP descriptions in the website at https;//eosc-eden.github.io/wp1-cpp-descriptions/.
* A PDF file is generated and downloadable from each CPP description webpage.
* A Markdown file named `README.md`, that resides next to the CPP's XML file, is automatically displayed when the CPP directory is opened in github.