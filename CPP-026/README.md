# File Normalisation

**Short Definition:** The TDA performs operations on the data Objects prior to ingest in order to comply with its format requirements.

## Description and Scope
In the context of digital preservation, File Normalisation refers to the process of converting incoming *Files* into standardised, well-supported formats that are more likely to be usable and accessible in the long term. These formats are captured in the preferred preservation formats policy of the TDA. The goal is to ensure the long-term usability, accessibility, and intelligibility of digital content by avoiding dependence on obsolete or proprietary formats and start the repository with a consistent, manageable and sustainable set of formats from the start.

File Normalisation can be driven by an identified risk, in which case it requires that some formats have been assessed a format risk. For each of these formats at risk an alternative format should be available as well as the necessary tools to convert *Files* from the format at risk to its alternative format.

*File* normalisation policy can also be driven by specific organisational requirements like the availability of specialised applications, viewer preferences (e.g. JPEG2000 for IIIF), or the ability to make subsequent processes easier and more efficient such as creating derivatives, tracking and managing risks and obsolescence, and monitoring and reporting of formats in the archive.

If *Files* are submitted in a format not part of the list of preferred preservation formats and there is no normalisation path available to convert them to a supported format, the outcome is undefined. It is up to the TDA to decide what happens.

It may be that the original *File* is submitted in the *SIP* along with the normalised *File* . In this case, the original *File* can only be in bit-level preservation. Reasons for this may be, for example, to ensure the authenticity of the digital *Object*, because it is anticipated that the original *File* format is expected to be useful for the designated community for a reasonable time.

Normalisation differs from other processes that create new *Files* or *Representations*: * Unlike Normalisation, **Creation of Derivatives** reproduces only the information and significant properties of the original that are useful to address specific needs of the designated community. Thus, the output of **Creation of Derivatives** may lack part of the information that is not required to satisfy said needs. * Whereas Normalisation aims at reducing the number of formats by converting *Files* or *Representations* to preservation formats defined by the institutional formats policy, **File Migration** is performed to address a specific preservation risk.

## Authors
- Kris Dekeyser

## Contributors
- Mikko Laukkanen
- Juha Lehtonen

## Evaluators
- Matthew Addis
- Felix Burger
- Maria Benauer

## Process Definition

### Inputs

| Type     | Input                                  |
| :------- | :------------------------------------- |
| Data     | Submission Information Package         |
| Data     | File                                   |
| Metadata | Technical Metadata (Format identifier) |
| Guidance | File format policy - Preferred formats |

### Outputs

| Type     | Output                                                                                 |
| :------- | :------------------------------------------------------------------------------------- |
| Metadata | Provenance metadata (Normalisation events, original and normalised formats, timestamp) |

### Trigger Events

| Description                                      | Corresponding CPP |
| :----------------------------------------------- | :---------------- |
| Submission of an *Information Package*           | `CPP-029`         |
| Change in file format policy - Preferred formats | `CPP-018`         |

## Process Steps

| Step | Supplier(s) | Input(s)                                           | Description                                                                                               | Output(s)                                                                                                 | Customer(s) |
| :--- | :---------- | :------------------------------------------------- | :-------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------- | :---------- |
| 1a   | `CPP-029`   | - Each *File* in the *Information Package*         | Perform the Format Identification process on the *File*(s)                                                |                                                                                                           |             |
| 1b   | `CPP-018`   | - Change in file format policy - Preferred formats | Find *Files* that require change of normalisation by format, then<br>                            process each one |                                                                                                           |             |
| 2    | `CPP-008`   | - Detected format(s)<br>- File format policy - Preferred formats | Compare the detected format with the list of preferred formats                                            | - Complete match: Process completed (step 6)<br>- Deviation: Determine if the policy provides a normalisation plan (i.e.<br>                            sequence of tools and configuration parameters to use on the *File*) (step 3) |             |
| 3    | `CPP-012`   | - Normalisation path                               | Execute the normalisation plan                                                                            | - Normalised *File*                                                                                       |             |
| 4    |             | - Validation plan                                  | If present, run the validation plan to determine if the normalised *File*<br>                        provides a similar rendition like the original *File*. If no validation plan is<br>                        available, it is up to the TDA’s policy to decide if manual inspection is needed. | - Validation result: OK (step 5a)<br>- Validation result: Error (5b)                                      |             |
| 5a   |             | - OK                                               | Replace the original *File* with the normalised *File* (or add it) in the<br>                            *SIP* or *AIP* and adapt the *Fixity metadata* and *Technical metadata* | - updated *SIP* or *AIP*                                                                                  |             |
| 5b   |             | - Error                                            | Report the error for the system or operator to decide further action                                      | - Stop the process                                                                                        |             |
| 6    |             |                                                    | Log the normalisation event and its outcome                                                               | - *Provenance metadata* in the *SIP*                                                                      |             |

## Rationale / Worst Case

| Purpose                                                                                                           | Worst Case                                                                                                    |
| :---------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------ |
| Store information in supported formats                                                                            | Format migration at a later point could be impossible                                                         |
| Anticipate on formats becoming less popular                                                                       | Attempt to migrate data when the tools to do so are no longer available or knowledge about the format is lost |
| Reducing complexity and risk by normalising to a smaller set of well-chosen formats, TDAs<br>                    significantly reduce the technical overhead and resources needed for preservation activities. | TDA must maintain too many file formats, which each in turn needs specific <br>                    knowledge, tools and ongoing maintenance to ensure continued access |

## Relationships

| Type                    | Related CPP | Description                                                                                          |
| :---------------------- | :---------- | :--------------------------------------------------------------------------------------------------- |
| Requires                | CPP-008     | The format information of the *File* in question is one of the<br>                    deciding input parameters when considering File normalisation. |
| Requires                | CPP-012     | CPP-012 is in charge of designing normalisation paths<br>                    whose output would retain all significant properties. |
| Requires                | CPP-022     | Like Format migration, File Normalisation should be <br>                    evaluated based on significant properties. |
| Requires                | CPP-023     | The level of risk of the detected format is one of the<br>                    factors that drives the preferred preservation formats<br>                    policy. |
| May require             | CPP-005     | A normalised file format may be assigned with a new PID.                                             |
| May be required by      | CPP-029     | The ingest may require that the digital <br>                    *Objects* are first normalised before<br>                    ingestion. |
| Facilitates             | CPP-015     | Restricting the formats to those that are well supported by the tools<br>                    improves the success of this process. |
| Affinity with           | CPP-014     | Normalisation is performed at Ingest and aims at reducing the number of<br>                    formats preserved by converting *Files* or *Representations* to preservation<br>                    formats defined by the institutional formats policy, while Format migration<br>                    is performed after ingest to address a specific preservation risk. |
| Not to be confused with | CPP-028     | Unlike Normalisation, Creation of Derivatives reproduces only the<br>                    information and significant properties of the original that is useful to address<br>                    specific needs of the Designated Community. Thus, the output of<br>                    Creation of Derivatives may lack part of the information that is not required<br>                    to satisfy said needs. Normalisation aims to maintain all the significant<br>                    properties of the original. |

## Framework Mappings

| Framework     | Term                                | Section                                                                                         |
| :------------ | :---------------------------------- | :---------------------------------------------------------------------------------------------- |
| CoreTrustSeal | normalising                         | page 7 of 19 - Levels of Curation: it regards normalisation a requirement to achieve<br>                    Curation Levels above B. |
| Nestor Seal   | normalisation                       | page 34:  normalisation mentioned as required to document for c17 Authenticity: Ingest          |
| ISO 16363     | normalisation mentioned in examples | 4.1.1 - preservation objectives<br><br>4.2.2 - describing transformations<br><br>4.2.3.3 - provenance information |
| OAIS          | file format conversion              | OAIS mentions in the Generate AIP function of the Ingest Functional Entity:<br>                    ‘may involve file format conversions’ (page 4-7) |
| PREMIS        | Normalization                       | Glossary, page 271:<br><br>Normalization: Form of Migration in which a version of a Digital Object is<br>                    created in a new Format with properties more conducive to preservation<br>                    treatment. Normalization is oftenimplemented as part of the Ingest process. |

## Reference Implementations

### Public Documentation

| Institution                      | Link                                                                                          | Comment     |
| :------------------------------- | :-------------------------------------------------------------------------------------------- | :---------- |
| CSC - IT Center for Science Ltd. | https://urn.fi/urn:nbn:fi-fe2025040925236                                                     | section 7.7 |
| Archivematica                    | https://www.archivematica.org/en/docs/archivematica-1.17/user-manual/ingest/ingest/#normalize | Tableau1_3  |



---

