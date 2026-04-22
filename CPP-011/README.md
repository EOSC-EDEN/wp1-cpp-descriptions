# Replication

**Short Definition:** The TDA automatically manages the replication of Information Packages to multiple storage locations (potentially in different geographical locations).

## Description and Scope
Replication is the process of copying data to a new storage medium in order to create new identical copies of *AIP(s)*. All new copies created must have their fixity verified to ensure that the process was completed successfully. The process creates new parallel copies to achieve redundancy in the storage system. The process of replication makes no changes to the AIPs themselves but only operates on the storage layer to add storage locations for the new copies.

Redundancy is required to mitigate risks such as data corruption and unintentional or unwarranted data destruction by creating a fault tolerance. The number of parallel copies and the choice of media types is determined by how a TDA implements **Risk Mitigation** (CPP-012). Typically, strategies for the following aspects of redundancy and replication should be covered in the TDA policy: * *Creation of fault tolerance*: The creation of at least three parallel copies is recommended. In this way, the data is always stored on two other valid copies in cases where one copy is corrupted or destroyed; * *Use of diverse storage media*: Employing different storage media helps to avoid systematic errors and vulnerabilities and reduces the risk of vendor lock-in in a single storage solution; * *Geographical distribution of copies*: Storing the copies geographically dispersed reduces location based risks such as environmental disasters or political instability; * *Offline storage of copies*: Storing some copies offline reduces the risk of unwarranted tampering of the data by malicious users or software.

## Authors
- Johan Kylander

## Contributors
- Bertrand Caron
- Juha Lehtonen

## Evaluators
- Felix Burger
- Maria Benauer

## Process Definition

### Inputs

| Type     | Input                              |
| :------- | :--------------------------------- |
| Data     | AIP                                |
| Metadata | Storage management information     |
| Guidance | Storage management policy - Copies |

### Outputs

| Type     | Output                         |
| :------- | :----------------------------- |
| Metadata | Storage management information |

### Trigger Events

| Description                                                                                | Corresponding CPP |
| :----------------------------------------------------------------------------------------- | :---------------- |
| Ingest. New ingested data that needs to be replicated when accepted<br>                        to preservation. | `CPP-029`         |
| Updates to a TDAs decisions on copy management as per its Risk<br>                        Mitigation policies. The TDA defines how many copies are needed at<br>                        all times and on what type of media. Changes to these policies can<br>                        occur during preservation | `CPP-012`         |

## Process Steps

| Step | Supplier(s) | Input(s)                            | Description                                                   | Output(s)                                      | Customer(s) |
| :--- | :---------- | :---------------------------------- | :------------------------------------------------------------ | :--------------------------------------------- | :---------- |
| 1    | `CPP-012`<br>`CPP-029` | - Copy management policy<br>- Storage management information<br>- *AIP* | Identify and locate *AIP* to be replicated                    | - Inventory of *AIP* to be replicated<br>- Source storage medium with *AIP* |             |
| 2    |             | - *Copy management policy*          | Select target storage medium to copy the *AIP* to             | - Target storage medium                        |             |
| 3    |             | - Source storage medium with *AIP*<br>- Target storage medium<br>- *AIP* | Start the copy process (steps 4 to 8).                        |                                                |             |
| 4    |             |                                     | Retrieve the *AIP* from the source storage medium             |                                                |             |
| 5    |             |                                     | Copy the *AIP* to the new storage medium                      | - New copy of *AIP*                            |             |
| 6    |             | - Existing/previous Fixity metadata | Validate the fixity of the *AIP* on the target storage medium | - Valid status (step 7)<br>                            *Fixity Metadata*><br>- Invalid status (go back to step 4)<br>                            *Fixity Metadata* |             |
| 7    |             |                                     | Update the fixity for the new *AIP* copy                      | - *Fixity Metadata*                            |             |
| 8    |             |                                     | Update the storage location for the new *AIP* copy            | - *Storage management information*             |             |
| 9    |             |                                     | Create preservation *Event metadata* of the replication       | - *Provenance metadata*                        |             |

## Rationale / Worst Case

| Purpose                                                                   | Worst Case                                                                                        |
| :------------------------------------------------------------------------ | :------------------------------------------------------------------------------------------------ |
| Have multiple copies of data                                              | Handling data corruption or destruction requires intact copies to restore lost<br>                    data from. |
| Copies in different storage locations with different location based risks | If data is not stored in different locations, any disaster to the location is a<br>                    single point of failure. The same applies to the type of risk associated with<br>                    the<br>                    locations (e.g. political risk, risk of natural disasters etc.). |
| Copies should exist on different type of storage media                    | Systematic errors in a storage media can affect all copies on the same type of<br>                    media. |
| Offline copies that are not accessible by normal procedures               | Offline copies are safe from malicious users or software, as they cannot be<br>                    accessed by normal means. |
| Open source storage solutions                                             | Vendor lock-in in storage solutions can pose a risk to the copies on those media<br>                    if they have a dependency to an outside partner. |

## Relationships

| Type                    | Related CPP | Description                                                                                                                   |
| :---------------------- | :---------- | :---------------------------------------------------------------------------------------------------------------------------- |
| Requires                | CPP-012     | A TDAs storage policy, that defines how data is stored, the amount of parallel<br>                    copies etc, is based on a TDAs risk assessment and mitigation. |
| Requires                | CPP-005     | Soft dependency (i.e. may require): When a *Digital Object* or *File* is replicated, the replicant may be assigned a new PID. |
| Not to be confused with | CPP-030     | Replication creates new parallel copies of *AIPs*, while Refreshment<br>                    replaces *AIPs* onto new storage media. |
| Affinity with           | CPP-002     | All new *AIP* copies must have their checksum validated to verify that<br>                    the process was successful. The checksum validation is more mechanical in its<br>                    nature in Replication, only aiming at verification of the copy process. In<br>                    contrast to CPP-002, it does not have to negotiate with producers or examine the<br>                    results. |
| Affinity with           | CPP-004     | A replication-like process is performed in data corruption management, in<br>                    which *AIPs* must be replicated to replace corrupted *AIPs*. |
| Affinity with           | CPP-006     | Replication creates new parallel copies of *AIPs* within a TDAs<br>                    archival storage. AIP Batch Export exports *AIPs* to external locations. |

## Framework Mappings

| Framework     | Term                                                                                               | Section                                          |
| :------------ | :------------------------------------------------------------------------------------------------- | :----------------------------------------------- |
| CoreTrustSeal | Multiple copies                                                                                    | R14 Storage and Integrity                        |
| Nestor Seal   | Selection of suitable storage media, redundancy, refreshing, media migration                       | C15 Integrity: Functions of the archival storage |
| ISO 16363     | Not explicitly mentioning the process of making copies, but section 5.1.2 comes<br>                    close, where it mentions managing copies: Repositories may require a different<br>                    number of copies for each class, or manage versions needed to meet access<br>                    requirements | 5.1.2                                            |
| OAIS          | Replace Media<br>                Replication<br>                Refreshment                        | 4.2.3.4<br><br>5.2.4.3<br><br>5.2.4.2            |
| PREMIS        | Replication<br>                Media Migration<br>                Media Refreshment                | Glossary                                         |

## Reference Implementations

### Public Documentation

| Institution                                                                        | Link                                                                                                   | Comment       |
| :--------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------- | :------------ |
| TIB – Leibniz Information Centre for Science and Technology and University Library | https://wiki.tib.eu/confluence/spaces/lza/pages/93608373/Archival+Storage#ArchivalStorage-Redundancy   |               |
| CSC – IT Center for Science Ltd.                                                   | https://urn.fi/urn:nbn:fi-fe2023062157386                                                              | section 3.2.4 |
| Archivematica                                                                      | https://archivematica.org/en/docs/archivematica-1.17/admin-manual/maintenance/maintenance/#data-backup |               |



---

