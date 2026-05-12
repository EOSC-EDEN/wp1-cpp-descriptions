# Metadata Ingest and Management

**Short Definition:** The TDA ingests and manages all required Metadata including Metadata appropriate for specific content types (e.g. geospatial, audio visual).

## Description and Scope
*Metadata* Ingest and Management is about ingesting, storing and maintaining *Metadata* to ensure the long-term preservation of the digital content. This *Metadata* (i.e. “data about the data”) provides contextual information about the *Object* and describes what the *Object* is; how it was created or acquired; how it should be managed and preserved; and how it can be accessed and used in the future. There are different categories of *Metadata* relevant for preservation: * *Descriptive metadata*: identifies the content, provides contextual information and serves as finding aid; * *Technical metadata*: contains details on the file formats, features and hard-/software used, compression, etc.; * *Fixity metadata*: stores information regarding the bitwise state of a *File*. It is used to help to detect any changes made to the *File’s* data; * *Provenance metadata*: records the origin of the data and keeps track of any processes performed on the data; * *Structural metadata*: stores the relationships between *Files* and logical parts. * *Rights metadata*: contains all relevant information about the rights to retain, manipulate and reproduce the data.

The *Metadata* is to be stored in a format that complies with an open and commonly used standard. Most categories of *Metadata* have their own specialised metadata formats and it is therefore not required to store all *Metadata* in a single format. Some common metadata standards are: * **PREMIS** for *Provenance metadata* * **METS** for *Structural metadata* * **Dublin Core, MODS** for *Descriptive metadata*

The *Metadata* can be assigned to *Objects* or *Files* and it must at all times be clear to what *Object* or *File* it is assigned. Some parts of the *Metadata* will be static (e.g. checksums and *File* size) while others will be dynamic and continue to be enhanced or updated during the life cycle of the *Object* in the TDA. It is important for the TDA to keep the *Metadata* safe at all times. No matter how well the data is protected by redundant copies and off-site backups, if *Metadata* is missing the data can no longer be identified and loses its context and thus most of its value.

New *Metadata* is usually created and added during the ingest phase, alongside the *Objects* it relates to. Several processes can and will update *Metadata* during the preservation. If the *Metadata* changes in a way that alters the understanding or interpretation of the *Objects* it preserves, the TDA creates new *AIP* versions that include the updated *Metadata*.

In the *Provenance metadata*, event *Metadata* serves as witness of the execution of the processes performed on the data. A TDA typically documents the preservation actions it performs as *Provenance metadata*, thus serving as an audit trail of the *Objects*. Such event *Metadata* contains: * An identifier and description of the process; * A timestamp indicating when the process execution happened; * Optionally extra *Metadata* associated to the event: * Event outcome: Single value data that documents the result of the process. (e.g. ‘Success’, ‘OK’, ‘Virus free”). The value is typically limited by a controlled vocabulary; * Process information: *Metadata* set that documents the tool and environment that was used to perform the process. It will include the tool’s name, its version and any configuration parameters that can influence its outcome like virus database version, plugin version, execution parameters, etc. * More detailed event result information like ignored warnings, multiple results outcomes, etc.

The *Metadata* can be stored in many ways [1]. For example, alongside the data *Files* in a METS *File*, in a relational database as fields, records and tables, in a noSQL database as documents, in a RDF store as a graph of triples or any combination of the above. The storage technology is not relevant as long as the *Metadata* 1) can be searched, retrieved and updated through open and well-documented common standards, and 2) is clearly and consistently linked to the *Object* or *File*. Usage of identifiers and URIs are key

[1] See also PREMIS v3 - pg 25 “Storing metadata”

## Authors
- Kris Dekeyser

## Contributors
- Johan Kylander

## Evaluators
- Felix Burger
- Maria Benauer

## Process Definition

### Inputs

| Type     | Input                           |
| :------- | :------------------------------ |
| Data     | File or Object                  |
| Metadata | Any Metadata from other process |
| Guidance | Metadata recording policy       |

### Outputs

| Type     | Output               |
| :------- | :------------------- |
| Metadata | Provenance metadata  |
| Metadata | Technical metadata   |
| Metadata | Descriptive metadata |
| Metadata | Structural metadata  |
| Metadata | Rights metadata      |

### Trigger Events

| Description                                                                                | Corresponding CPP |
| :----------------------------------------------------------------------------------------- | :---------------- |
| Any process that generates event timestamps, optionally including outcome data (Most CPPs) |                   |
| A new checksum was generated                                                               | `CPP-001`         |
| A checksum was validated                                                                   | `CPP-003`         |
| A new identifier was generated and attached to an *Object*                                 | `CPP-005`         |
| A format was assigned to a *File*                                                          | `CPP-008`         |
| *Metadata* was extracted from a *File*                                                     | `CPP-009`         |
| Missing *Metadata* has been identified, or used metadata standards have become obsolete    | `CPP-012`         |
| *Object* is removed                                                                        | `CPP-017`         |
| *Object* rights changed                                                                    | `CPP-020`         |
| *Descriptive metadata* must be pseudonymised/anonymised                                    | `CPP-020`         |

## Process Steps

| Step | Supplier(s) | Input(s)                                              | Description                                                                                                                 | Output(s)                | Customer(s) |
| :--- | :---------- | :---------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------- | :----------------------- | :---------- |
| 1    |             | - Event with optional data                            | Store event occurrence with timestamp and extra data                                                                        | - *Provenance metadata*  |             |
| 2a   | `CPP-001`   | - New checksum(s) created                             | Store checksums with their respective algorithms and assign it to the given *File*                                          | - *Fixity metadata*      |             |
| 2b   | `CPP-003`   | - Checksum was validated                              | Update the checksum’s last validation timestamp                                                                             | - *Fixity metadata*      |             |
| 2c   | `CPP-005`   | - New identifier                                      | Store the identifier and assign to the *Object* or *File*                                                                   | - *Descriptive metadata* |             |
| 2d   | `CPP-008`   | - Format identifier and format registry identifier    | Store the format information and assign to the *File*                                                                       | - *Technical metadata*   |             |
| 2e   | `CPP-009`   | - Any *Metadata* extracted from the *File*            | Store the *Metadata* and assign to the *File*                                                                               | - *Technical metadata*<br>- *Provenance metadata*<br>- *Descriptive metadata*<br>- *Structural metadata*<br>- *Rights metadata* |             |
| 2f   | `CPP-017`   | - Set of *Metadata*                                   | Replace the *Object* or *File* metadata with the minimal set and remove all references to the *Object* and *Files*          | - Any *Metadata*         |             |
| 2g   | `CPP-020`   | - New set of rights information                       | Store the rights information and assign to the *Object* or *File*                                                           | - *Rights metadata*      |             |
| 2h   | `CPP-020`   | - Requirement to anonymise/pseudonymise personal data | Update *Descriptive metadata* and create new *AIP* version                                                                  | - *descriptive metadata* |             |
| 2i   | `CPP-012`   | - Set of *Metadata*                                   | Used metadata standard has become obsolete and must be migrated                                                             | - Any *Metadata*         |             |
| 3    |             | - Set of *Metadata* Information Packages              | If needed (after updating the *Metadata*): The TDA creates a new version of an *AIP* to store the new or updated *Metadata* | - *AIP* version          | `CPP-021`   |

## Rationale / Worst Case

| Purpose                                                                                                                                                                                                                                                   | Worst Case                                                                                                                          |
| :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------- |
| [FAIR F3](https://www.go-fair.org/fair-principles/f3-metadata-clearly-explicitly-include-identifier-data-describe) *Metadata* clearly and explicitly include the identifier of the data they describe                                                     | If the connection between *Metadata* and the *Object*’s data is lost, *Object*s can no longer be found by searching the *Metadata*. |
| [FAIR F4](https://www.go-fair.org/fair-principles/f4-metadata-registered-indexed-searchable-resource)(Meta)data are registered or indexed in a searchable resource                                                                                        | Without searchability it is not possible to retrieve sets of relevant data based on characteristics described in the *Metadata*.    |
| [FAIR A2](https://www.go-fair.org/fair-principles/a2-metadata-accessible-even-data-no-longer-available)*Metadata* should be accessible even when the data is no longer available                                                                          | Storing a tombstone metadata for disposed content serves as a witness of the data’s existence beyond its disposal.                  |
| [FAIR I1](https://www.go-fair.org/fair-principles/i1-metadata-use-formal-accessible-shared-broadly-applicable-language-knowledge-representation)(Meta)data use a formal, accessible, shared, and broadly applicable language for knowledge representation | Lack of understanding the language in which the *Metadata* is expressed leads to misinterpretation or even loss of information.     |
| [FAIR R1.3](https://www.go-fair.org/fair-principles/r1-3-metadata-meet-domain-relevant-community-standards)(Meta)data meet domain-relevant community standards                                                                                            | Lack of understanding the language in which the *Metadata* is expressed leads to misinterpretation or even loss of information.     |

## Relationships

| Type          | Related CPP | Description                                                                                                                                                                                                                                                |
| :------------ | :---------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Requires      | CPP-001     | The checksums and associated algorithms need to be stored in the *File*’s *Fixity metadata*.                                                                                                                                                               |
| Requires      | CPP-003     | The timestamp of the *File*’s checksum needs to be updated to keep track of the last successful check.                                                                                                                                                     |
| Requires      | CPP-005     | The TDA must store the Persistent Identifier and link it to the *Object* or *File*.                                                                                                                                                                        |
| Requires      | CPP-008     | Format information needs to be stored with the *File*’s *Technical metadata*.                                                                                                                                                                              |
| Requires      | CPP-009     | Any *Metadata* that was extracted from the *File* needs to be stored, searchable and retrievable.                                                                                                                                                          |
| Requires      | CPP-017     | A tombstone consisting of *Metadata* only - without the actual data - has to be kept as a witness of the data’s former presence.                                                                                                                           |
| Requires      | CPP-020     | Any information regarding the rights for the TDA and the end users on the data needs to be stored and should be searchable and retrievable.                                                                                                                |
| Required by   | CPP-013     | *Metadata* ingest provides new *Provenance metadata*.                                                                                                                                                                                                      |
| Required by   | CPP-024     | Enabling Discovery relies on a correct *Metadata* management process. In particular, *Metadata* created by and within the TDA is of particular interest to the consumer in order to understand preservation actions that could have affected the *Object*. |
| Required by   | CPP-029     | The ingest process produces *Technical, Rights and Provenance metadata* that are recorded in the Information package and digital archive database by *Metadata* Ingest and Management.                                                                     |
| Affinity with | CPP-022     | A TDA defines significant properties for digital *Object*s. These are then translated to *Technical metadata* that is ingested. The significant properties definition process also influences which *Technical metadata* standards are applied.            |

## Framework Mappings

| Framework     | Term                              | Section                                                                               |
| :------------ | :-------------------------------- | :------------------------------------------------------------------------------------ |
| CoreTrustSeal | Provenance and authenticity       | R07                                                                                   |
| CoreTrustSeal | Storage and Integrity             | R14                                                                                   |
| Nestor Seal   | Logging the preservation measures | C31, page 49                                                                          |
| ISO 16363     | Information Management            | Section 4.5, page 4-26                                                                |
| OAIS          |                                   | OAIS mentions *Metadata*, but does not discuss metadata ingest or metadata management |
| PREMIS        | Storing metadata                  | Section with the same title in the introduction                                       |

## Reference Implementations

### Public Documentation

| Institution                                                                        | Link                                                                                                            | Comment                |
| :--------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------- | :--------------------- |
| TIB – Leibniz Information Centre for Science and Technology and University Library | https://wiki.tib.eu/confluence/spaces/lza/pages/93608951/Metadata                                               |                        |
| CSC – IT Center for Science Ltd.                                                   | https://urn.fi/urn:nbn:fi-fe2020100578094                                                                       | Annex 4, section 2.2.1 |
| Archivematica                                                                      | https://www.archivematica.org/en/docs/archivematica-1.17/user-manual/transfer/transfer/#transfers-with-metadata | Import metadata        |



---

