# AIP Versioning

**Short Definition:** The TDA creates successive versions of the Information Objects on its own or on the producer initiative.

## Description and Scope
Updating AIPs is a common operation in a TDA that involves keeping track of changes to data or Metadata, and preserving previous versions (entirely or partially) in order to go back to different stages of an AIP. Either the producer or the TDA may initiate an update, usually because of technical or contextual changes on the level of File, Representation or Metadata.

Reasons for Versioning include, but are not limited to:

For contextual quality reasons: * Removal of data * Fault in the initial deposit: An AIP or Representation contains File(s) that were not supposed to be part of the deposit (e.g. system Files not needed for preservation); * Content being retracted after the initial deposit: An AIP or Representation contains File(s) that were withdrawn (e.g. due to security reasons, legal restrictions). * Update of data * Update of File(s): An AIP or Representation contains File(s) that have been replaced (e.g. due to faults in the initial deposit); * Enrichment or correction of Descriptive Metadata; * Update of administrative Metadata (e.g. due to changes in the access rights or legal information for an AIP). * Addition of data * Incomplete initial deposit: The initial Information Package was missing Files and some need to be added after its ingest; * Enhancement of the initial deposit: After ingest of the Information Package (IP), additional material was issued and needs to be preserved in the IP.

For technical quality reasons: * Replacement or Update due to preservation action: A File or Representation has been migrated into a format deemed more suitable for preservation; * Replacement or Update due to new packaging: A File or Representation has been re- or unpackaged (e.g. for ZIP, TAR, WARC or disk image containers).

For Metadata quality reasons: * Addition or replacement of Technical metadata as a consequence of re-running a characterisation process (i.e. Format Identification, Metadata Extraction or Format Validation) on already ingested AIPs (e.g. due to a new tool being released).

Updates might involve the submission of a new SIP by the producer (e.g. in the case of changes to the initial deposit), but can also just take place on the storage level (e.g. new data being added as a result of a preservation action) without a SIP being involved.

In comparison to other IT domains, updating and creating new versions in digital preservation exhibits peculiarities for the following reasons: * On the File level: As data and Metadata are generally stored in physical containers (such as ZIP, TAR, WARC, etc.), unpacking and merging content from the incoming SIP is a complex and risky process; * On the storage level: As physical containers corresponding to IPs are usually stored on tape or other cold-storage technologies, updates are generally asynchronous; * On the Metadata level: Authenticity and audit trail requirements imply that TDAs record precisely all details about the versioning impacts (e.g. requester, date, reasons, impacted data and Metadata, etc.). This is of particular importance when the versioning is requested by TDA and when the new version replaces the original one.

A TDA must have a versioning policy in place for handling and documenting retracted or updated data. It may decide to partially or totally retain the older versions, based on several factors such as reversibility (e.g. addition of new Files versus replacement of Files), purpose of the update (e.g. correction, enrichment, risk mitigation, etc.), issuer of the updating request (i.e. Producer or TDA), etc.

The implementation of updates to AIP (i.e. data and/or Metadata) requires consideration of a range of factors including a) what is being updated and with what frequency, b) whether that should result in a new AIP version or simply an update to the current version, c) how often the different versions of the AIP need to be accessed, d) how the AIP is stored internally (e.g. using databases, file systems, tape libraries, cloud storage), and e) how versions are serialised and exported from the TDA when they need to be exchanged with third-parties.

Specific implementation approaches are outside of the scope of this CPP.. However, some considerations may include: * Are there regular and incremental updates in dynamic collections of content? If so, consider storing the changes (deltas) between AIP versions, rather than complete AIPs, which can reduce both storage requirements and processing overhead. * Are there any changes to the AIP content that do not require versioning (e.g. recording the results of fixity checks). If so, consider mechanisms that allow efficient tracking of preservation actions, such as preservation Metadata updates, without duplicating or accessing unchanged content. * Is there a need for enhanced traceability and provenance so that it is easy to follow the evolution of AIPs over time, without needing to access or analyse internal Metadata? If so, consider additional indexing and logging mechanisms alongside AIP storage. * The ability to access the deltas between AIPs instead of whole versions can support easier integrity checks and rollback capabilities (e.g. enabling recovery from data corruption without full AIP restores). * Is there a need to externalise and exchange AIPs with third parties (e.g. repository migration, synchronisation, and replication)? Exchanging AIP versions as deltas can enable more efficient data transfer across distributed or replicated preservation systems. * If some or all of AIPs are held using offline media, then minimising data handling can be desirable to reduce the risk of corruption or damage when media is retrieved or read. Isolating and preserving only changed components of AIPs can reduce unnecessary manipulation of stable data, which lowers the risk of inadvertent corruption, loss, or operational error.

## Authors
- Bertrand Caron

## Contributors
- Micky Lindlar
- Kris Dekeyser

## Evaluators
- Matthew Addis
- Maria Benauer
- Fen Zhang

## Process Definition

### Inputs

| Type     | Input                                                                                                                             |
| :------- | :-------------------------------------------------------------------------------------------------------------------------------- |
| Data     | AIP                                                                                                                               |
| Data     | Optional: SIP (if Versioning is triggered by an updating request the Producer)                                                    |
| Data     | Optional: File(s) or Representation(s) that should replace existing ones or be added to an AIP                                    |
| Metadata | Metadata that should be added to the Information Package (i.e. Descriptive, Technical, Structural and/or Administrative metadata) |
| Guidance | Versioning Policy                                                                                                                 |
| Guidance | AIP packaging policy                                                                                                              |

### Outputs

| Type     | Output                                                    |
| :------- | :-------------------------------------------------------- |
| Metadata | Provenance metadata                                       |
| Metadata | Storage management information (new version identifier)   |
| Metadata | Updated Descriptive, Technical and/or Structural Metadata |

### Trigger Events

| Description                                                             | Corresponding CPP |
| :---------------------------------------------------------------------- | :---------------- |
| Updating request from the Producer in the form of an SIP ingest request |                   |
| Data must be removed or redacted because of legal constraints           | `CPP-020`         |
| Re-run of a characterisation process (e.g. when a new <br>                        tool or new tool version is made available) | `CPP-008`         |
| New Representations created by the TDA need to be added <br>                        or should replace the original | `CPP-014`         |

## Process Steps

| Step | Supplier(s) | Input(s)                                                            | Description                                                                     | Output(s)                                | Customer(s) |
| :--- | :---------- | :------------------------------------------------------------------ | :------------------------------------------------------------------------------ | :--------------------------------------- | :---------- |
| 1    |             |                                                                     | Retrieve corresponding AIP Metadata                                             |                                          |             |
| 2    |             |                                                                     | Identify the scope of versioning                                                | - Update of Metadata (step 3a)<br>- Addition or removal of Files (step 3b)<br>- Replacement of an AIP (step 3c) |             |
| 3a   |             | - Additional incoming Metadata<br>- AIP Metadata                    | If the intended update concerns only Metadata, update <br>                        the AIP Metadata | - Digital archive database update        |             |
| 3b   |             | - SIP (if relevant)<br>- AIP<br>- File(s) or Representation(s) that should replace <br>                            existing File(s) or be added to the AIP<br>- Versioning policy | If the update involves the addition of Files, request <br>                        corresponding physical AIP and perform merging with <br>                        incoming data and Metadata | - Content of the new AIP version<br>- Digital archive database update |             |
| 3c   |             | - Versioning policy                                                 | If the update is a “full update”, ingest data and <br>                        Metadata as a complete replacement of the previous AIP <br>                        version | - Digital archive database update        |             |
| 4    | `CPP-005`   | - New PID for the new AIP version                                   | Request new identifier for the new AIP version                                  | - AIP version with PID assigned          |             |
| 5    |             |                                                                     | Document the date, requester, data or Metadata impacted, <br>                        and reason for the versioning | - Provenance metadata                    |             |
| 6    |             | - Content of the new AIP version<br>- AIP packaging policy          | Repackage the content of the new AIP according to the <br>                        TDA’s current packaging standards | - New AIP                                | `CPP-029`   |
| 7    | `CPP-012`   | - Versioning policy                                                 | Manage the retention of previous version(s) (i.e. partial, <br>                        total retainment or disposal) |                                          |             |

## Rationale / Worst Case

| Purpose                                                                           | Worst Case                                                                         |
| :-------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------- |
| Digital Objects are dynamic and easy to modify, correct or <br>                    enrich. Producers generally use this particularity to update <br>                    them for various reasons. A TDA should be able to manage <br>                    versioning in order to identify and preserve successive AIP <br>                    versions. | Inability to handle updating requests from the Producer <br>                    causes duplication because the TDA needs to store subsequent <br>                    AIP versions as new AIPs. See Caron, B. and Verrier, L. 2024. <br>                    From Products to Library Collections: Towards a Data-driven <br>                    Policy for Legal Deposit of Born-digital Sound at the <br>                    National Library of France. iPRES 2024 Papers - <br>                    International Conference on Digital Preservation. Available <br>                    at<br>                    [](https://ipres2024.pubpub.org/pub/6m5xlcii/release/1)<br>                    . |
| Producers may want to perform complex updating operations <br>                    involving several changes to different parts of an AIP and <br>                    combine all changes into a single version. | Successive, incomplete changes performed by the Producer may <br>                    lead to the TDA’s inability to identify stable and complete <br>                    versions. |

## Relationships

| Type     | Related CPP | Description                                                                        |
| :------- | :---------- | :--------------------------------------------------------------------------------- |
| Requires | CPP-005     | Every new AIP version must be assigned a new identifier. <br>                    The design and versioning of identifiers (e.g. creation of <br>                    entirely new identifiers, use of version qualifiers etc.) <br>                    should be defined in a persistent identifier minting policy. |
| Requires | CPP-009     | Soft dependency (i.e. may require): The documented event, <br>                    datetime, and Provenance metadata from the Metadata <br>                    Extraction process may be required by AIP Versioning. |
| Requires | CPP-012     | Risk Mitigation acts as a supplier to AIP Versioning, <br>                    providing AIP Versioning with risk mitigation policy details, <br>                    as they relate to managing risks in retention of previous <br>                    version(s) (i.e. partial, total retainment or disposal). |
| Requires | CPP-029     | Versioning implies several delicate operations, in particular <br>                    in the case of a partial update, where the incoming SIP <br>                    should be merged with the existing AIP. |
| Affects  | CPP-006     | Versioning impacts how the export will have to be run and <br>                    where and how information about the versions may be found. <br>                    In addition a policy might determine if only the last or all <br>                    versions should be exported. |

## Framework Mappings

| Framework     | Term                        | Section                                                                                                                                                                                                                                                            |
| :------------ | :-------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| CoreTrustSeal | versions                    | Provenance and authenticity (R07) The repository guarantees <br>                    the authenticity of the digital objects and provides <br>                    provenance information." includes "The repository approach <br>                    to changing and versioning data and metadata. How the <br>                    approach and records of changes are communicated to data <br>                    depositors and users." |
| Nestor Seal   | versions                    | Topic not addressed, but briefly mentioned in C27 Identification                                                                                                                                                                                                   |
| ISO 16363     | versions                    | AIP Versions and Editions are essential notions of the OAIS <br>                    / ISO 16363 model. No AIP versioning operation is described, <br>                    but the notion of versions is touched upon in the following <br>                    sections:<br><br>* 4.2.1.1 The repository shall have a definition of each AIP or class of AIPs that is adequate for long-term preservation, enabling the identification, extraction and interpretation of all the required components within each AIP.<br>                    <br>•  4.3.5 The repository must be able to export the relevant AIPs to its successor location in the timescale required, together with supplementary information including specifications of the AIPs adequate for the information contained in them to be extracted.<br>                    <br>•  4.4.1.1 The repository shall preserve the Content Information of AIPs<br>                    <br>•  5.1.2 The repository shall manage the number, security, coordination, and location of copies of all digital objects. |
| OAIS          | AIP Version<br>                AIP Edition | Section 5.2.4.6 "Distinguishing AIP Versions, AIP Editions <br>                    and Derived AIPs"<br><br>OAIS distinguishes AIP Versions (triggered by migrations <br>                    performed by the Archive) and AIP Editions (triggered by <br>                    update requests from the Producer). |
| PREMIS        |                             | PREMIS does not approach versioning. Nevertheless, the "1:1 <br>                    principle" implies that if an Object (Representation, File <br>                    or Bitstream) is modified by the repository, this operation <br>                    creates a new Object that is declared as being derived from <br>                    the source Object. |

## Reference Implementations

### Use Cases

| Title                                            | Institution                      | Documentation                          | Problem                                                           | Solution                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| :----------------------------------------------- | :------------------------------- | :------------------------------------- | :---------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| BnF Information Package lifecycle Implementation | Bibliothèque nationale de France | https://bnf.hal.science/hal-01617645v1 | The paper describes scenarios for partial updates which <br>                        may have varying impacts on existing AIPs | <pre><code>Following an unsuccessful attempt to implement an 
                        algorithm to determine the nature of update operations, 
                        based on structural comparisons between incoming SIPs 
                        and existing AIPs, BnF adopted a policy that permits 
                        only full updates. As a result, producers are required 
                        to request the relevant AIP and take responsibility for 
                        merging it with the SIP according to their needs.</code></pre> |

### Public Documentation

| Institution                                                                        | Link                                                                                                                                                                             | Comment |
| :--------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------ |
| TIB – Leibniz Information Centre for Science and Technology and University Library | https://knowledge.exlibrisgroup.com/Rosetta/Product_Documentation/Rosetta_Staff_Users_Guide/Web_Editor/001_Web_Editor/003_Viewing_Digital_Objects_in_the_Web_Editor#Versions_Tab |         |
| Archivematica                                                                      | https://www.archivematica.org/en/docs/archivematica-1.17/user-manual/archival-storage/aic/#aic                                                                                   |         |



---

