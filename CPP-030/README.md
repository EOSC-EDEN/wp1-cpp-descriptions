# Refreshment

**Short Definition:** The TDA replaces the Information Packages on a storage medium, copying them to a new medium and discarding the old one at the end of a storage medium's life cycle.

## Description and Scope
Refreshment is the process of anticipating the end of life of a storage medium and copying data to a new storage medium in order to safeguard *AIP*s on viable storage media at all times. It is a vital part of storage life-cycle management, and minimises the risk of data corruption.

A TDA may also decide to refresh a storage medium for various reasons such as: * Mitigate corruption: Large, media-wide errors or corruption are detected (e.g. a magnetic tape has become unreadable) by CPP-004 (**Data Corruption Management**). * Mitigate costs and risks: A storage medium (e.g. a server) reaches the end of its life and is no longer being supported by the vendor, potentially resulting in increased support costs or risks of unpatched security vulnerabilities. * Reduce costs and/or improve efficiency: For example, refreshing storage to take advantage of new generations of data tape and increase read/write speed, or to reduce physical footprint, power consumption etc.

The process of refreshment makes no changes to the *AIP*s themselves but only operates on the storage layer. A TDA may decide to physically replace the medium with an identical medium (e.g. replace an old magnetic tape by a new similar one), or choose a new medium (e.g. replace magnetic tapes with a new generation of tapes or a completely different type of storage medium). During refreshment, all *AIP*s on an old storage medium are copied onto a new storage medium and their fixity is verified. It is important to note that the medium undergoing refreshment is not always the source for replicating the data (e.g. copies on offline storage media or corrupted storage media are typically refreshed from an available storage medium). The old storage medium (including all data on it) then is removed from use and is either destroyed, recycled or repurposed (depending on its type).

A TDA may use a wide range of storage mediums to achieve data replication and storage diversity. Examples of a storage medium include discrete physical media (e.g. data tapes or archival storage discs), storage servers (e.g. online storage provided as NAS, SAN, DAS etc.) or any combination of these (e.g. tiered storage that combines files servers and tape libraries). This is not an exhaustive list. Each copy of a TDA’s data can be on a storage medium that consists of software, hardware and media.

The choice of storage types and their longevity is determined by **Risk Mitigation** (CPP-012). The TDA must have a strategy and a plan in place for: * Managing its storage hardware, software and media * Defining intervals of regular replacement for different storage * Procedures for the refreshment of the storage medium before it reaches the end of its life cycle

## Authors
- Johan Kylander

## Contributors
- Matthew Addis

## Evaluators
- Felix Burger
- Maria Benauer

## Process Definition

### Inputs

| Type     | Input                             |
| :------- | :-------------------------------- |
| Data     | AIP                               |
| Metadata | Storage management information    |
| Guidance | Storage management policy - Media |

### Outputs

| Type     | Output                         |
| :------- | :----------------------------- |
| Metadata | Storage management information |
| Metadata | Record of decommissioning      |

### Trigger Events

| Description                                                                                     | Corresponding CPP |
| :---------------------------------------------------------------------------------------------- | :---------------- |
| A storage medium is near the end of its life cycle and must be replaced by a new storage medium |                   |
| Detection of corruption or errors in a storage medium                                           | `CPP-004`         |
| Potentials for reducing costs or improving efficiency by benefiting from storage medium <br>                        technologies are identified |                   |

## Process Steps

| Step | Supplier(s) | Input(s)                                                                               | Description                                                                                                         | Output(s)                                                         | Customer(s) |
| :--- | :---------- | :------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------ | :---------------------------------------------------------------- | :---------- |
| 1    | `CPP-004`<br>`CPP-012` | - Storage management policy - Media, flagging a storage medium that must be refreshed<br>- Detection of a faulty storage medium<br>- Refreshment is identified as a way to reduce costs, increase efficiency, or improve <br>                            environmental sustainability | Identify and locate the storage medium to be refreshed                                                              | - The old storage medium that is to be refreshed                  |             |
| 2    |             | - *Storage management information*                                                     | List all *AIP*s on the old storage medium                                                                           | - Inventory of *AIP*s involved in the refreshment                 |             |
| 3    |             | - Storage management policy - Media                                                    | Select source medium to copy the *AIP*s from (can be from storage other than the medium to <br>                        be replaced) | - Authoritative storage medium for replicating/copying the *AIP*s |             |
| 4    |             |                                                                                        | Provision of a fresh storage medium that will replace the old one                                                   | - The fresh storage medium that will replace the old one          |             |
| 5    |             | - Source storage medium of *AIP*s<br>- Fresh storage medium<br>- Inventory of *AIP*s involved in the refreshment | For each *AIP* individually, start the copy process (steps 6 to 10):                                                |                                                                   |             |
| 6    |             |                                                                                        | Retrieve the *AIP* from the source storage medium                                                                   |                                                                   |             |
| 7    |             |                                                                                        | Copy the *AIP* to the fresh storage medium                                                                          | - New copy of *AIP*                                               |             |
| 8    |             | - Existing/previous *Fixity metadata*                                                  | Validate the fixity of the *AIP* on the fresh storage medium                                                        | - Valid status (9) - *Fixity metadata*<br>- Invalid status (go back to 6) - *Fixity metadata* |             |
| 9    |             |                                                                                        | Record the fixity for the new *AIP* copy                                                                            | - *Fixity metadata*                                               |             |
| 10   |             |                                                                                        | Update the storage location for the new *AIP* copy                                                                  | - *Storage management information*                                |             |
| 11   |             | - Inventory of *AIP*s involved in the refreshment                                      | Check that all *AIP*s in the inventory have been successfully copied                                                | - Confirm completeness of the copy process (12)<br>- Error (go back to copy process loop) |             |
| 12   |             |                                                                                        | Update information about the fresh storage medium (e.g. *File* locations, media <br>                        identifiers) and mark the old medium and its contents as ready for deletion/decommissioning | - *Storage management information*                                |             |
| 13   |             |                                                                                        | Create a preservation event for the refreshment                                                                     | - *Provenance metadata*                                           |             |
| 14   |             | - Old storage medium that has been refreshed                                           | Ensure data security and that confidentiality is not compromised by making sure that data on the <br>                        old storage medium is properly deleted |                                                                   |             |
| 15   |             |                                                                                        | Decommission the old storage medium                                                                                 | - Record of decommissioning                                       |             |

## Rationale / Worst Case

| Purpose                                                       | Worst Case                                                                                                         |
| :------------------------------------------------------------ | :----------------------------------------------------------------------------------------------------------------- |
| Manage the storage infrastructure life cycle                  | Storage medium deteriorates/ degrades/ becomes faulty over time, which increases the risk of data <br>                    corruption.<br>                Storage medium is no longer supported by the vendor, which increases risks to data due to lack of <br>                    maintenance or unpatched security vulnerabilities. |
| Have multiple copies of data on multiple viable storage media | In cases of data corruption or destruction, recovery depends on having other intact copies                         |
| The TDA should achieve sustainability                         | Using old or obsolete storage media results in higher costs, lower operational efficiency, or higher <br>                    environmental impact (compared to latest storage medium technologies). |
| Open source storage solutions                                 | Vendor lock-in in storage solutions pose a risk of a strong dependency to an external partner.                     |

## Relationships

| Type                    | Related CPP | Description                                                                                                                    |
| :---------------------- | :---------- | :----------------------------------------------------------------------------------------------------------------------------- |
| Requires                | CPP-012     | The strategy for data storage and storage infrastructure management is defined in a storage management <br>                    policy which is based on a TDAs risk assessment and mitigation. |
| Not to be confused with | CPP-011     | Replication creates new parallel copies of individual *AIP*s, refreshment creates new copies <br>                    that replace the old ones. Moreover, CPP-011 aims for redundancy on an IP level, whereas Refreshment <br>                    operates on a storage medium level. |
| Affinity with           | CPP-002     | All new *AIP* copies must have their checksum validated to verify that the process was <br>                    successful. The checksum validation is more mechanical in its nature in Refreshment, only aiming at <br>                    verification of the copy process. In contrast to CPP-002, it does not have to negotiate with producers or <br>                    examine the results. |

## Framework Mappings

| Framework     | Term                                                                  | Section                                                                                              |
| :------------ | :-------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------- |
| CoreTrustSeal | procedures for handling and monitoring deterioration of storage media | R14 Storage & Integrity                                                                              |
| Nestor Seal   | selection of suitable storage media<br>                redundancy<br>                refreshing<br>                media migration | C15 Integrity: Functions of the archival storage                                                     |
| ISO 16363     | refreshing<br>                migration                               | 5.1.1.5 The repository shall have defined processes for storage media and/or hardware change (e.g., <br>                    refreshing, migration) |
| OAIS          | Replace Media<br>                Refreshment                          | 4.2.3.4<br><br>5.2.4.2                                                                               |
| PREMIS        | Replication,<br>                Media Migration<br>                Media Refreshment | Glossary                                                                                             |

## Reference Implementations

### Public Documentation

| Institution                                                                        | Link                                                                                                     | Comment       |
| :--------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------- | :------------ |
| TIB – Leibniz Information Centre for Science and Technology and University Library | https://wiki.tib.eu/confluence/spaces/lza/pages/93608373/Archival+Storage#ArchivalStorage-Mediamigration |               |
| CSC – IT Center for Science Ltd.                                                   | https://urn.fi/urn:nbn:fi-fe2023062157386                                                                | Section 3.2.4 |



---

