# AIP Batch Export

**Short Definition:** As part of an exit strategy, the TDA batch exports Information packages and all associated Metadata in a manageable format/structure for Ingest into another TDA.

## Description and Scope
While the TDA manages *Information packages* across their life cycle, stores them as *AIPs*, and delivers them as *DIPs* to its consumer, it also needs to plan for situations in which an export of *AIPs* becomes necessary.

Scenarios that require an AIP Batch Export include, but are not limited to: * *Exit Scenario*: The TDA changes a major part of its system infrastructure, such as the digital preservation workflow software or the database. * *Succession Planning*: The TDA ceases to exist and needs to hand over its archival holdings to a successor. * *Additional External Storage*: The TDA wants to store additional offline copies of their *AIPs*. The *AIP* export will create a *physical* *AIP* as opposed to a logical one. This includes e.g. *Metadata* which might be kept in a database to be written into an XML or JSON *File*. * *Disposal*: If the TDA decides to dispose data (e.g. as part of Re-Appraisal) the data might be handed over to an external entity such as a different TDA that wants to preserve it. The *AIP* likely contains a level of information richness (e.g. in form of versions and full audit trails) that the *DIP* format of the TDA does not offer. * *External Request for Export*: An external entity (e.g. a customer for a digital preservation service) might request the data preserved by the TDA for use cases such as verification of provenance information.

This CPP may export 1-n *AIPs* including all *AIP* versions from the TDA to a storage location external to the archival storage. The target location can be located externally (e.g. an external SFTP server) or internally (e.g. to a different network share). The process makes no assumption as to the type of storage exported to (e.g. disk, tape).

The exported *AIP* should include all available information where possible (i.e. contain all *Files* and all accompanying *Metadata*). In addition to *Descriptive*, *Structural*, *Administrative* and *Technical Metadata*, this includes any *Provenance metadata* which might exist and describes any events undertaken on the *Object* during its lifespan within the TDA.

The format and structure of the exported *AIP* should be documented including an explanation of all internal identifiers or schemas that might be used within. This documentation needs to be provided as a sidecar *File* with the AIP Batch Export.

## Authors
- Micky Lindlar

## Contributors
- Bertrand Caron
- Juha Lehtonen
- Mikko Laukkanen

## Evaluators
- Matthew Addis
- Maria Benauer

## Process Definition

### Inputs

| Type     | Input                                                                                      |
| :------- | :----------------------------------------------------------------------------------------- |
| Data     | AIP(s)                                                                                     |
| Data     | File(s)                                                                                    |
| Metadata | Storage Metadata Information (Identifier of AIP to be exported, including to AIP versions) |
| Metadata | Target location for export                                                                 |
| Guidance | Contractual Documentation for batch export (for service providers, if applicable)          |
| Guidance | AIP specification                                                                          |
| Guidance | Exit Scenario Plan                                                                         |
| Guidance | Documentation of Export AIP (supported target structure and format)                        |

### Outputs

| Type     | Output                          |
| :------- | :------------------------------ |
| Metadata | Only Metadata contained in AIPs |

### Trigger Events

| Description                                                                                        | Corresponding CPP |
| :------------------------------------------------------------------------------------------------- | :---------------- |
| *AIP* is requested from external entity (e.g. customer for digital preservation service)           |                   |
| Succession plans are applied to transfer custody of *Objects* to another TDA                       |                   |
| The TDA extends bit-level preservation capabilities and creates new (internal or outsourced)<br>				copies of *AIPs* (e.g. to implement geographically distributed storage or to copy<br>				*AIPs* to an offline storage system) |                   |
| The TDA changes its system and all *Information packages* need to be exported (i.e. Exit scenario) |                   |
| The TDA has flagged data for disposal and the *AIPs* are to be handed over to an external entity   |                   |

## Process Steps

| Step | Supplier(s) | Input(s)                                                                                  | Description                                                                                    | Output(s)                                                                                | Customer(s) |
| :--- | :---------- | :---------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------- | :---------- |
| 1    |             |                                                                                           | aReceive list of *AIPs* to be exported                                                         |                                                                                          |             |
| 2    |             | - Target structure and format of exported *AIP*                                           | Optional (if multiple target structures and formats are supported):<br>Set export to transform<br>				exported *AIP* to desired structure and format |                                                                                          |             |
| 3    |             | - List of *AIPs* to be exported                                                           | Select *AIPs* to be exported in TDA (e.g. by creating a set based on AIP identifiers<br>				and *AIP* version identifiers, if applicable) | - Inventory of *AIPs*<br>- Inventory of *AIP* versions<br>- Location of information belonging to *AIPs* and *AIP* versions |             |
| 4    |             | - Inventory of *AIPs*<br>- Inventory of *AIPs* versions                                   | Optional (depending on handling method for updates in TDA) for each *AIP*:<br>            Lock AIP to avoid it being updated during export | - Locked location of source *AIP*                                                        |             |
| 5    |             | - Inventory of AIPs<br>- Inventory of AIPs versions<br>- *Storage Metadata Information*   | For each *AIP* in inventory list:<br>Create logical structure for *AIP*                        |                                                                                          |             |
| 6    |             |                                                                                           | For each *AIP* in inventory list:<br>Write logical structure to target location                | - Logical structure tree of exported *AIPs*                                              |             |
| 7    |             |                                                                                           | For each *AIP* in inventory list:<br>Copy *Files* to target location                           | - Files in logical structure tree of exported *AIPs*                                     |             |
| 8    |             | - Database query for *AIP*                                                                | For each *AIP* in inventory list:<br>            If (additional) *Metadata* is stored in other place tha *AIP* (e.g., database):<br>					collect all other information belonging to *AIP* (*Metadata*) | - All information belonging to *AIP*                                                     |             |
| 9    |             | - Result of Database query for *AIP*<br>- Maping for export of selected *Metadata* from database to flat *Metadata* | For each *AIP* in inventory list:<br>            If (additional) *Metadata* is stored in database, transform *Metadata* into target<br>				format and write to target location, add export as provenance information into Metadata<br>				*File* during transformation | - Metadata *File(s)* in target location<br>- Provenance information in metadata *File(s)* |             |
| 10   |             | - Inventory of *AIPs*<br>- Inventory of *AIP* versions<br>- List of *Files* (excluding *Metadata* files) at target location<br>- *Fixity Metadata* from source *AIP* | For each *AIP* in inventory list: The *AIP* in the target should be verified,<br>				including *Files* and *Metadata* to ensure it is complete and correct<br>´				(e.g. using checksums) | - Number of *Files* matches (step 12)<br>- All checksums match (step 12)<br>- Alert that number of *Files* do not match<br>- Alert that any of the *File*  checksums does not match |             |
| 11   |             | - *AIP* ID                                                                                | Optional (depending on handling method for updates in TDA):<br>            for each *AIP*: Release lock on *AIP* | - Released lock                                                                          |             |
| 12   |             | - *Files* in target location<br>- Target structure and format of exported *AIP*           | If required: perform additional repacking of *Files* at target location to meet<br>				target structure and format of exported *AIP* (e.g., tarball) |                                                                                          |             |
| 13   |             | - List of *AIPs*                                                                          | Repeat steps 5-12 for each *AIP* to be exported                                                |                                                                                          |             |
| 14   |             | - Documentation of Export *AIP* (supported target structure and format of exported *AIP*) | Add documentation to target location                                                           | - Documentation of Export *AIP* (supported target structure and format of exported *AIP* |             |
| 15   |             | - Inventory of *AIPs*                                                                     | Document export in audit trail                                                                 | - Audit trail for export                                                                 |             |

## Rationale / Worst Case

| Purpose                                                                                                | Worst Case                                                                                  |
| :----------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------ |
| When a TDA is closed down, it will have to pass data on to another TDA as part of succession planning.<br>				This might have to happen on short notice. | Data is lost.                                                                               |
| When a TDA acts as a service provider, data will have to be exported in bulk to those who<br>				are subscribing to the service. | Data owner potentially loses control over data.                                             |
| If a TDA is using external services and systems, e.g. for storing and preserving<br>				its *AIPs*, then it may need to exchange or transfer *AIPs* to<br>				or from third-party services and systems. | Data is lost, data can't be efficiently transferred between TDAs and preservation services. |

## Relationships

| Type                    | Related CPP | Description                                                                                |
| :---------------------- | :---------- | :----------------------------------------------------------------------------------------- |
| Requires                | CPP-001     | *Fixity metadata* is used to verify the integrity of data written into the exported *AIP*. |
| Requires                | CPP-002     | To ensure the integrity of the data during transport from the TDA<br>				storage, the exported *Files'* checksums need to be<br>				verified. |
| Not to be confused with | CPP-017     | By default, batch export does not remove the content from the TDA.                         |
| Not to be confused with | CPP-025     | Access is typically granted to the *DIP* which may be different from<br>				the *AIP* (e.g. the *DIP* *may* only present the last version<br>				or one of several *Representations*). The *AIP* contains all<br>				preservation *Metadata* which a *DIP* may not. |
| Affected by             | CPP-021     | Versioning impacts how the export will have to be run and where and how<br>				information about the versions may be found. In addition a policy might<br>				determine if only the last or all versions should be exported. |
| Affinity with           | CPP-011     | Replication creates new parallel copies of *AIPs* within a TDAs<br>				archival storage. AIP Batch Export exports *AIPs* to external<br>				locations. |

## Framework Mappings

| Framework     | Term                                                                                  | Section                                                                              |
| :------------ | :------------------------------------------------------------------------------------ | :----------------------------------------------------------------------------------- |
| CoreTrustSeal | "Technical aspects of business continuity, disaster recovery and succession planning" | R15 Technical Infrastructure<br><br>Organisational aspects are covered in R03 Continuity of Service |
| Nestor Seal   | Export                                                                                | C12 Crisis / successorship management                                                |
| ISO 16363     | Export                                                                                | 4.3.5<br><br>Also touched in 3.1.2.2 "The repository shall monitor its organizational environment<br>				to determine when to execute its succession plan, contingency plans, and/or<br>				escrow arrangements." |
| OAIS          | /                                                                                     | The process is not described in OAIS but one of its purposes,<br>				Succession Planning, is briefly mentioned in 3.3.6 "Follows<br>				establised preservation policies and procedures". |
| PREMIS        | /                                                                                     | /                                                                                    |

## Reference Implementations

### Public Documentation

| Institution                                                                        | Link                                                                                                                        | Comment    |
| :--------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------- | :--------- |
| TIB – Leibniz Information Centre for Science and Technology and University Library | https://wiki.tib.eu/confluence/spaces/lza/pages/93608980/Export+and+exit+scenario                                           |            |
| CSC – IT Center for Science Ltd.                                                   | https://urn.fi/urn:nbn:fi-fe2024051731943                                                                                   | section 13 |
| Archivematica                                                                      | ihttps://www.archivematica.org/en/docs/archivematica-1.17/user-manual/archival-storage/archival-storage/#downloading-an-aip |            |



---

