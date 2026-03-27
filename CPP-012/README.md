# Risk Mitigation

**Short Definition:** The TDA enables the design, development and management of plans for mitigating identified preservation risks.

## Description and Scope
Risks can be viewed from various perspectives, for example, from a TDA level, from a digital content level, from a file format level, etc. The topic is extremely wide, and several risks and their mitigations are applicable to any industry. Many core digital preservation processes are triggered by, or get their input from risk mitigation.

Rosenthal et al. (https://www.dlib.org/dlib/november05/rosenthal/11rosenthal.html) present various threats for a TDA. Risks are related to media, hardware or software failure, or obsolescence; communication errors or failure of network services; natural disasters; operator errors; external attacks; internal attacks; or economic or organisational failure. For example, operator actions may include either recoverable or irrecoverable operator errors.

Regarding risks related to file formats, the NARA Digital Preservation Risk Matrix (https://github.com/usnationalarchives/digital-preservation/blob/master/Digital_Preservation_Risk_Matrix/readme.md) shows numerous risks for file formats. These are related to disclosure, adoption, transparency, self-documentation, external hardware and software dependencies, impact of patents, and technical protection mechanisms. For example, related to disclosure, the format may be at risk if it is proprietary, does not have public documentation, or the maintenance of the documentation is not standardised. Moreover, the CHARM Risk Identification Framework (https://discovery.dundee.ac.uk/en/studentTheses/disentangling-digital-preservation-risk) concentrates on risks of different aspects, related to digital content including Metadata, and organisational and technological infrastructure.

Defining and extracting risks are defined in CPP-023 **Risk Definition and Extraction**, which defines how these risks are mitigated. Risk mitigation in digital preservation refers to the systematic identification, assessment, and management of threats that could lead to the loss, corruption, or inaccessibility of digital materials over time. It is a proactive approach to ensure long-term access to digital content by addressing potential problems before they become critical.

The process takes a risk inventory as input. This risk inventory identifies several Objects, Metadata and other information that are included in the mitigation process (e.g. Representations, Files and Information packages, Technical metadata and system configuration). The process creates preservation action plans (such as migration paths, preservation plans and updated policies) that take the identified risk into account and reports that will be acted upon by other processes.

Beyond risk identification and risk assessment, which are in the scope of Risk Definition and Extraction, this Risk Mitigation encompasses the following components: * *Mitigation Strategies* are the specific actions taken to reduce identified risks. These include format migration (converting *Files* to more stable or widely-supported formats), emulation (creating software environments that can run obsolete programs), replication (maintaining multiple copies across different locations and storage systems), documentation (maintaining detailed *Metadata* and technical specifications), and regular monitoring (systematic checking of file integrity and accessibility). * *Creating and maintaining policies* ensures that the TDA has documented procedures that define and govern how mitigation strategies are implemented for identified risks, including 1) storage management related policies (the use of different types of storage media, geographically dispersed storage, life cycle management of hardware defining periodic integrity checks, the number of copies needed to create redundancy), 2) actionable preservation plans (defining means to preserve significant properties in file formats), and 3) quality assurance in the ingest phase (identification, validation, virus checks, *Metadata* requirements). * *Monitoring and Review* ensures that preservation strategies remain effective over time. This involves regular audits of digital collections, updating risk assessments as new threats emerge, and adjusting preservation plans based on changing technological landscapes or organisational priorities.

## Authors
- Mikko Laukkanen
- Juha Lehtonen

## Contributors
- Bertrand Caron
- Johan Kylander

## Evaluators
- Franziska Schwab
- Maria Benauer

## Process Definition

### Inputs

| Type     | Input          |
| :------- | :------------- |
| Guidance | Risk inventory |

### Outputs

| Type     | Output                    |
| :------- | :------------------------ |
| Guidance | Preservation action plans |

### Trigger Events

| Description                                                     | Corresponding CPP |
| :-------------------------------------------------------------- | :---------------- |
| Planned or performed ingestion of a *File* in a new file format | `CPP-008`         |
| Operational and statistical reports of *Digital Object* usage   | `CPP-013`         |
| Changes in the community                                        | `CPP-018`         |
| Data quality reports                                            | `CPP-019`         |
| Detected risks                                                  | `CPP-023`         |

## Process Steps

| Step | Supplier(s) | Input(s)                                                   | Description                                                                                                                        | Output(s)                                                                  | Customer(s) |
| :--- | :---------- | :--------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------- | :---------- |
| 1    | `CPP-023`   | - Risk inventory (such as<br>                            format specifications,<br>                            provenance, usage<br>                            statistics, knowledge of<br>                            threats and vulnerabilities<br>                            targeted at file formats and<br>                            storage systems, historical<br>                            data (i.e. learnings from the<br>                            past), vendor dependencies)<br>- *Metadata*<br>- *Representations, Files, Objects*<br>- Quality reports<br>- Statistical reports<br>- Changes in the designated communities | TDA finds out through ingest of<br>                        new content, various reports, new<br>                        risk assessments or changes in<br>                        the designed community, that<br>                        content in a TDA is at risk (e.g.<br>                        that there are *Objects* in its<br>                        holdings that are subject to threats<br>                        related to file format issues) |                                                                            |             |
| 2    |             | - Information about threats related to the particular risk | The risk is investigated and<br>                        evaluated in terms of possible<br>                        data loss, loss in quality,<br>                        significant property or feature<br>                        degradation, risks related to the<br>                        semantic understanding of the<br>                        content (i.e. insufficient *Metadata*) | - Investigation data about threats related to the risk                     | `CPP-019`   |
| 3    |             | - Investigation data about threats related to the risk     | The TDA formulates a risk mitigation plan and actions. It may include:<br>                    <br>•  Triggering preservation actions (such as Format Migration planning or Metadata Ingest and Management)<br>                        <br>•  Formulating or updating new policies and plans that govern the TDA (e.g. updated preservation plans for a specific file format)<br>                        <br>•  Creating reports on *Objects, Metadata*, statistical usage to facilitate decision making about risk mitigation | - Migration paths and migration plans<br>- Preservation plans<br>- Other policies such as storage media usage,<br>                            geographical dispersion of stored copies,<br>                            frequency of integrity checking intervals etc. | `CPP-003`<br>`CPP-011`<br>`CPP-013`<br>`CPP-014`<br>`CPP-015`<br>`CPP-016`<br>`CPP-030` |

## Rationale / Worst Case

| Purpose                                                                                   | Worst Case                                                                                        |
| :---------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------ |
| The CPP is very important in terms of guaranteeing the availability and<br>                    accessibility of the *Digital Objects* and thus, in a larger aspect, <br>                    the operations and usability of the TDA. | *Digital Objects* may become inaccessible, even in a non-reversible <br>                    way (e.g. due to corruption or data in proprietary, undocumented file formats<br>                    without software support)<br>                With missing *Metadata*, the understandability of the Digital Objects <br>                    is lost<br>                Operational disruption of TDA<br>                Financial and legal consequences<br>                Cultural heritage loss<br>                Reputation damage |

## Relationships

| Type          | Related CPP | Description                                                                                         |
| :------------ | :---------- | :-------------------------------------------------------------------------------------------------- |
| Requires      | CPP-009     | Preservation actions (i.e. migration, emulation) in the storage depend on the <br>                    identification of *Files* that share the same properties. |
| Requires      | CPP-018     | Changing community needs affect the risks and the mitigation of those.                              |
| Requires      | CPP-023     | Risk mitigation is applied to the risks as defined in CPP-023.                                      |
| Required by   | CPP-003     | The frequency and target of periodic integrity checks is defined by an<br>                    institutional digital preservation policy as part of risk mitigation. |
| Required by   | CPP-004     | The number of parallel copies and their storage settings (i.e. storage media,<br>                    locations) are defined in a TDA’s policy that arises out of mitigating risks to<br>                    preserved data. |
| Required by   | CPP-007     | Virus scanning is a direct risk mitigation activity against threats to<br>                    content integrity and system security triggered by CPP-012. |
| Required by   | CPP-011     | A TDAs storage policy that defines how data is stored, the amount of<br>                    parallel copies etc. is based on a TDAs risk assessment and mitigation. |
| Required by   | CPP-014     | Format migration requires this investigative process to determine the<br>                    migration path that it should apply. |
| Required by   | CPP-015     | Risk Mitigation is in charge of defining the emulation and rendering policy that<br>                    is meant to be applied by CPP-015. |
| Required by   | CPP-021     | Risk Mitigation acts as a supplier to AIP Versioning by providing risk<br>                    mitigation policy details for handling the retention of previous versions (i.e.<br>                    partial, total retainment or disposal). |
| Required by   | CPP-026     | The Risk Mitigation CPP is in charge of designing normalisation paths whose<br>                    output would retain all significant properties. |
| Required by   | CPP-027     | Risk Mitigation, as the provider of all actions aiming at limiting the impact or<br>                    likelihood of identified risks, is intended to prescribe appropriate methods to<br>                    repair the *File* or *Representation*. |
| Required by   | CPP-030     | The strategy for data storage and storage infrastructure management is<br>                    defined in a storage management policy as based on a TDAs risk<br>                    assessment and mitigation. |
| Affinity with | CPP-013     | To plan and mitigate risks in preservation, a TDA needs to provide<br>                    input on the preservation system; the quality of the data; significant<br>                    properties in *Objects*; *Storage management metadata* etc. |
| Affinity with | CPP-029     | The ingest process must adhere to the risk mitigation policies.                                     |

## Framework Mappings

| Framework     | Term                                            | Section                                                                              |
| :------------ | :---------------------------------------------- | :----------------------------------------------------------------------------------- |
| CoreTrustSeal | Preservation plan                               | The process is the main subject of R09 Preservation Plan but is implicitly<br>                    referred to in most of the requirements. |
| Nestor Seal   | (risk analysis) planned countermeasures         | Term mentioned in C34 Security but the activity is implicitly referred to in most of<br>                    the requirements. |
| ISO 16363     | Risk management and risk mitigation             | 3.1.2.1<br><br>5.1.1                                                                 |
| OAIS          | Risk mitigation (part of preservation planning) | 4.2.3.7<br><br>6.2.7                                                                 |

## Reference Implementations

### Use Cases

| Title                                            | Institution                                                                        | Documentation | Problem                                                                                  | Solution                                                                                                                                                                                                                                                                                                  |
| :----------------------------------------------- | :--------------------------------------------------------------------------------- | :------------ | :--------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Access to PDFs incorporating Rich Media features | TIB – Leibniz Information Centre for Science and Technology and University Library |               | TIB received a PDF in 2025, for which the extractor tool<br>                        veraPDF indicates that it contains videos as Rich Media, a<br>                        feature included in the PDF specification version 1.7. Noticing<br>                        that most PDF viewers display the video as a still image, and no<br>                        warning to the user, it studies a way to handle the problem. | <pre><code>As the File is valid, no migration is suggested; instead, a
                        rendering solution for displaying the embedded video is
                        identified for future access: the Okular viewer is then
                        recommended for this purpose.</code></pre> |

### Public Documentation

| Institution                                                                        | Link                                                                                                                           | Comment |
| :--------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------- | :------ |
| TIB - Leibniz Information Centre for Science and Technology and University Library | https://wiki.tib.eu/confluence/spaces/lza/pages/93608641/Preservation+Management#PreservationManagement-Riskmanagement         |         |
| Archivematica                                                                      | https://www.archivematica.org/en/docs/archivematica-1.17/user-manual/preservation/preservation-planning/#preservation-planning |         |



---

