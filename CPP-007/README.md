# Virus Scanning

**Short Definition:** Information packages are virus checked, with appropriate facilities for quarantine.

## Description and Scope
Virus scanning is the process of examining *Files* as proposed for ingestion into an archive for the presence of malicious software (i.e. malware) such as viruses, trojans, worms, spyware, and ransomware etc. The primary goal of virus scanning is to detect and prevent such harmful code from entering the digital archive to safeguard the integrity and trustworthiness of the preserved content. This security measure protects not only the archival system itself, but also users or other connected systems that access or receive content from the archive. Effective virus scanning is a core step of the ingest process and an essential strategic component in **Risk Mitigation** (CPP-012), ensuring that the archive remains a secure and reliable repository for digital assets. It is a means to mitigate deliberate, human-made threats to digital preservation.

Virus scanning is first and foremost applied during ingest, acting as a checkpoint before *Files* are fully accepted and integrated into a TDA's holdings. In addition, it may be triggered during preservation (archival storage) or dissemination. This may be done either to ensure that no viruses have infected the content after ingest, or to make sure that disseminated content has been checked using up-to-date signature databases.

A TDA must employ virus scanning tools and malware signature databases to ensure effective and up-to-date threat detection. This includes a process to maintain and frequently update a malware signature database that is used by the virus scanning tools. The system must provide secure workspaces and guidelines for managing detected threats, which typically involves isolating suspicious *Files* in a staging or quarantine area to prevent potential harm to the storage. The TDA can reject and remove the contaminated *Files* or *Information packages* during ingest in cases where decontamination is not a viable option.

All scanning activities, detected threats, and subsequent actions (i.e. quarantine, rejection, deletion) must be documented as part of the ingest record and preservation actions as *Provenance metadata*. This documentation contributes to the audit trail of the ingested *Files* and should be incorporated into broader **Object Management Reporting** (CPP-013).

## Authors
- Mattias Levlin
- Johan Kylander

## Contributors
- Kris Dekeyser

## Evaluators
- Felix Burger
- Maria Benauer
- Fen Zhang

## Process Definition

### Inputs

| Type     | Input                                    |
| :------- | :--------------------------------------- |
| Data     | Information package(s)                   |
| Guidance | Malware signature database(s)            |
| Guidance | Guidelines for managing detected threats |

### Outputs

| Type     | Output              |
| :------- | :------------------ |
| Metadata | Provenance metadata |
| Guidance | Scan report         |

### Trigger Events

| Description                       | Corresponding CPP |
| :-------------------------------- | :---------------- |
| Periodic quality check of *Files* | `CPP-019`         |
| Pre-access check of DIPs          | `CPP-025`         |
| Ingest                            | `CPP-029`         |

## Process Steps

| Step | Supplier(s) | Input(s)                                              | Description                                                                                           | Output(s)                                                                               | Customer(s) |
| :--- | :---------- | :---------------------------------------------------- | :---------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------- | :---------- |
| 1    | `CPP-029`   | - *SIP(s)*                                            | Receive and Stage Content: Content arrives and is placed <br>                        in a temporary, isolated staging area designated for <br>                        pre-ingest checks | - *SIP(s)* in the staging area                                                          |             |
| 2    | `CPP-019`   | - *AIP(s)*                                            | Select *AIP(s)* for virus scan <br>                        and copy their *Files* to the staging <br>                        area for checks | - *AIP(s)* in the staging area                                                          |             |
| 3    |             | - *File(s)* in staging area<br>- Configured virus scanners | Perform Scan: Initiate a comprehensive scan of all <br>                        *Files* within the staged *Information packages* | - Scan report/log (indicating clean *Files*, <br>                            and any detected threats with file paths and malware names) |             |
| 4    |             | - Scan report/log                                     | Evaluate Scan Results                                                                                 | - All *Files* reported as clean (step 7)<br>- Any *Files* reported as infected or suspicious (step 5) |             |
| 5    |             | - Infected/suspicious file(s)<br>- Scan report<br>- Guidelines for managing detected threats | Handling infected or suspicious *Files*, <br>                        the TDA conducts a first analysis | - Decontamination recommended:  Move the identified <br>                            *File(s)* to a secure quarantine area, <br>                            isolated from other systems and content for further <br>                            analysis and potential disinfection, and inform <br>                            dedicated staff members (step 6)<br>- Rejection recommended: Mark the *File(s)* (or <br>                            the entire *SIP(s)* (as in case of ingest) <br>                            for rejection. Notify the producer with reasons, if <br>                            appropriate and/or defined by policy (end of the <br>                            process) | `CPP-013`   |
| 6    |             | - Quarantined file(s)<br>- Notification to staff      | In-Depth Analysis: The personnel analyses the threat, <br>                        leading to multiple potential outcomes | - False positive identified: the detected malware does <br>                            not pose a threat. Whitelist the threat and move <br>                            the *Files* from quarantine back to the <br>                            staging (loop back to step 1)<br>- Decontamination required and possible: The TDA <br>                            disinfects the *Files* and moves the <br>                            *Files* from quarantine back to the staging <br>                            (loop back to step 1)<br>- Decontamination required but not possible: Notify <br>                            stakeholders: The TDA notifies the stakeholders <br>                            that their content is at risk and that it most <br>                            likely must be deleted and re-submitted. The <br>                            *Files* are not moved away from the <br>                            quarantine area. This is a more likely outcome for <br>                            AIP *Files* that are scanned during the <br>                            preservation (triggered by CPP-019). (step 7) |             |
| 7    |             | - Scan report<br>- Actions taken (quarantine, disinfection, rejection) | Record the virus scan and its Outcome as a Preservation Event<br><br>                        This documentation should include:<br>                    <br>•  Datetime of scan<br>                        <br>•  Scanner software name<br>                        <br>•  Virus definition file version/date<br>                        <br>•  Files scanned<br>                        <br>•  Outcome for each file (e.g., 'clean', 'infected - [virus_name]', 'quarantined', 'rejected').<br>                        <br>•  Any additional actions taken | - *Provenance metadata*                                                                 | `CPP-013`<br>`CPP-016` |
| 8    |             | - Clean *File(s)*<br>- Documentation of scan event    | Proceed with Clean Content or finalise Rejection:<br>                    <br>•  If content is clean: release Files from the staging area or proceed with ingest<br>                        <br>•  If any relevant content was rejected: Finalise the rejection process and archive the documentation | - Clean *File(s)* passed to the next ingest <br>                            stage, or rejection process completed | `CPP-013`   |

## Rationale / Worst Case

| Purpose                                                       | Worst Case                                                 |
| :------------------------------------------------------------ | :--------------------------------------------------------- |
| Detection of malware in *SIP(s)*                              | Ingest of contaminated *Files*, <br>                    risking destruction of the entire TDA. |
| Process to handle and potentially reject and delete infected <br>                    *SIP(s)* | Ingest of contaminated *Files*, risking destruction <br>                    of the entire TDA |
| Processes to maintain up-to-date malware signature databases <br>                    and virus scanning tools | Ingest of contaminated *Files,* <br>                    risking destruction of the entire TDA |
| Detection of malware in AIP(s)                                | Risking destruction of the entire TDA.                     |

## Relationships

| Type                    | Related CPP | Description                                                                       |
| :---------------------- | :---------- | :-------------------------------------------------------------------------------- |
| Requires                | CPP-012     | Virus scanning is a direct risk mitigation activity against <br>                    threats to content integrity and system security triggered <br>                    by CPP-012. |
| Required by             | CPP-013     | Reports on virus scanning activities, frequency of threats, <br>                    and outcomes of the actions provide essential input for <br>                    operational management and risk assessment. |
| Required by             | CPP-019     | Virus scanning is performed as a step in the overall Data <br>                    Quality Assessment process. |
| Required by             | CPP-029     | Virus scanning is one of the core processes that must be <br>                    performed during ingest. |
| Affinity with           | CPP-003     | Both processes aim to ensure the "health" of Files. However, <br>                    Integrity Checking focuses on detecting technical corruption <br>                    of Files (e.g. bit rot), whereas virus scanning looks to <br>                    mitigate human-made risks ( e.g. malicious code). |
| Not to be confused with | CPP-004     | If a File is detected as infected and cannot be cleaned, it <br>                    might be considered "damaged." However, CPP-004 typically <br>                    applies to technical corruption or loss, rather than <br>                    deliberately human-made damage such as malware-infected <br>                    Files. In practice, infected Files are more likely to be <br>                    replaced (by the producer) or rejected. |
| Not to be confused with | CPP-010     | Both processes scan the Files to ensure that they are <br>                    suitable for preservation. File Format Validation checks if <br>                    a file conforms to its purported format specification (e.g. <br>                    is this a valid PDF/A file?) while Virus Scanning checks for <br>                    malware, regardless of format validity. |

## Framework Mappings

| Framework     | Term                                                               | Section                               |
| :------------ | :----------------------------------------------------------------- | :------------------------------------ |
| CoreTrustSeal |                                                                    |                                       |
| Nestor Seal   |                                                                    |                                       |
| ISO 16363     |                                                                    |                                       |
| OAIS          | Quality Assurance (within Ingest), Security                        | 4.2.3.3<br><br>4.3.4                  |
| PREMIS        | Event (with eventType 'virus check', Agent (the scanning software) | Event Entity<br><br>Agent Entity<br><br>eventType Controlled vocabulary (2.2) |

## Reference Implementations

### Use Cases

| Title                               | Institution                               | Documentation           | Problem                                                                 | Solution                                                                                                                                                                                                                                    |
| :---------------------------------- | :---------------------------------------- | :---------------------- | :---------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Virus Scan as Part of Ingest at CSC | CSC – IT Center for Science Ltd., Finland | https://www.clamav.net/ | Files must be scanned for viruses as part of the <br>                        ingest pipeline to protect the TDA from viruses | <pre><code>Python script to detect viruses using ClamAv virus 
                        scanner


                        def check_virus(path):

                        """Scan files in directory with ClamAV virus scanner.</code></pre> |

### Public Documentation

| Institution                                                                        | Link                                                                                                             | Comment                                                                                                                       |
| :--------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------- |
| TIB – Leibniz Information Centre for Science and Technology and University Library | https://wiki.tib.eu/confluence/spaces/lza/pages/93608618/Ingest                                                  |                                                                                                                               |
| CSC – IT Center for Science Ltd.                                                   | https://digitalpreservation.fi/en/services/quality_reports/2024                                                  | Monitoring of the Digital Preservation Services: "Up-to-date status of the virus check database"                              |
| Archivematica                                                                      | https://www.archivematica.org/en/docs/archivematica-1.14/user-manual/transfer/scan-for-viruses/#scan-for-viruses |                                                                                                                               |
| DANS (Data Archiving and Networked Services), Netherlands                          | https://www.coretrustseal.org/wp-content/uploads/2018/04/DANS-Electronic-Archiving-SYstem-EASY-.pdf              | "Virus-scans are performed periodically for ingest by the web interface and standard for all other ingest ways (like SWORD)." |



---

