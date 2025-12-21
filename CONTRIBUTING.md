
# Contributing to Core Preservation Processes

Thank you for your interest in contributing to this repository. This guide outlines how digital preservationists can help elaborate and improve our core preservation processes documentation.

## Ongoing work

The T1.2 core task group is currently working on the following tasks, currently developped in the [`dev` branch](https://github.com/EOSC-EDEN/wp1-cpp-descriptions/tree/dev):

1. A machine-actionable CPP expression. While CPPs were intially produced as word-processing documents and published as PDFs, we plan to maintain them as machine-readable data, which may be used as the basis for the [visualisation tool](https://github.com/EOSC-EDEN/wp1-cpp-visualization).
2. Transformation scripts to create human-readable derivatives:
    * A [python script](https://github.com/EOSC-EDEN/wp1-cpp-descriptions/blob/dev/generate-md.py) that generates Markdown files from all XML files - see [instructions for using the python script](https://github.com/EOSC-EDEN/wp1-cpp-descriptions/blob/dev/README.md#generating-md-formatted-documents);
    * An [XSL transformation script](https://github.com/EOSC-EDEN/wp1-cpp-descriptions/blob/dev/cpp2html.xsl) that generates HTML pages from a specific XML file - see [instructions for running the XSLT](https://github.com/EOSC-EDEN/wp1-cpp-descriptions/blob/dev/README.md#generating-html-documents).

In addition, the task group is revising CPPs through process analysis in order to create BPMN diagrams for each of them. Those will be incorporated into their next version.

## Branch Policy

The `main` branch is meant to be a “clean” one, where only the changes that are validated by the project leads are visible. The [`dev` branch](https://github.com/EOSC-EDEN/wp1-cpp-descriptions/tree/dev) hosts all shared experiments that will or will not be maintained.

## How to Contribute

We welcome the following contributions:

* [Suggest new CPPs or changes to the scope of existing CPPs](https://github.com/EOSC-EDEN/wp1-cpp-descriptions/discussions/categories/general)
* [Submit an idea to improve the general CPP structure and content](https://github.com/EOSC-EDEN/wp1-cpp-descriptions/discussions/categories/ideas-on-cpp-structure-and-content)
* [Submit an idea on how to use CPPs](https://github.com/EOSC-EDEN/wp1-cpp-descriptions/discussions/categories/ideas-on-cpp-usage)
* [Propose a new reference implementation that document how a specific process is carried out in a specific institution](https://github.com/EOSC-EDEN/wp1-cpp-descriptions/discussions/new?category=suggest-a-reference-implementation)
* [Propose a new use case that describes how a process applying to a particular object was handled](https://github.com/EOSC-EDEN/wp1-cpp-descriptions/discussions/categories/suggest-a-use-case)
* [Ask any question about CPPs](https://github.com/EOSC-EDEN/wp1-cpp-descriptions/discussions/categories/q-a)
* Correct minor typos and grammatical issues;
* Suggest an improvement to the python or XSLT scripts;

### Questions?

If you want to submit a free-text description of the changes you can do it in the following ways:
* Create a entry in the [Discussion tab](https://github.com/EOSC-EDEN/wp1-cpp-descriptions/discussions) to discuss major issues or important changes before investing significant effort.
* Any minor issue you'd like to report? Open an [issue](https://github.com/EOSC-EDEN/wp1-cpp-descriptions/issues)!

### Direct Contribution: Initial Steps

If you are inclined to do so, you can suggest changes to the content of this repository through Git pull requests:
- If you are not among the repository owners, fork this repository;
- Clone your fork locally;
- Create a feature branch for your changes based on the `dev` branch.

### Pull Request Process

- Provide context for your changes in the pull request description;
- Link related issues, if relevant;
- Ask for merging into the `dev` branch;
- Require a review from one or several of the repository owners, in particular [Kris Dekeyser](https://github.com/Kris-LIBIS), [MattiasLevlinCSCfi](https://github.com/MattiasLevlinCSCfi) or [Bertrand Caron](https://github.com/BertrandCaron).

### For Repository Owners: Merging Process

- Prefer the "Squash and merge" option to merge multiple commits in a single one.