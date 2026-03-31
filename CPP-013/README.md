# Object Management Reporting

**Short Definition:** The TDA delivers reporting to enable the effective management of Objects. This must include a wide range of functional, operational, and statistical reports and analytics.

## Description and Scope
Object management reporting is a process in which the TDA creates reports; outputs *Provenance metadata*; and produces statistical data on the content it preserves. The reporting is needed to enable effective management of *Objects*. Reporting is done for both the TDA itself, helping it in its preservation planning and as input for **Risk Mitigation** (CPP-012), and for the designated communities and stakeholders that produce and consume the data. Effective reporting enables a TDA to conduct digital preservation and to select the *Information packages* or *Objects* when performing preservation actions.

Reporting on the content includes reports and *Provenance metadata* from other CPPs that perform actions on digital content. For example, this includes processes that periodically check the quality of the data in **Data Quality Assessment** (CPP-019) or during triggered events such as **Ingest** (CPP-029) and **Enabling Access** (CPP-025): * Reports from periodic **Integrity Checking** (CPP-003); * Preservation actions taken and documented in **Data Corruption Management** (CPP-004); * **Virus Scanning** reports (CPP-007); * **File Format Identification** (CPP-008) reports; * **File Format Validation** (CPP-010) reports; * **File Migration** (CPP-014); * Data on **Emulation and Rendering Tools** (CPP-015); * *Metadata* from **Metadata Ingest and Management** (CPP-016); * *Metadata* from **Rights Management** (CPP-020); * *Metadata* from **Significant Properties Definition** (CPP-022); * Preservation actions taken and documented in **File Repair** (CPP-027); * Data from the **Creation of Derivatives** (CPP-028) process; * *Metadata* from the access and use of *Objects* in TDA by the designated community; * *Metadata* on the data volumes and growth rates of the *Objects* held by the TDA.

As the purpose of reporting is to enable the preservation and the management of digital *Objects*, the reports usually cover the main types of data that a TDA operates with. This may include data on: * File formats; * *Technical metadata* and significant properties of *Objects*; * Tools and software needed to manage the content; * The health of *Objects* and actions taken to remedy errors; * The hardware infrastructure; * *Metadata* and metadata standards; * The provenance of the *Objects*; * The licenses and rights to retain, preserve and provide access to *Objects*; * The level of usage of *Objects* in the TDA;

The report types produced in the reporting process can be categorised as follows: * *Statistical data* (e.g. number of *Objects*, file sizes etc.): Used for helping a TDA or stakeholder assess the scope of preservation actions; * *Provenance metadata* (i.e. documented preservation actions by the TDA): Used for assessing the state of *Objects*, the so called "health" of the *Files*, and to add authenticity by documenting the life-cycle of all digital content in a TDA; * *In depth machine-actionable reports* (usually produced by tools): These are used as input in other processes conducted by the TDA; * *Links to knowledge base resources* (e.g. file format registries): These are used to help a TDA in preservation planning.

Reporting activities as well as the report types listed above feed into a wide range of management processes and decision making. Some examples include: * Risk assessment and preservation planning (e.g. using reports on file formats); * Reporting to funders and stakeholders (e.g. by providing usage statistics); * Capacity planning and purchasing decisions (e.g. purchasing and refreshment of storage infrastructure based on statistics on data volumes and growth rates); * Compliance assessments (e.g. using reports on rights and participant consent to check that personal data is retained in compliance with GDPR); * Optimisation and cost management (e.g. identification of expensive or inefficient processes based on execution time and steps required, or optimising the use of different storage classes for frequently or infrequently accessed data based on usage statistics); * Identification of anomalies in error rates or failures (e.g. unusually problematic content from specific depositors); * Deaccessioning of *Objects* (e.g. reports on *Objects* that no longer need to be retained because their retention schedules are about to expire, or reports on quality assessment that mean *Objects* no longer meet the needs of a designated community); * Environmental sustainability (e.g. use of storage, processing and access statistics as an input to calculating carbon footprint).

When the process description uses the term *report*, it can be any of the above.

## Authors
- Johan Kylander

## Contributors
- Matthew Addis

## Evaluators
- Franziska Schwab
- Felix Burger
- Maria Benauer

## Process Definition

### Inputs

| Type     | Input               |
| :------- | :------------------ |
| Metadata | Provenance metadata |
| Metadata | Technical metadata  |
| Metadata | Rights data         |
| Metadata | Errors and Warnings |

### Outputs

| Type     | Output              |
| :------- | :------------------ |
| Metadata | Provenance metadata |
| Guidance | Reports             |
| Guidance | Statistical data    |

### Trigger Events

| Description                                                     | Corresponding CPP |
| :-------------------------------------------------------------- | :---------------- |
| Ingest                                                          | `CPP-029`         |
| Enabling Access                                                 | `CPP-025`         |
| Risk Mitigation                                                 | `CPP-012`         |
| Data Quality Assessment                                         | `CPP-019`         |
| Reporting needs from the stakeholders or designated communities |                   |

## Process Steps

| Step | Supplier(s) | Input(s)                                                                                             | Description                                                                                       | Output(s)                                                                      | Customer(s) |
| :--- | :---------- | :--------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------ | :----------------------------------------------------------------------------- | :---------- |
| 1a   | `CPP-029`   | - Reporting request (from CPPs, stakeholders or the consumers) in the form of a Report Specification | The TDA receives the request and determines what data is required to provide the requested report | - Specification of the data required for the report                            |             |
| 1b   |             | - Specification of the data required for the report                                                  | Determine if reporting data is available <br>                        (e.g. is it already an output of other CPPs) | - Availability of data required for the report                                 |             |
| 1c   |             | - Availability of data required for the report.                                                      | If the reporting data is not available:<br>                    * Determine the steps that would be needed in order to capture it<br>                        <br>•  Discuss reporting requirements with the requestor and agree revisions to report | - Modifications to (i) Report Specification and <br>                            (ii) Specification of data required for the report |             |
| 2a   |             | - Specification of data required for the report (from 1a or 1c)                                      | If needed, CPPs that produce the required data are revised so that the necessary <br>                        data is produced and compiles the report (as provided by other CPPs)<br>                    The TDA gathers and aggregates the data needed for the report. | - Data required for report                                                     |             |
| 2b   |             | - Data required for report<br>- Report Specification                                                 | The report is compiled and reviewed with the requestor..<br>                    If further modifications are needed to the data <br>                        and data collection, then go to step 2a. | - Finalised Specification of Report                                            |             |
| 3a   |             | - Reporting schedule                                                                                 | If the report is required on a regular basis, <br>                        e.g. monthly,   then a reporting schedule is set <br>                        and data is collected on a regular basis | - Data required for report                                                     | `CPP-012`<br>`CPP-019`<br>`CPP-025`<br>`CPP-029` |
| 3b   |             | - Data required for report (from 3a)                                                                 | Gather and aggregate data for report                                                              | - Data for report.                                                             |             |
| 3c   |             | - Data for report (from 3b)<br>- Finalised Report Specification (from 2b)                            | Produce Report and deliver to Requestor.<br>                    If a report is produced regularly, then loop to Step 3a. | - Report                                                                       |             |

## Rationale / Worst Case

| Purpose                                                        | Worst Case                                                                             |
| :------------------------------------------------------------- | :------------------------------------------------------------------------------------- |
| The TDA knows what *Information packages* it preserves <br>                    and what they contain | Without being able to locate and report the data it holds, the <br>                    TDA cannot perform any preservation actions or provide (e.g. <br>                    searching by *Rights*, *Provenance* and <br>                    *Descriptive metadata* within the *Information packages*). |
| The TDA knows which file formats it holds and can locate these<br>                    *Objects* within *Information packages* | Without knowing in what format the *Objects* it holds are, <br>                    the TDA cannot plan preservation actions or inform the designated <br>                    communities about preservation strategies. |
| The TDA knows what metadata standards it holds and which <br>                    standards apply to which *Objects* | Without being able to analyse the *Objects* and their <br>                    significant properties, the TDA cannot plan preservation actions, <br>                    provide discovery or access. |
| The TDA maintains and generates *Provenance metadata* <br>                    during preservation | Processes that produce reports and *provenance data* must <br>                    have their output stored. This information is needed to analyse <br>                    the *Objects* in a TDA, create quality reports, provide <br>                    designated communities with assurance of a high quality digital <br>                    preservation |
| The TDA knows its hardware infrastructure and <br>                    has a plan for its management | Without knowledge on the hardware infrastructure, the TDA <br>                    cannot maintain high-quality bit-level preservation and <br>                    report to the stakeholders. |
| The TDA knows the rights it has to preserve and<br>                    provide access to its holdings. | Without knowledge of rights and<br>                    retention schedules, the TDA cannot<br>                    know with confidence that it has the<br>                    permission to preserve its holdings or<br>                    whether it is holding content that should<br>                    be deaccessioned. |

## Relationships

| Type          | Related CPP | Description                                                                   |
| :------------ | :---------- | :---------------------------------------------------------------------------- |
| Requires      | CPP-003     | Periodic integrity checking provides reports on the<br>                    integrity of data and reports corrupted *AIPs*. |
| Requires      | CPP-004     | Fixing corrupted *AIPs* produces *Provenance metadata*<br>                    and data for quality reporting to the stakeholders. |
| Requires      | CPP-005     | Soft dependency (i.e. may require): The management and<br>                    reporting should require that the data is identified with<br>                    PIDs. |
| Requires      | CPP-007     | Reports on virus scanning activities, frequency of threats,<br>                    and outcomes of the actions provide essential input for<br>                    operational management and risk assessment. |
| Requires      | CPP-008     | File format identification reports are required for a TDA to<br>                    enable it to manage its content. |
| Requires      | CPP-010     | File format validation provide essential information on the<br>                    well-formedness and validity of the *Objects*; validation<br>                    errors; and data on the tools used in the process. |
| Requires      | CPP-014     | File migration provides information on the outcome of the<br>                    process as well as tools used. |
| Requires      | CPP-015     | The process of selecting tools for emulation and rendering<br>                    provides data to the TDA for reporting to the designated<br>                    communities. |
| Requires      | CPP-016     | Metadata ingest provides new *Provenance metadata*.                           |
| Requires      | CPP-022     | To report on the characteristics of *Objects* for deeper<br>                    analysis, the significant properties must have been<br>                    defined. |
| Requires      | CPP-027     | Fixing invalid *Files* produces *Provenance metadata* and<br>                    data for quality reporting to the stakeholders. |
| Requires      | CPP-028     | Creation of new *Objects* provides data for statistical<br>                    reporting. |
| Affinity with | CPP-029     | Ingest is both an important provider of<br>                    reporting data to the TDA (via other<br>                    CPPs) as well as a customer, as the<br>                    ingest checks and outcomes must be<br>                    reported to the producer. |
| Affinity with | CPP-025     | Enabling Access of contents include<br>                    providing *Provenance metadata*,<br>                    statistical data and quality reports to<br>                    the consumer. |
| Affinity with | CPP-012     | To plan and mitigate risks in<br>                    preservation, a TDA needs to provide<br>                    input on the preservation system, the<br>                    quality of the data, significant<br>                    properties in *Objects*, storage<br>                    management *Metadata* etc. |
| Affinity with | CPP-019     | To evaluate the quality of the data, the<br>                    process needs input in the form of<br>                    various *Metadata*. |

## Framework Mappings

| Framework     | Term            | Section                                                       |
| :------------ | :-------------- | :------------------------------------------------------------ |
| CoreTrustSeal |                 | Reporting is not defined directly as a<br>                    requirement, but as the category “Digital<br>                    Object Management”, which contains the<br>                    following requirements:<br><br>* Provenance and authenticity (R07)<br>                    <br>•  Deposit & Appraisal (R08)<br>                    <br>•  Preservation plan (R09)<br>                    <br>•  Quality Assurance (R10)<br>                    <br>•  Workflows (R11)<br>                    <br>•  Discovery and Identification (R12)<br>                    <br>•  Reuse (R13) |
| Nestor Seal   |                 | Reporting is not defined directly as a<br>                    requirement, but there are specific<br>                    requirements for various metadata<br>                    categories, which are specified with<br>                    reporting in mind:<br><br>* C27 Identification<br>                    <br>•  C28 Descriptive metadata<br>                    <br>•  C29 Structural metadata<br>                    <br>•  C30 Technical metadata<br>                    <br>•  C31 Logging the preservation measures<br>                    <br>•  C32 Administrative metadata |
| ISO 16363     |                 | Reporting as such is not described, but<br>                    referenced multiple times as a way for<br>                    the TDA to demonstrate that it is meeting<br>                    a requirement. See 3.2.1.3, 3.3.4, 3.5.1,<br>                    4.1.7, 4.6.2.1, 5.1.1.1, 5.1.1.3 and<br>                    5.1.1.3.1 |
| OAIS          | Generate Report | 4.2.3.5                                                       |
| PREMIS        |                 | PREMIS does not dedicate any<br>                    documentation to reporting, but it<br>                    mentions reporting when highlighting the<br>                    importance of storing events and<br>                    metadata. |

## Reference Implementations

### Public Documentation

| Institution                                                                        | Link                                                                                                                                   | Comment                                                                                                                                                                       |
| :--------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| TIB - Leibniz Information Centre for Science and Technology and University Library | https://knowledge.exlibrisgroup.com/Rosetta/Training/Rosetta_Essentials/Data_Management/7.1_Searching_the_Rosetta_Permanent_Repository |                                                                                                                                                                               |
| CSC - IT Center for Science Ltd.                                                   | https://digitalpreservation.fi/en/services/quality_reports/2024                                                                        |                                                                                                                                                                               |
| Archivematica                                                                      | https://www.archivematica.org/en/docs/archivematica-1.18                                                                               | Limited reporting. However, Archivematica is built on MySQL and ElasticSearch so there is the potential to generate more reports by directly accessing the databases/indexes. |
| Rosetta                                                                            | https://knowledge.exlibrisgroup.com/Rosetta/Training/Rosetta_Essentials/Data_Management/7.1_Searching_the_Rosetta_Permanent_Repository |                                                                                                                                                                               |



---

