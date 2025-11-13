# File Format Validation

**Short Definition:** The TDA validates Files against File format specifications.

## Description and Scope
File Format validation is the process of checking a *File*’s structure against the specifications of the format it purports to be, or it was identified as in File Format Identification (CPP-008). In addition to *file* structure, validation generally encompasses internal integrity checks to verify that the File is not truncated and that each of its components are intact (e.g. by using internal *Metadata* like CRC checksums of the frames, or size of the data streams).

Erroneous format structures have many different causes. Some examples are listed below: * Improper behaviours of creation software (e.g. InDesign, in some previous versions, was known to export corrupted PDFs); * Partial or failed transfers (e.g. digital photographs transferred through an unstable Bluetooth connection); * Edition with a different software than the creation tool (e.g. PDFs produced with pdfTeX, then edited with Quark XPress).

The TDA validation policy should define the following aspects for each format: * Tool(s) used to validate the *File*. Since validation tools may produce false positives and false negatives, combining multiple tools - if possible - is suggested depending on the complexity of the format - PDF, in particular, is a very complex format for which validation tools may return very different results. * Tool settings (e.g. strict or relaxed mode, verbosity, etc.); * Severity rating of the issue; * Guidelines for validation error handling.

The scope of format validation is limited to the conformance of the File against the structures as described in the format specification. It does not assess the quality of the information conveyed by the *File*. Thus, it is only one aspect of quality assurance, which can be automated or done manually. Although most of the File Format Validation process described in this CPP can be automated, human intervention is mandatory if the validity status of the File is “invalid”

Some tools (e.g. [JHOVE](https://jhove.openpreservation.org/) follow the XML validation logic and differentiate “well-formedness” (i.e. the *File* conforms to purely syntactic requirements) and “validity” (i.e. the *File* also complies with semantic requirements). In addition, tools may return additional information or warnings, e.g. if unrecognised or private chunks are found in the *File*. In such cases,the output of a validation process should include some additional free-text besides a short controlled term (e.g. “well-formed and valid”, “well-formed but not valid”, “not well-formed”)..

This CPP does not prescribe the action the TDA should undertake if File Format Validation returns errors, but rather includes fallback solutions, such as 1) ingesting the *File* as it is with warnings, 2) requesting a new delivery or searching for a suitable replacement, or 3) trying to repair the *File* (by triggering CPP-027 File Repair). One of these solutions should generally be preferred over rejecting the *Object*.

Format validation is a recommended process to detect potential risks caused by incorrect format structures. However, its application must be carefully evaluated based on organisational capacities and the digital Objects of investigation (see on this subject Paul Wheatley’s blog post “A valediction for validation?”, 11 October 2018, available at [https://www.dpconline.org/blog/a-valediction-for-validation](https://www.dpconline.org/blog/a-valediction-for-validation)). Depending on organisational capacities, and the control the TDA has over digital Objects (indeed, the TDA may be able to require new, valid Files from a digitisation contractor or a depositor subject to legal deposit; on the other hand, it may be impossible for a private donor to meet the requirements for valid Files), it may decide to not perform File Format Validation due to: * The lack of suitable tool(s), in particular for proprietary formats; * The lack of skilled staff to handle errors returned by the process.

## Authors
- Bertrand Caron

## Contributors
- Kris Dekeyser

## Evaluators
- Matthew Addis
- Maria Benauer
- Laura Molloy

## Process Definition

**Inputs:**
- File
- File format specification
- File format policy - Validation

**Outputs:**
- Provenance metadata (Validity status)
- Technical Metadata
- Errors and Warnings

**Trigger Events:**
- Ingest (see `CPP-029`)
- Re-run of format validation because of the release of a new validation tool or tool version
                    

(Because validation tools may evolve, especially for complex formats, re-assessing the validity of files already in storage is advised.)
- Re-run of format identification and discrepancy between previous and current result (see `CPP-008`)

## Process Steps

| Step | Inputs                                                                                                                                    | Description                                                                                                                                                   | Outputs                                                                                                                                                                                      |
| :--- | :---------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1    | - File format identifier<br>- Technical metadata<br>- File format policy - Validation                                                     | According to input, select the right tool(s) to perform format validation. If the provided Metadata is not sufficient, perform CPP-009 (Metadata extraction). | - [Validation tool(s)](https://coptr.digipres.org/index.php/Validation)<br>                        <br><br>(Format validation is generally performed by a single tool. Nevertheless, for some complex formats like PDF, TDAs may want to use more than one tool to identify possible structure errors.) |
| 2    | - *File*<br>- [Validation tool(s)](https://coptr.digipres.org/index.php/Validation); as a default, reference parsing tools associated with the format | Apply the validation tools(s)                                                                                                                                 | - Raw validation output<br>- Errors and warnings                                                                                                                                             |
| 3    | - Errors and warnings<br>- Raw validation output                                                                                          | Check validity status                                                                                                                                         | - Confirm Validity status (step 4)<br>- Invalid file detected (step 3a)                                                                                                                      |
| 3a   | - Errors and warnings<br>- Validity status<br>- File format specification                                                                 | Conduct technical analysis (e.g. rendition and other uses of the File, comparison with the file format specification, etc.)                                   | - Results of manual tests                                                                                                                                                                    |
| 3b   | - Results of manual tests                                                                                                                 | Assess and choose one among the following outputs (in the given order)                                                                                        | - Retain the File as it is<br>- Find another valid Representation (e.g. by establishing contact with the producer)<br>- Trigger File Repair to correct the file structure<br>- Reject the *Object* |
| 4    |                                                                                                                                           | Document the process                                                                                                                                          | - Provenance metadata                                                                                                                                                                        |

## Rationale / Worst Case

| Purpose                                                                                                                                                                                                  | Worst Case |
| :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------- |
| Format validation may identify structural errors that would cause issues when attempting to render or transform the *File*. In particular, truncated *File* can be identified by File Format Validation. | /          |

## Relationships

| Type                    | Related CPP | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| :---------------------- | :---------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Requires                | CPP-008     | File Format Validation requires a specialised tool. In general, the result of File Format Identification is enough to determine which tool should be used.                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| May require             | CPP-009     | Depending on the precision of the format registry used in the File Format Identification process, the resulting information may be insufficient for selecting the right validation tool. In such cases, additional Metadata from an extraction tool may be required. For example, if an organisation uses Unix File as its identification tool, which does not distinguish between different PDF “flavours”, and wants to validate PDF/A against the PDF/A standard. In that case, metadata extraction will be necessary to identify the conformance level and select veraPDF as the suitable validation tool. |
| Required by             | CPP-013     | File Format Validation reports essential information on the well-formedness and validity of the Objects; validation errors; and data on the tools used in the process.                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Required by             | CPP-014     | File Format Validation should be undertaken after File Migration was performed to ensure that the target *File(s)* or *Representation(s)* are valid..                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| Required by             | CPP-015     | In order to have a decent level of confidence in the rendering process, the file format needs to be validated.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Required by             | CPP-023     | Risks can be related to specific file format erroneous structures                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| Required by             | CPP-027     | File Repair is generally triggered by File Format Validation and is one of several ways to handle errors from this CPP.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| May be required by      | CPP-029     | A TDA may validate the format of the submitted Files in the ingest phase.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Not to be confused with | CPP-007     | Both processes scan the Files to ensure that they are suitable for preservation. File Format Validation checks if a File conforms to its purported format specification (e.g. is this a valid PDF/A File?), while Virus Scanning checks for malware, regardless of format validity.                                                                                                                                                                                                                                                                                                                            |
| Not to be confused with | CPP-008     | File Format Identification is only about identifying the format while File Format Validation describes full scanning of the File to ensure it complies with the format standard.                                                                                                                                                                                                                                                                                                                                                                                                                               |

## Framework Mappings

- **CoreTrustSeal**
  - **Section:** CTS does not explicitly mention format validation but it is in the scope of section Quality Assurance (R10) and understood as one of the “quality control checks in place to ensure the completeness and understandability of data”.
- **Nestor Seal**
  - **Section:** Format validation is not explicitly mentioned by Nestor Seal but is in scope of C21 “Submission Information Packages”; in particular, in the question “Which measures exist for validating the conformity of submission information packages?”.
- **ISO 16363**
  - **Term:** “checking that file formats are what they claim to be”
  - **Section:** Section 4.1.5: “The repository shall have an ingest process which verifies each SIP for completeness and correctness”
- **OAIS**
  - **Term:** “validation of SIP data”
  - **Section:** This operation is also in scope of what OAIS calls “validation of SIP data” in section 2.6.3 “Producer interaction”, where the standard suggests that the “validity” of SIPs are negotiated between the producer and the archive.
- **PREMIS**
  - **Term:** (Format) validation
  - **Section:** Section: "Non-core metadata", subsection: "Quirks and anomalies" (p. 262).
    
    Section: "Fixity, integrity, authenticity", p. 258.

## Reference Implementations

### Use Cases
- **Format validation of born-digital sound**
  - **Institution:** Bibliothèque nationale de France
  - **Problem:** BnF decided to validate *Files* to identify transfer issues. However, the substantial volume of data and the considerable processing time have presented significant challenges to the performance and scalability of the validation operation.
  - **Solution:**
```python
FLAC *Files* are verified with the [flac command-line tool](https://xiph.org/flac/documentation_tools_flac.html), which ensures both the overall *File*'s internal integrity and that of every individual frame within the audio stream. This is achieved through calculation of the CRC32 checksum for each frame. As this process is labour-intensive, the choice was made to do it by sampling.
                    

As the producer is generally a major label with trained professionals in the domain of audio data, the chosen error handling method is to request a new, hopefully valid *File*.
```

### Public Documentation
- **TIB – Leibniz Information Centre for Science and Technology and University Library**
  - **Link:** https://wiki.tib.eu/confluence/spaces/lza/pages/93608618/Ingest
- **CSC – IT Center for Science Ltd.**
  - **Link:** https://urn.fi/urn:nbn:fi-fe2025040925236
  - **Comment:** section 5.2
- **Archivematica**
  - **Link:** https://www.archivematica.org/en/docs/archivematica-1.17/user-manual/preservation/preservation-planning/#characterization



---

