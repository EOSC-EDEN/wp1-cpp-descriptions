# Data Corruption Management (CPP-004)

**Short Definition:** The TDA replaces damaged Files from replicated copies and reports on actions taken.

## Description and Scope
Data Corruption Management is a process, where a TDA restores corrupted *AIPs* from parallel copies. Corrupted *AIPs* are identified and flagged by the Integrity Checking (CPP-003) process, which periodically scans the fixity of *AIPs* .

When Integrity Checking (CPP-003) has flagged that an *AIP* is corrupted (i.e. that it has been unintentionally altered), the TDA recovers an intact copy from another storage medium in order to replace the corrupted *AIPs*. As part of the retrieval process, the checksums of the copied data are validated to verify a) the integrity of the data that is used as a source and, b) that the new target has been copied successfully. This is similar to the process of Replication (CPP-011). Subsequently, *Provenance metadata* is updated to maintain a record of the replacement procedure.

The replacing copy can be written to another storage medium than the corrupted one (e.g. in the case of magnetic tapes, where read-write operations to a single tape are kept to a minimum). In these cases, *Storage management information* must also be updated to reflect the new location of the copy.

The TDA may choose to replace the whole storage medium's content, triggering a process similar to Refreshment (CPP-030). This can be done when media-wide corruption or read/write errors are detected.

TData Corruption Management relies on the TDA having several parallel copies, preferably on different storage media and in different storage locations. The number of parallel copies, and their storage conditions are defined in the TDA’s policies as maintained by Risk Mitigation (CPP-012) and a copy management policy in particular. In accordance with agreed on best-practices, at least three copies are recommended, as there should exist at least two other valid copies in case one copy is corrupted or destroyed.

## Authors
- Johan Kylander

## Contributors
- Juha Lehtonen
- Bertrand Caron

## Evaluators
- Felix Burger
- Maria Benauer

## Process Definition

### Inputs

| Type     | Input                                                  |
| :------- | :----------------------------------------------------- |
| Data     | AIP(s)                                                 |
| Metadata | Fixity metadata (checksums, algorithms and timestamps) |
| Guidance | Copy management policy                                 |

### Outputs

| Type     | Output                                                        |
| :------- | :------------------------------------------------------------ |
| Metadata | Fixity metadata (checksums, algorithms and timestamps)        |
| Metadata | Provenance metadata (event date, details and agents involved) |
| Metadata | Storage Management information (storage location)             |

### Trigger Events

| Description                                             | Corresponding CPP |
| :------------------------------------------------------ | :---------------- |
| An AIP or File that has been flagged as corrupt         | `CPP-003`         |
| Media-wide corruption or read/write errors are detected |                   |

## Process Steps

| Step                                                                      | Supplier(s) | Input(s)                                                                                                | Description                                                                                                                                                                                                                                                                                           | Output(s)                                                                                                | Customer(s) |
| :------------------------------------------------------------------------ | :---------- | :------------------------------------------------------------------------------------------------------ | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------- | :---------- |
| **Sequence**                                                              |             |                                                                                                         |                                                                                                                                                                                                                                                                                                       |                                                                                                          |             |
|   ***1 Alternative: Elaboration of a media- or AIP-specific inventory***  |             |                                                                                                         |                                                                                                                                                                                                                                                                                                       |                                                                                                          |             |
|     1.a                                                                   | `CPP-003`   | - Integrity checking report                                                                             | Identify and locate corrupted *AIPs* (alternative: Elaboration of a media- or AIP-specific inventory)                                                                                                                                                                                                 | - Inventory of corrupted *AIPs* - Storage medium with broken *AIPs*                                      |             |
|     1.b                                                                   |             | - Report of media-wide errors                                                                           | Identify and locate the *AIPs* on the corrupted medium. (alternative: Elaboration of a media- or AIP-specific inventory)                                                                                                                                                                              | - Inventory of corrupted *AIPs* - Storage medium with media-wide errors packages                         |             |
|   2                                                                       | `CPP-012`   | - Copy Management Policy                                                                                | Select source medium to copy the *AIPs* from (sequence)                                                                                                                                                                                                                                               | - Authoritative storage medium for replicating/copying the *AIPs*                                        |             |
|   3                                                                       |             |                                                                                                         | Select target storage medium (can, and often is, be same as the                             original storage medium identified in step 1a) (sequence)                                                                                                                                                 | - Target storage medium                                                                                  |             |
|   4 *(optional)*                                                          |             |                                                                                                         | In case of media-wide errors: Provision of a fresh storage medium that                             will replace the old one. (sequence)                                                                                                                                                               | - The fresh storage medium that will replace the old one                                                 |             |
|   5                                                                       |             | - Source storage medium of *AIPs* - Target storage medium - Inventory of *AIPs* involved in the process | Gather AIP inventory and storage medium information to start the copy process (step 6) (sequence)                                                                                                                                                                                                     |                                                                                                          |             |
|   ***6 Sequence: For each AIP individually, copy AIP to storage medium*** |             |                                                                                                         |                                                                                                                                                                                                                                                                                                       |                                                                                                          |             |
|     6.1                                                                   |             |                                                                                                         | Retrieve the *AIP* from the source storage medium (sequence: For each AIP individually, copy AIP to storage medium)                                                                                                                                                                                   |                                                                                                          |             |
|     6.2                                                                   |             |                                                                                                         | Copy the *AIP* to the target storage medium (sequence: For each AIP individually, copy AIP to storage medium)                                                                                                                                                                                         | - New copy of AIP                                                                                        |             |
|     6.3                                                                   |             | - Existing Fixity metadata                                                                              | Validate the fixity of the *AIP* on the fresh storage medium (sequence: For each AIP individually, copy AIP to storage medium)                                                                                                                                                                        | - *Fixity Metadata* - Valid status (step 6.4) - Invalid status (go back to step 6.1)                     |             |
|     6.4                                                                   |             |                                                                                                         | Update the fixity for the new *AIP* copy (sequence: For each AIP individually, copy AIP to storage medium)                                                                                                                                                                                            | - *Fixity metadata*                                                                                      |             |
|     6.5 *(optional)*                                                      |             |                                                                                                         | If the target storage medium is different from the original storage                             medium with the broken *AIP*:                             Update the storage location for the new *AIP* copy (sequence: For each AIP individually, copy AIP to storage medium)                        | - *Storage management information*                                                                       |             |
|   7                                                                       |             | - Inventory of *AIPs* involved in the process                                                           | Check that all *AIPs* in the inventory have been successfully                             copied (sequence)                                                                                                                                                                                           | - Confirm completeness of the copy process (go to step 8) - Error (go back to copy process loop, step 6) |             |
|   8 *(optional)*                                                          |             |                                                                                                         | In case of media-wide errors:                         Update information about the fresh storage medium (e.g. *File*                             locations, media identifiers) and mark the old medium and its contents                             as ready for deletion/decommissioning. (sequence) | - *Storage management information*                                                                       |             |
|   9                                                                       |             |                                                                                                         | Document the event and its timestamp (sequence)                                                                                                                                                                                                                                                       | - *Provenance Metadata*                                                                                  |             |
|   10 *(optional)*                                                         |             | - Original storage medium that has been refreshed                                                       | In case of media-wide errors                         Ensure data security and that confidentiality is not compromised by                             making sure that data on the original storage medium is properly                             deleted. (sequence)                                 |                                                                                                          |             |
|   11                                                                      |             |                                                                                                         | Decommission the old storage medium (sequence)                                                                                                                                                                                                                                                        | - Record of decommissioning                                                                              |             |

## Rationale / Worst Case

| Purpose                      | Worst Case                                                                  |
| :--------------------------- | :-------------------------------------------------------------------------- |
| Parallel copies of the data. | Corrupted data cannot be restored unless parallel copies exist.             |
| *Fixity metadata*            | Data corruption cannot be detected, and replaced copies cannot be verified,<br>                    without *Fixity metadata*. |

## Relationships

| Type                    | Related CPP | Description                                                                                                                                                            |
| :---------------------- | :---------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Requires                | CPP-003     | Corrupted data is detected by periodic integrity checking.                                                                                                             |
| May require             | CPP-005     | If a *File* is corrupted, it may need to be repaired or replaced.<br>                    During this process, a new *PID* may be created.                              |
| Requires                | CPP-012     | The number of parallel copies and how they are stored (media, locations) are<br>                    defined in a TDA’s policy that arises out of mitigating risks to preserved<br>                    data.. |
| Required by             | CPP-013     | Fixing corrupted *AIPs* produces *Provenance metadata* and data<br>                    for quality reporting to the stakeholders..                                     |
| Affinity with           | CPP-002     | All new *AIP* copies must have their checksum validated to verify that<br>                    the process was successful. The checksum validation is more mechanical in its<br>                    nature in Data Corruption Management, only aiming at verification of the copy<br>                    process. In contrast to CPP-002, it does not have to negotiate with producers or<br>                    examine the results. |
| Affinity with           | CPP-011     | Corrupted copies are replaced by intact copies, effectively replicating the<br>                    intact copy, but not creating a new parallel copy.                  |
| Not to be confused with | CPP-007     | If a *File* is detected as infected and cannot be cleaned, it might be<br>                    considered "damaged." However, CPP-004 typically applies to technical corruption<br>                    or loss, rather than deliberately human-made damage such as malware-infected *Files* (CPP-007). In practice, infected *File* are more likely to be<br>                    replaced (by the producer) or rejected. |
| Alternative to          | CPP-027     | File Repair is an alternative (fallback) to Data Corruption Management in<br>                    cases where no intact copy of corrupted or broken data is available, since<br>                    repairing the structure of an altered copy is the only option. |

## Framework Mappings

| Framework     | Term                                                                                              | Section                                                                                              |
| :------------ | :------------------------------------------------------------------------------------------------ | :--------------------------------------------------------------------------------------------------- |
| CoreTrustSeal | “For each storage location, measures should be in place to ensure that<br>                    unintentional or unauthorised changes can be detected and correct versions of<br>                    data and metadata recovered” | R14 Storage and Integrity                                                                            |
| Nestor Seal   | “restoration of the archival information packages”<br>                “recovering archival information packages in the event of damage” | C15 Integrity: Functions of the archival storage                                                     |
| ISO 16363     | “Recovery actions”                                                                                | 5.1.1.3.1 The repository shall record and report to its administration all<br>                    incidents of data corruption or loss, and steps shall be taken to repair/replace<br>                    corrupt or lost data. |
| OAIS          | Disaster Recovery                                                                                 | 4.2.3.4                                                                                              |
| PREMIS        |                                                                                                   | /                                                                                                    |

## Reference Implementations

### Use Cases

| Title                            | Institution                      | Documentation                                              | Problem                                                    | Solution                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| :------------------------------- | :------------------------------- | :--------------------------------------------------------- | :--------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Summary between 2021-2024 at CSC | CSC – IT Center for Science Ltd. | https://digitalpreservation.fi/en/services/quality_reports | 2024a: Contents of one tape were lost<br>                    2024b: One corrupt AIP copy on a tape<br>                    2022a: One corrupt AIP copy on a disk<br>                    2022b: One corrupt AIP copy on a disk<br>                    2021: Ten corrupt AIP copies on a tape | <pre><code>2024a: The tape was restored from other copies
                    2024b: A new copy was produced
                    2022a: A new copy was produced from the tape
                    2022b: The corrupted copy of the package had been unsuccessfully copied to
                        storage during ingest earlier but had been later successfully copied to disk
                        storage automatically.
                    2021: New copies were produced</code></pre> |

### Public Documentation

| Institution                                                                        | Organization type                                                                                                        | Language | Link                                                                                                                               |
| :--------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------- | :------- | :--------------------------------------------------------------------------------------------------------------------------------- |
| TIB – Leibniz Information Centre for Science and Technology and University Library | National library, Non-commercial digital preservation service, Research infrastructure, Research performing organisation | en       | https://wiki.tib.eu/confluence/spaces/lza/pages/93608373/Archival+Storage#ArchivalStorage-Recovery                                 |
| CSC – IT Center for Science Ltd.                                                   | Non-commercial digital preservation service                                                                              | en       | https://digitalpreservation.fi/en/services/quality_reports/2024 (section Quality Deviations Relating to Preserved Content in 2024) |
| Archivematica                                                                      | Digital preservation system                                                                                              | en       | https://www.archivematica.org/en/docs/storage-service-0.23/recovery/#recovery                                                      |



---

