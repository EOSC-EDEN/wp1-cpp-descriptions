# Ingest

**Short Definition:** The TDA performs all operations necessary to transform an SIP into an AIP.

## Description and Scope
Ingest is a high-level CPP, that is composed of or utilised by many other CPPs, and refers to the process of acquiring and incorporating data into a TDA. In its most abstract form, Ingest describes the process in which a TDA receives a *SIP* and transforms it into one or several *AIP*(s) through a process that includes **Data Quality Assessment** (CPP-019). At the end of a successful ingest, the data is preserved in the TDA for future use.

The Ingest process begins with the transfer of digital *Object*s and *Metadata* from their source environment to the TDA in the form of a *SIP*. The digital preservation workflow triggered by the submission ensures that the data is properly prepared for long-term storage, discovery and access. The workflow ensures that essential *Metadata* about the creation, structure, and context (CPP-016 **Metadata Ingest and Management**) of the data exists. *Fixity metadata* that will be essential for future preservation actions must also exist before the data can be preserved. In addition, *Technical metadata* that could not be easily extracted (e.g. column delimiters for CSV, quality assessment for OCR, or EPUB *File*s etc.) from the *File*s by the TDA may be required to be supplied by the producer.

**Data Quality Assessment** (CPP-019) measures are integrated throughout the ingest workflow to catch potential issues early. This includes **Virus Scanning** (CPP-007), **File Format Identification** (CPP-008), **Metadata Extraction** (CPP-009) and **File Format Validation** (CPP-010), and completeness checks to ensure that the digital *Object*s are suitable for preservation. The TDA verifies that transferred *Object*s are complete and uncorrupted through **Checksum Validation** (CPP-002). The process also involves assessing whether the digital *Object*s conform to the repository's technical requirements and collection development policies. Depending on the TDA’s file format policy - preferred formats, *Object*s may also need to be normalised (CPP-026 **File Normalisation**) to preferred formats before or during the ingest process. During the ingest process, the TDA can generate additional *Metadata* and assign identifiers (CPP-005 Identifier Management) to support **Enabling Discovery** (CPP-024); perform **Enabling Access** (CPP-025) for cataloging purposes; and generate *Provenance metadata* that documents the transfer and processing history of the *Object*s. In order to evaluate the *SIP* and its contents, the TDA ensures that the *SIP* structure is valid and that the *SIP* is not incomplete (i.e. all *Object*s and *Metadata* are present).

*SIP*s that conform to the TDAs requirements and policies are transformed into *AIP*s which are sent to preservation in the archival storage of a TDA. *SIP*s that do not conform to the TDAs requirements will be handled according to its policies (in particular, file format policy and validation policy). The TDA can either reject the submitted data, ask the producer to address the issues before proceeding, flag the data as problematic and ingest it as it is, or perform an operation to address the identified issues.

## Authors
- Mikko Laukkanen
- Johan Kylander

## Contributors
- Bertrand Caron
- Mattias Levlin

## Evaluators
- Felix Burger
- Maria Benauer
- Kris Dekeyser

## Process Definition

### Inputs

| Type     | Input                          |
| :------- | :----------------------------- |
| Data     | SIP                            |
| Metadata | Fixity metadata                |
| Metadata | Descriptive metadata           |
| Metadata | Provenance metadata (Optional) |
| Metadata | Technical metadata (Optional)  |
| Metadata | Rights metadata (Optional)     |
| Guidance | Packaging policy               |

### Outputs

| Type     | Output              |
| :------- | :------------------ |
| Metadata | Provenance metadata |
| Metadata | Technical metadata  |
| Metadata | Rights metadata     |
| Guidance | Packaging policy    |

### Trigger Events

| Description                 | Corresponding CPP |
| :-------------------------- | :---------------- |
| Submission of data to a TDA |                   |

## Process Steps

| Step  | Supplier(s) | Input(s)                                                                                                                                           | Description                                                                                                                                                                                                                                | Output(s)                                                            | Customer(s) |
| :---- | :---------- | :------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------- | :---------- |
| 1     | `CPP-008`   | - Digital *Object*s<br>                            <br>                            *Metadata* provided by the producer                             | Pre-ingest actions (normalisation, metadata generation, identifier generation etc.) and *SIP* creation performed by the producer                                                                                                           | - *SIP*                                                              | `CPP-005`   |
| 2     |             | - *SIP*                                                                                                                                            | Submission of data to a TDA (*SIP* transfer)                                                                                                                                                                                               |                                                                      |             |
| 3     |             | - *SIP*                                                                                                                                            | Identify whether the *SIP* is meant to create a new *AIP* or is intended to update one or several *AIP*s E.g. If the *SIP* has a Producer identifier that already corresponds to an *AIP* ingested in the system, proceed with the process | - Updating request                                                   | `CPP-021`   |
| 4     |             | - *SIP*<br>- Packaging Policy                                                                                                                      | Ensure that the *SIP* structure conforms to the requirements and that its contents are not missing                                                                                                                                         | - Valid and complete *SIP*                                           |             |
| 5     | `CPP-002`   | - *File*s in the *SIP*                                                                                                                             | Perform checksum validation on each *File* in the *SIP*                                                                                                                                                                                    | - *Information package* with fixity checked                          |             |
| 6     | `CPP-019`   | - Quality assessment report<br>- *SIP*                                                                                                             | Quality assessment (ensuring that the submitted data conforms to requirements set by the TDA)                                                                                                                                              | - *Information package* with assessed quality<br>- Result of the quality assessment recorded as *Provenance metadata* |             |
| 7     | `CPP-008`   | - *SIP*                                                                                                                                            | Perform *File* Format Identification, *Metadata* Extraction, and Virus Scanning                                                                                                                                                            | - *Technical metadata*<br>- *Provenance metadata*                    |             |
| 8     | `CPP-010`   | - Format policy - Validation<br>                            <br>                            *File*s in the *SIP*                                   | Perform Format Validation if the TDAs format policy states that validation must be performed                                                                                                                                               | - *Technical metadata*<br>- *Provenance metadata*                    |             |
| 9     | `CPP-020`   | - *Object*s in the *SIP*<br>                            <br>                            Rights assessment                                          | Perform rights assessment on *Object*s contained in the *SIP*                                                                                                                                                                              | - *Rights metadata*                                                  |             |
| 10    | `CPP-016`   | - *Metadata* provided by the producer<br>                            <br>                            *Technical metadata*<br>                            <br>                            *Provenance metadata*<br>                            <br>                            *Rights metadata* | Record the *Metadata* provided by the producer and produced by the TDA according to the TDAs *SIP* requirements and policy of automatic enrichment of *SIP* *Metadata*                                                                     | - *Information package* with *Metadata* recorded                     |             |
| 11    | `CPP-005`   | - Identifier                                                                                                                                       | Assign identifier to the *Information package*                                                                                                                                                                                             | - *Information package* with Identifier assigned                     |             |
| 12    | `CPP-026`   | - *File*s in the *SIP*                                                                                                                             | Optional (only if the TDA supports normalisation during ingest): Normalisation of data, including documenting the actions                                                                                                                  | - New *Representation*s in a supported format<br>- *Provenance metadata* |             |
| 13    | `CPP-028`   | - *File*s in the *SIP*                                                                                                                             | (only if the TDA supports creating derivatives during ingest): Generation of derivatives Optional                                                                                                                                          | - New additional *Representation*s                                   |             |
| 14a.1 |             | - *Information package* with fixity checked, identifier assigned, quality assessed, *Metadata* recorded and optionally new *Representation*s added | If *SIP* conforms to the requirements (steps 7a and 7b): *SIP* transformation to *AIP*                                                                                                                                                     | - *AIP*                                                              |             |
| 14a.2 |             | - *AIP*                                                                                                                                            | Move the *AIP* to the archival storage                                                                                                                                                                                                     | - *AIP* on multiple locations                                        | `CPP-011`   |
| 14b   |             | - Error-handling policies (in particular file format policy and validation policy)                                                                 | If *SIP* doesn’t conform to the requirements, perform one of these actions:<br>                                    (a) Rejection of *SIP*;<br>                                    (b) Request the producer to address the issues;<br>                                    (c) Flag the data as problematic and ingest it as it is;<br>                                    (d) Perform an operation to address the identified issues. | - Error report to the submitter of the *SIP* (producer)<br>- Trigger technical analysis |             |
| 15    |             |                                                                                                                                                    | Notification / report to the producer about the outcome of the ingest                                                                                                                                                                      | - Ingest report                                                      |             |

## Rationale / Worst Case

| Purpose                                                        | Worst Case                                                          |
| :------------------------------------------------------------- | :------------------------------------------------------------------ |
| Ingest transfers the responsibility from<br>                    the creator/owner/depositor of the<br>                    digital *Object*s to the TDA, enabling<br>                    long-term preservation, discovery and<br>                    access to the digital *Object*s. Also, the<br>                    ingest process captures the *Object*s’<br>                    state at the time of transfer through<br>                    checksums, metadata extraction, and<br>                    documentation of the transfer process<br>                    itself. This creates an auditable trail<br>                    that supports future authenticity claims<br>                    and helps detect any corruption or<br>                    unauthorised modifications that may<br>                    occur over time. | The digital *Object*s remain vulnerable to loss,<br>                    corruption, or unauthorised changes in their<br>                    original environment. Furthermore, *Object*s in<br>                    their original environments are often stored in<br>                    formats, structures, or contexts that are not<br>                    optimal for long-term preservation. |

## Relationships

| Type               | Related CPP | Description                                                                                    |
| :----------------- | :---------- | :--------------------------------------------------------------------------------------------- |
| Requires           | CPP-002     | Must be performed during ingest.                                                               |
| Requires           | CPP-005     | Must be performed during ingest.                                                               |
| Requires           | CPP-007     | Must be performed during ingest.                                                               |
| Requires           | CPP-008     | Must be performed during ingest.                                                               |
| Requires           | CPP-009     | Must be performed during ingest.                                                               |
| Requires           | CPP-020     | Some minimal rights assessment must be performed during ingest to <br>                    verify that the TDA should be in charge of preserving the content <br>                    of the *SIP*. |
| Requires           | CPP-016     | The ingest process produces *Technical, Rights and Provenance <br>                    metadata* that are recorded in the *Information package* <br>                    and digital archive database by *Metadata* Ingest and Management. |
| May require        | CPP-010     | A TDA may validate the format of the submitted *File*s in the <br>                    ingest phase. |
| May require        | CPP-019     | The TDA may have quality requirements that may be checked during ingest.                       |
| May require        | CPP-026     | The ingest may require that the digital *Object*s are first <br>                    normalised before ingestion. |
| Required by        | CPP-021     | Versioning implies several delicate operations, in particular in the case <br>                    of a partial update, where the incoming *SIP* should be merged with <br>                    the existing *AIP*. |
| May be required by | CPP-028     | The ingestion may generate derivatives for access.                                             |
| Affinity with      | CPP-012     | The ingest process must adhere to the risk mitigation policies.                                |
| Affinity with      | CPP-013     | Ingest is both an important provider of reporting data to the TDA <br>                    (via other CPPs) as well as a customer, as the ingest checks and outcomes <br>                    must be reported to the producer. |

## Framework Mappings

| Framework     | Term                                     | Section                             |
| :------------ | :--------------------------------------- | :---------------------------------- |
| CoreTrustSeal | Ingest                                   | /                                   |
| Nestor Seal   | Ingest                                   | C14 Integrity: Ingest Interface<br><br>C17 Authenticity: Ingest |
| ISO 16363     | Ingest                                   | 4.1. Ingest: Acquisition of content<br><br>4.2. Ingest: Creation of the *AIP* |
| OAIS          | Ingest<br>                Ingest Functional Entity | 4.2.2. General - Figure 4-1<br><br>4.2.3.3. Ingest |
| PREMIS        | Ingest                                   | Glossary                            |

## Reference Implementations

### Use Cases

| Title                                   | Institution          | Documentation                                                           | Problem                                                                                                                                   | Solution |
| :-------------------------------------- | :------------------- | :---------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| Ingest processes described as workflows | Several institutions | https://coptr.digipres.org/index.php/Workflow:Community_Owned_Workflows | Several institutions have described their workflow for ingesting *Object*s in the Community Owned Workflow section of the COPTR registry. |          |

### Public Documentation

| Institution                                                                        | Link                                                                                    | Comment                                                                                                    |
| :--------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------- |
| TIB – Leibniz Information Centre for Science and Technology and University Library | https://wiki.tib.eu/confluence/spaces/lza/pages/93608618/Ingest                         |                                                                                                            |
| CSC – IT Center for Science Ltd.                                                   | https://urn.fi/urn:nbn:fi-fe2024051731943                                               | Appendix 4, section 2.2.1                                                                                  |
| Archivematica                                                                      | https://www.archivematica.org/en/docs/archivematica-1.17/user-manual/transfer/transfer/ | Transfer - steps that lead up to creating a SIP, e.g. checksum generation, file format identification etc. |
| Archivematica                                                                      | https://www.archivematica.org/en/docs/archivematica-1.17/user-manual/ingest/ingest/     | Ingest - steps from SIP to AIP, e.g. file format normalisation                                             |



---

