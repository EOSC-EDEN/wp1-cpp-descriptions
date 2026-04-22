# Dataqualityassessment

**Short Definition:** The TDA evaluates and re-evaluates the data quality of Information Objects

## Description and Scope
Data Quality Assessment refers to the systematic evaluation of *Objects* and their associated *Metadata* against predefined measures to ensure they meet the standards necessary for consumers' needs and continued access. The assessment typically covers several key dimensions, some of these are for example: * *Authenticity*: The *Object* is what it purports to be (i.e. it has been created, modified and sent by the person purported to have done it at the date and time purported). The designated community must be able to trust that the data is real and credible and is managed by a trustworthy TDA. Sufficient information must exist to understand the *Object's* creation circumstances, provenance, and relationship to other content. In addition to integrity checks, the authenticity of the data is ensured by controlled changes through preservation actions and the *Provenance metadata*. * *Completeness*: The *Object* and the *Metadata* are complete. They do not have missing parts or links to targets outside the preserved *Object* which should remain accessible. * *Consistency*: The *Object* is presented in applicable file formats or *Representations* with applicable metadata formats. Conflicting values in the *Metadata* should be avoided. * *Relevance*: The data preservation is based on a predefined collection development policy (i.e. has a purpose of being preserved). * *Structured*: The structure of the *Object* is described in the *Metadata*. Complex *Objects* are organised, including relationships between *Files*, proper sequencing of multi-part *Objects*, and the integrity of any embedded *Metadata* or links. * *Understandability*: The information is understandable and meaningful for the designated community. * *Validity*: The *Object* and *Metadata* are valid against the *File* and metadata format specifications and standards, and comply with all other predefined profiles and rules.

Data quality assessment may include various processes, repeated from time to time. A very common phase to perform an assessment is in the *Ingest* phase, but the use case described below demonstrates that such a process can also be performed at the access stage. The data may be rejected from digital preservation, if it does not meet the criteria. An assessment typically has the following steps, described on a very high level: * Define the scope of the assessment; * Define data quality dimensions and metrics, including possible thresholds; * Gather and analyse data; * Create a quality report about all the findings; * If needed, update the data and *Metadata* to improve the quality.

The step-by-step description below mainly concentrates on the technical aspects of the data and *Metadata*, but the scope of this CPP is indeed covering a broader range of contextual data quality properties.

The assessment process often employs both automated tools and manual review. For example, automated tools can perform file format identification, validate *File* or *Information package* structures, check for malware, verify checksums, or check for completeness of a delivery against an inventory. Human reviewers, for example, may evaluate content accuracy, *Metadata* completeness, and contextual adequacy. The processes should be automated as much as possible for faster processing and to avoid human errors.

Results from Data Quality Assessment affect preservation planning decisions (e.g. what additional *Metadata* needs to be captured). The assessment also establishes baseline quality metrics that can be monitored over time to detect degradation or other changes that might necessitate intervention.

## Authors
- Mikko Laukkanen
- Juha Lehtonen

## Contributors
- Bertrand Caron
- Johan Kylander

## Evaluators
- Franziska Schwab
- Felix Burger
- Maria Benauer

## Process Definition

### Inputs

| Type     | Input                             |
| :------- | :-------------------------------- |
| Data     | Information object                |
| Data     | File                              |
| Metadata | Descriptive metadata              |
| Metadata | Technical metadata                |
| Metadata | Provenance metadata               |
| Metadata | Rights metadata                   |
| Metadata | Structural metadata               |
| Guidance | Quality assessment policy         |
| Guidance | Format policy - preferred formats |
| Guidance | Collection development policy     |
| Guidance | Metadata recording policy         |

### Outputs

| Type     | Output                    |
| :------- | :------------------------ |
| Guidance | Quality assessment report |

### Trigger Events

| Description                        | Corresponding CPP |
| :--------------------------------- | :---------------- |
| Ingest                             | `CPP-029`         |
| Metadata ingest                    | `CPP-016`         |
| Mass export of *AIPs* from the TDA | `CPP-006`         |
| Periodic re-appraisal              |                   |

## Process Steps

| Step | Supplier(s) | Input(s)                                                | Description                                                                                                | Output(s)                                                | Customer(s) |
| :--- | :---------- | :------------------------------------------------------ | :--------------------------------------------------------------------------------------------------------- | :------------------------------------------------------- | :---------- |
| 1    | `CPP-018`   | - Preservation objectives                               | Based on preservation intent as<br>                            defined by Community Watch,<br>                            derive quality properties that will<br>                            be extracted by other CPPs | - Quality properties                                     |             |
| 2    |             | - Quality properties                                    | The TDA receives a defined set of quality properties and determines<br>                            what data is required to create a quality assessment report. This<br>                            triggers steps 3 to 8 | - Specification of the data required for the assessment. |             |
| 3a   | `CPP-008`   | - Specification of the data required for the assessment<br>- *File*<br>- File format identifier<br>- Format policy - preferred formats | If quality properties concern file formats:<br>                            Assess the file format against the preferred formats policy | - Technical quality report                               |             |
| 3b   | `CPP-010`   | - Specification of the data required for the assessment<br>- *File*<br>- Validity status | If quality properties concern the validity of formats:<br>                            Assess the validity status. | - Technical quality report                               |             |
| 3c   | `CPP-009`   | - Specification of the data required for the assessment<br>- *File* / *Representation*<br>- Quality properties<br>- Extracted *Metadata* | If quality properties concern technical qualities or completeness<br>                                of *Files* or *Representations*:<br>                            Assess the technical quality and completeness against quality<br>                                properties | - Technical quality report                               |             |
| 3d   | `CPP-016`   | - Specification of the data required for the assessment<br>- Metadata recording policy<br>- *Object*<br>- *Metadata* | If quality properties concern metadata quality:<br>                            Assess the metadata quality. | - Metadata ingest report                                 |             |
| 3e   | `CPP-007`   | - Specification of the data required for the assessment<br>- *File* | If quality properties concern existence of malware:<br>                            Scan for malware        | - Virus scanning report                                  |             |
| 3f   | `CPP-020`   | - Specification of the data required for the assessment<br>- *Rights metadata*<br>- *Object* | If quality properties concern the legal status and authenticity<br>                                of the *Object*:<br>                            Assess the legal status of the *Object* | - Legal status report                                    |             |
| 4    |             | - File format identifier<br>- Validity status<br>- Metadata ingest report<br>- Technical quality report<br>- Virus scanning report<br>- Legal status report | Creation of quality assessment report from suppliers                                                       | - Quality assessment report                              |             |
| 5    |             | - Quality assessment report                             | Assess the quality of an *Object* during specific stages (e.g.<br>                            during ingest) |                                                          | `CPP-029`   |
| 6    |             |                                                         | Optional: The quality of an *Object*, *AIP* or *Metadata* can be enhanced or modified based on the quality<br>                            assessment report. It may run for example some of the following CPPs:<br>                        <br>•  CPP-014 (File Migration)<br>                            <br>•  CPP-016 (Metadata Ingest and Management)<br>                            <br>•  CPP-017 (Disposal)<br>                            <br>•  CPP-026 (File Normalisation) |                                                          |             |

## Rationale / Worst Case

| Purpose                                                                                             | Worst Case                                                                                                                                    |
| :-------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------- |
| Quality assessment identifies vulnerabilities before they result in<br>                    data loss, allowing the TDA to take preventive action rather than reactive<br>                    measures.<br>                As digital preservation spans decades or centuries during which technological<br>                    environments will change completely multiple times, the data quality assessment<br>                    evaluates whether current *Objects* contain sufficient technical and<br>                    contextual information to remain interpretable by future systems and users. | Uncontrolled file format obsolescence, hardware failure or bit corruption.<br>                Loss of content interpretability over time, authenticity and/or significant<br>                    properties. |
| Data Quality Assessment helps the TDA to take informed preservation<br>                    decisions regarding appraisal and re-appraisal based on quality metrics.<br>                    Identification, automated extraction and correct interpretation of such<br>                    metrics is fundamental to collection development. | No knowledge or no capacity to assess the quality of the *Object*<br>                    could lead to appraisal of *Representations* of poor quality despite *Representations* of better quality being available. |

## Relationships

| Type               | Related CPP | Description                                                                                                                              |
| :----------------- | :---------- | :--------------------------------------------------------------------------------------------------------------------------------------- |
| Requires           | CPP-007     | Virus Scanning acts as a supplier since scanning for viruses is performed as a<br>                    step<br>                    in the overall Data Quality Assessment. |
| Requires           | CPP-009     | Metadata extraction returns *Metadata* that are used to assess the *File* quality (e.g. for an audiovisual *File* quality assessment may<br>                    rely on *Metadata* such as bit depth, sampling frequency, etc.) |
| Requires           | CPP-018     | The signals from the community may affect the Data Quality Assessment. For<br>                    example,<br>                    the Data Quality Assessment performed during Ingest may result in extraction of<br>                    quality properties that are required by the Designated Community. |
| May require        | CPP-020     | Assessing the legal status and authenticity of *Objects* requires *Rights<br>                    metadata*.                              |
| May require        | CPP-005     | Data Quality Assessment may include validating the PIDs and their linked<br>                    resources.                               |
| Required by        | CPP-009     | The selection of an appropriate extractor tool depends on<br>                    requirements as provided by Data Quality Assessment.    |
| Required by        | CPP-029     | Ingest uses the Quality Assessment report as produced by Data Quality<br>                    Assessment to accept or reject the *Object*. |
| May be required by | CPP-029     | The TDA may have quality requirements as produced by Data<br>                    Quality Assessment that may be checked during ingest.   |
| Affinity with      | CPP-013     | Object management reporting relates to re-evaluating quality dimensions.                                                                 |
| Affinity with      | CPP-022     | As Data Quality Assessment identifies quality properties whose value will<br>                    determine whether the *Objects* are ingested or not, these quality<br>                    properties will likely be also considered significant by the TDA. |
| Affinity with      | CPP-023     | Both CPP-019 and CPP-023 are defining properties that the TDA<br>                    should consider and interpret against the result of CPP-009 (Metadata<br>                    extraction). |
| Affinity with      | CPP-025     | *DIPs* should conform to the quality aspects as specified by the TDA.                                                                    |

## Framework Mappings

| Framework     | Term              | Section                                                                                             |
| :------------ | :---------------- | :-------------------------------------------------------------------------------------------------- |
| CoreTrustSeal | Quality Assurance | R10 Quality Assurance                                                                               |
| Nestor Seal   | Quality Assurance | The question of quality assurance is<br>                    mentioned in<br><br>* C22 Transformation of the submission information packages into archival information packages<br>                    <br>•  C23 Archival information packages<br>                    <br>•  C24 Interpretability of the archival information<br>                    <br>•  C25 Transformation of archival information packages into dissemination information packages<br>                    <br>•  C26 Dissemination information packages |
| ISO 16363     | Quality control   | 3.3.2.1 The repository shall have mechanisms for review, update, and<br>                    ongoing development of its Preservation Policies as the repository grows and as<br>                    technology and community practice evolve |
| OAIS          | Quality Assurance | * 4.2.2 General<br>                    <br>•  4.2.3.3 Ingest<br>                    <br>•  Figure A-1: Composite of Functional Entities |

## Reference Implementations

### Use Cases

| Title                              | Institution | Documentation                         | Problem                                                                                    | Solution                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| :--------------------------------- | :---------- | :------------------------------------ | :----------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Access Quality Metrics for Net Art | Rhizome     | https://doi.org/10.17605/OSF.IO/6RNK4 | The primary problem is the lack of a standardised method to<br>                        help users of the ArtBase archive navigate the various versions<br>                        and access methods of digital artworks. The archive holds<br>                        multiple "variants" of each piece, which might include live<br>                        versions from a web server, archived copies, or versions viewed<br>                        through emulators. Each variant offers a different experience,<br>                        and without a guide, users might unknowingly choose a version<br>                        that is incomplete or partially non-functional. The paper notes<br>                        that visitors need a way to make an informed choice between a<br>                        version that is integrated into the modern internet landscape but<br>                        potentially broken, and one that is more historically accurate but<br>                        requires a special, emulated environment. | <pre><code>The proposed solution is a system that calculates an "access quality
                        score" for each variant of an artwork. This score is a single value, derived
                        from a combination of *Technical metadata* and curatorial
                        information, which indicates how complete and functional an artwork's
                        performance is likely to be. The system uses a data model to define variants
                        as a combination of archived *Files* ("artifacts") and the software
                        environment ("machine") used to view them. The score is calculated by
                        determining whether a machine's capabilities support the data formats within
                        the artifact. This system aims to present a simple, three-level "stoplight"
                        indicator (green, yellow, or red) that guides visitors to the best available
                        version, manages their expectations for works with known issues, and
                        ultimately improves the user experience of the ArtBase archive.</code></pre> |

### Public Documentation

| Institution                                                                        | Link                                                                                      | Comment                                               |
| :--------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------- | :---------------------------------------------------- |
| TIB – Leibniz Information Centre for Science and Technology and University Library | https://wiki.tib.eu/confluence/spaces/lza/pages/93608984/Specifications                   | TIB Pre-Ingest Analyzer (PIA)                         |
| CSC – IT Center for Science Ltd.                                                   | https://digitalpreservation.fi/en/specifications                                          |                                                       |
| Achivematica                                                                       | https://www.archivematica.org/en/docs/archivematica-1.17/user-manual/appraisal/appraisal/ | Manual assessment can be done using the Appraisal Tab |



---

