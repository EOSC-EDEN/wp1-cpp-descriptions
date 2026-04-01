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

### Updating the CPP Descriptions

- Mind the italics in the original text: they indicate terms that are defined in the [glossary](03_Glossary.pdf). Enclose these terms in `<em>` elements.
- Do not forget to add a `<version>` element to the `<history>` container, incrementing the version number and describing briefly the nature of your modification. The nature of your modification will condition the version number in the following way:
   * **Major version**  
      * Significant changes to inputs, outputs, or relationships  
      * Significant changes to the overall scope or high-level description  
      * Significant changes to the step-by-step process  
   * **Minor version**  
      * Minor change to the high-level description  
      * Migration from the editing environment to a structured XML-based expression  
      * Addition of a BPMN diagram without major semantic changes to the step-by-step description  
      * Addition of a use case, reference implementation, or rationale  
      * Addition to the scope and description section to facilitate understandability  
   * **Patch version**  
      * Linguistic revision to enhance understandability  
      * Format and layout changes  
      * Typographical or spelling corrections  
      * Minor editorial adjustments (punctuation, line breaks, headings)

### Pull Request Process

- Provide context for your changes in the pull request description;
- Link related issues, if relevant;
- Ask for merging into the `dev` branch;
- Require a review from one or several of the repository owners, in particular [Kris Dekeyser](https://github.com/Kris-LIBIS), [MattiasLevlinCSCfi](https://github.com/MattiasLevlinCSCfi) or [Bertrand Caron](https://github.com/BertrandCaron).

### Checking the XML file

There is a XSD schema available that describes how a valid CPP XML should look like. You can check the validity of a CPP XML file using that XSD. For example using the [xmllint](https://linux.die.net/man/1/xmllint) tool:

```
# In the root of the repository clone, run
xmllint --quiet --noout --schema cpp.xsd CPP-001/cpp-001.xml
```

Using an XML editor that supports the validation agains XSD schema, you can use the XSD to help you while editing the XML file. For instance with Visual Studio Code, the `XML Language Support by Red Hat` extension guides you in selecting valid sub-elements and content and displays validation errors in-line.

### Markdown derived document generation

While working on a CPP's XML file locally, you can convert the XML file to Markdown by using the `generate-md.py` Python script. The script will take as input all `cpp-*.xml` files in each `CPP-*` folder, and output them as `README.md` in that same folder:

```python
# In the root of the repository clone, run
python generate-md.py
```

### HTML derived document generation

The HTML derived document uses the XSL transformation file `cpp2html.xsl` for transforming the original XML into its HTML representation.

In order to generate an HTML version from the CPP XML files, you can use any XSL processor (Saxon, Xalan, etc.). In the example below, the [xsltproc](https://linux.die.net/man/1/xsltproc) is used:

```
# In the root of the repository clone, run
xsltproc cpp2html.xsl CPP-009/cpp-009.xml > cpp-009.html
```

### Alternative HTML layout

Because the step-by-step description table was originally created on a landscape oriented page, the table is bit cramped in the HTML version. In order to improve the readability in the HTML version, an - experimental - alternative layout is provided. It can be activated by editing the `cpp2html.xsl` file:

- search the line containing `<xsl:call-template name="stepTable">`
- replace it with `<xsl:call-template name="stepTableHTML">`
- rerun the XML to HTML conversion and inspect the output

### Github automation

Using Github actions, we have automated the validation of the XML files and the generation of the derived Markdown and HTML files. The validation will happen on each push to the Pull Request of a CPP XML (so essentially when a new XML file is submitted or a change to an existing XML is comitted and pushed). After a Pull Request is merged, the Github repository will (re-)generate the Markdown and HTML derivatives and commit them to the repository in the proper place and with the proper name.

While you can generate the derived files locally for your own purpose as much as you want, **we advise against committing these derived files in your Pull Request**. In fact, you will probably be asked to remove them before the PR can be approved.

### For Repository Owners: Merging Process

- Prefer the "Squash and merge" option to merge multiple commits in a single one. Also the source branch can be removed after successfully merging the PR.
