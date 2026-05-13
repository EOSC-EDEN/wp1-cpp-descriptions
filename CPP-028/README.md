# Creation of Derivatives

**Short Definition:** The TDA generates derivative copies to address the specific needs of its Designated Community.

## Description and Scope
The process of Creation of Derivatives refers to generating new *Representations* of a digital *Object* (based on the original *Representation* of the *Object*) to address specific needs of the *Designated Community*. Some of these needs are: * Provide easy access to the information for a broader community (e.g. conversion from TIFF to JPEG in order to allow viewing in a web browser) * Provide access for a specific user base (e.g. converting CAD *Files* to a specific format that is more commonly in use by a group of researchers) * Provide different forms of access to the data (e.g. combining a tree of HTML-pages, images and other resources into a WARC *File*; unpacking a ZIP *File*; compiling data into a pivot table or chart) * Provide access to the data in formats that address accessibility challenges (e.g. creating DAISY derivatives of PDFs for visually impaired consumers) * Restricting or protecting the access to the data (e.g. creating a PDF from an e-book containing only the first few pages; lowering the resolution and watermarking; thumbnails) * Enriching the information (e.g. adding AI-generated transcriptions as subtitles to a video; overlaying transparent OCR text over a scanned image in a PDF; adding AI-generated *Descriptive metadata*)

Creation of Derivatives differs from other processes that create new *Files* or *Representations*: * Unlike **File Migration** (CPP-014), Creation of Derivatives reproduces only the information and significant properties of the original that is useful to address specific needs of the Designated Community. Thus, the output of Creation of Derivatives may lack part of the information that is not required to satisfy said needs. * **File Normalisation** (CPP-026) is performed during ingest and aims at reducing the number of formats by converting *Files* or *Representations* to preservation formats defined by the institutional formats policy. * **File Migration** (CPP-014) is performed after ingest to address a specific preservation risk.

Derivative copies can be short-lived and there can be more than one derivative copy for a given original. For example, derivative copies for a video master *File* could include multiple resolutions, different levels of compression and different encoding schemes (e.g. suited for previewing rather than reuse). The derivative videos may be generated to support contemporary web delivery standards such as HTML5 and as a result may be short lived compared to the copies created as a result of migration and/or normalisation.

It is up to the TDA to decide how far they take this and if they support any of these use cases, if at all. The generation of the derivative copies can be performed during delivery, during or before the ingestion or any time during the *Object*’s life cycle in the TDA. Performance, *Object* size, availability of conversion tools and workflows, and user requirements will be some of the elements that could play a role in this decision.

Depending on whether the derivative copy maintains the significant properties of the original *Object*, the derivative copy may then (a) be added to the same *AIP* as the original (e.g. as a new *Representation*), (b) result in a new *AIP* that is stored in addition to the original and is linked to it, or (c) may be held in a *DIP* which in turn may be stored temporarily or permanently, and is linked to the original *AIP*. In PREMIS terms, the derivative copies can be stored as a new *Representation* if the derivative copy is a complete and meaningful rendition of the *Intellectual Entity*. However, if the derivative copies change the meaning and of the original (e.g. significant properties are not maintained) then a new *AIP* or *DIP* is recommended.

## Authors
- Kris Dekeyser

## Contributors
- Juha Lehtonen

## Evaluators
- Matthew Addis
- Felix Burger

## Process Definition

### Inputs

| Type     | Input                              |
| :------- | :--------------------------------- |
| Data     | Source Representation of an Object |
| Guidance | File format policy - Derivatives   |

### Outputs

| Type     | Output              |
| :------- | :------------------ |
| Metadata | Provenance metadata |
| Metadata | Structural metadata |

### Trigger Events

| Description                              | Corresponding CPP |
| :--------------------------------------- | :---------------- |
| Request for access to a digital *Object* | `CPP-025`         |
| *SIP* processing during Ingest           | `CPP-029`         |

## Process Steps

| Step | Supplier(s) | Input(s)                                            | Description                                                                                       | Output(s)                          | Customer(s) |
| :--- | :---------- | :-------------------------------------------------- | :------------------------------------------------------------------------------------------------ | :--------------------------------- | :---------- |
| 1a   | `CPP-025`   | - Request for access copy and requested *Object(s)* | Identify the *Representation* to be processed                                                     | - *Representation*                 |             |
| 1b   | `CPP-029`   | - Ingest of a *SIP*                                 | Iterate over the *Representations* in the *SIP*                                                   | - *Representation*                 |             |
| 2    |             | - *Representation*<br>- File format policy - Derivatives | Determine if a derivative is needed by applying the rules in the policy<br>                            to the *Files* in the *Representation*.<br>                            End the process unless a derivative is needed |                                    |             |
| 3    |             | - *Representation*<br>- File format policy - Derivatives: tools | Determine the migration path and apply it to the source *File(s)* in the *Representation*         | - New *File* or set of *Files*     |             |
| 4    |             | - File format policy - Derivatives                  | Decide on the packaging of the *File(s)*: a new *Representation*, <br>                            a new *AIP* or a *DIP*. | - *Representation*, *AIP* or *DIP* |             |
| 5a   |             | - *DIP*                                             | Deliver the *DIP* and end the process                                                             |                                    |             |
| 5b   | `CPP-001`   | - *Representation* or *AIP*                         | Apply the characterisation processes against the new *Object*,<br>                                optionally by running the ingest process and all its subprocesses | - Validated *Object*               | `CPP-015`   |
| 6    |             |                                                     | Report migration performed, success/failure, *Files* generated                                    | - Audit trail<br>- *Provenance metadata*<br>- *Structural metadata* |             |

## Rationale / Worst Case

| Purpose                                                                                     | Worst Case                                                                                                            |
| :------------------------------------------------------------------------------------------ | :-------------------------------------------------------------------------------------------------------------------- |
| FAIR Interoperable: I1. (Meta)data use a formal, accessible, shared, and<br>                    broadly applicable language for knowledge representation.<br>                FAIR Reusable: R1.3. (Meta)data meet domain-relevant community standards<br>                i.o.w. To support Interoperability and Reuse of the data, it should be made<br>                    available in a format or structure that closely matches its usage. | The consumer of the data may resort to other tools to convert it and corrupt <br>                    or distort the data in the process.<br>                The consumer of the data may be unable to use the data because it is not in a format <br>                    they can use and they do not have the tools/knowledge to convert it themselves. |
| FAIR Findable                                                                               | Without derivative copies, the consumer of the data may find it difficult and time consuming to<br>                    assess whether the data contains the content they need, for example they cannot easily<br>                    preview/inspect derivatives that allow them to determine if they should go ahead and retrieve the<br>                    full dataset. |

## Relationships

| Type                    | Related CPP | Description                                                                  |
| :---------------------- | :---------- | :--------------------------------------------------------------------------- |
| Requires                | CPP-022     | Though derivative copies may not be subject to the same<br>                    requirements as preservation copies, providing access<br>                    through copies that do not convey significant properties<br>                    might be considered a TDA failure. |
| Requires                | CPP-025     | The request for access can trigger the creation of a<br>                    derivative copy for rendering purposes. |
| May require             | CPP-005     | A derivative copy of a *File* may get its own identifier.                    |
| May require             | CPP-029     | During ingest derivative copies may be created.                              |
| Required by             | CPP-013     | Creation of new *Objects* provides data<br>                    for statistical reporting. |
| Facilitates             | CPP-015     | Derived copies in a different format or<br>                    structure than the original<br>                    *Representation* can help in rendering<br>                    the data or simulating the environment. |
| Not to be confused with | CPP-014     | Creation of a derivatives creates an<br>                    additional *Representation* to be<br>                    retained, while the migration outcome<br>                    is supposed to replace its source. |
| Not to be confused with | CPP-026     | Unlike File Normalisation (CPP-026),<br>                    Creation of Derivatives (CPP-028)<br>                    reproduces only the information and<br>                    significant properties of the original<br>                    that is useful to address specific needs<br>                    of the *Designated Community*. Thus,<br>                    the output of Creation of Derivatives<br>                    may lack part of the information that is<br>                    not required to satisfy said needs.<br>                    Normalisation aims to maintain all the<br>                    significant properties of the original. |

## Framework Mappings

| Framework | Term                             | Section                                                         |
| :-------- | :------------------------------- | :-------------------------------------------------------------- |
| ISO 16363 | dissemination of digital objects | 4.6.2 dissemination may simply be a<br>                    copy, a simple format transformation or a<br>                    more complex derivation |
| OAIS      | *DIP* and derived *AIP*          | OAIS differentiates between generating<br>                    derivations for the sake of a *DIP* and<br>                    creating derivative copies and storing<br>                    them in the TDA. In the latter case, they<br>                    suggest it is added as an *AIP* linked to<br>                    the source *AIP*, ignoring the fact that it<br>                    could be stored as a *Representation*<br>                    within the same *AIP*. |
| PREMIS    | Relationships                    | Derivation relationships can be defined<br>                    between *Objects* |

## Reference Implementations

### Public Documentation

| Institution                                                                        | Link                                                                                                          | Comment                                                                                    |
| :--------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------ | :----------------------------------------------------------------------------------------- |
| TIB - Leibniz Information Centre for Science and Technology and University Library | https://wiki.tib.eu/confluence/spaces/lza/pages/93608628/Pre-Ingest?preview=/93608628/93608629/pre-ingest.png | part of pre-ingest routines                                                                |
| Archivematica                                                                      | https://www.archivematica.org/en/docs/archivematica-1.17/user-manual/ingest/ingest/#normalize                 | In Archivematica, creating derivatives (called access copies) are part of normalisation. ​ |



---

