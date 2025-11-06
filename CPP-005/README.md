# Identifier Management

**Short Definition:** Identifiers are assigned to Objects, Information packages and/or Metadata, and managed along to their life cycle.

## Description and Scope
Identifier management is the process of creating and updating identifiers and assigning them to Objects, Metadata or Information packages. Identifiers are essential components of digital preservation systems, serving as stable, long-term references to Digital Objects that can remain valid even when the Objects themselves are moved, renamed, or migrated to new systems.

Identifiers must be managed throughout the entire life cycle, taking into account any changes to their associated Objects, Metadata or Information packages. It is important to consider that not all types of identifiers are globally unique, some are unique only within their own identifier system.

A Persistent Identifier (PID) system can be used to generate unequivocal (this term is preferred over the “unique” adjective applied traditionally to identifiers. Indeed, it suggests that an identifier must reference one and only one thing, while “unique” might suggest that the thing must be referenced by only one identifier) identifiers to ensure that Objects can be precisely identified worldwide. PIDs are machine-readable strings of characters that conform to a defined scheme. Through providing and updating the reference link in the Metadata, these identifiers prevent the fundamental problem of "link rot" and ensure reliable access to preserved Digital Objects over time. However, this requires continuous maintenance of the identifiers to keep the Metadata up-to-date. Depending on the use case, it may be useful to assign multiple identifiers from different systems to an entity. To be able to provide user-facing PIDs, a TDA must manage local identifiers which provide the minimal baseline for providing persistent access and control to the data.

Common examples of PIDs are Digital Object Identifier (DOI), Uniform Resource Name (URN), handles and Archival Resource Key (ARK). One advantage of using PIDs is that their Metadata can be used to not only provide information about the Object itself, but also about its status, access conditions, and storage location. Even Objects which are not publicly accessible or have been disposed, can be identified and described by a PID. PIDs can also be moved from one organisation’s administration to another.

All types of identifiers can be assigned to multiple levels of entities, creating a hierarchical identification structure that reflects the complex nature of digital collections and their preservation requirements. Identifiers are usually assigned on the level of a) Objects, b) collections and aggregations, and c) Information Packages (AIPs and DIPs). In addition, identifiers can be assigned to Metadata entities, collections of other related entities, and even institutions or persons.

Identifiers and their Metadata should be updated according to the entity’s life cycle. In particular, when an entity may be deleted, merged, split or become partially unavailable, its identifier should be preserved. Moreover, its Provenance metadata should be updated in order to provide proper detail of information to the end users about its initial entity as well as the relationships to potential new entities that were created from the initial one. When using PIDs, some changes (e.g. the creation of identical parallel copies of the data that create new internal identifiers for each copy) can be documented in the PID version Metadata without creating a new PID.

Identifiers in a TDA are created at specific strategic points throughout the preservation life cycle, with timing and methods varying based on institutional policies and system architectures. Identifiers are typically assigned during Ingest as part of the packaging process, ensuring that every preserved Object has a persistent reference from the moment it enters the system. However, some institutions create identifiers earlier in the workflow (e.g. during acquisition planning or transfer preparation). This is especially useful when using PIDs, since it allows for early referencing and tracking of Objects before they undergo preservation processing. Identifiers can also be created after the initial preservation processing is complete, particularly when the final preserved format and structure have been determined. Identifiers can be also assigned to services or Objects which are not stored in the TDA but only generated on the fly based on user requests.

Identifiers may reveal the hierarchical relationships in the identifier string (e.g. by using qualifiers) or might hide them by creating a whole new string for components. This CPP does not choose between these approaches. Similarly, it does not make any assumptions on the organisation in charge of managing identifiers and whether identifiers are managed by the TDA directly. Since PID management is relatively resource-intensive and can also be performed outside the scope of digital long-term preservation, no assumptions are made here about the structure or organisation of this work area; instead, reference is made only to the entity “the PID management service”.

## Authors
- Mikko Laukkanen
- Juha Lehtonen

## Contributors
- Bertrand Caron
- Johan Kylander

## Evaluators
- Felix Burger
- Maria Benauer

## Process Definition

**Inputs:**
- Information package
- Object
- Identifier creation and management policy

**Outputs:**
- Identifier-enriched Information package, Object(s) or Metadata
- Provenance metadata

**Trigger Events:**
- Pre-ingest transfer preparation (see `CPP-029`)
- Ingestion workflow (see `CPP-029`)
- Creation of new Files or Representations (see `CPP-028`)
- Replacement of corrupted Files (see `CPP-004`)
- Data export (see `CPP-006`)
- Data replication (see `CPP-011`)
- Data migration (see `CPP-014`)
- Data normalisation (see `CPP-026`)
- Metadata ingest and creation (see `CPP-016`)
- Data version update (see `CPP-021`)
- Broken File needs a new identifier (see `CPP-027`)
- Information package, File or Metadata is removed from the TDA holdings (see `CPP-017`)

## Process Steps

| Step | Description                                                                                                             | Inputs                                                                                                   | Outputs                                           |
| :--- | :---------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------- | :------------------------------------------------ |
| 1a   | Reservation of identifier prior to new entity assignment (step 2)                                                       | - A producer or a TDA has a need to reserve an identifier, (e.g. a PID, prior to the entity being added) |                                                   |
| 1b   | New entity added or a need to assign an identifier to an existing entity (step 2)                                       | - *Object*<br>- *Information package*<br>- *Metadata*                                                    |                                                   |
| 1c   | Entity with an identifier has changed (step 4)                                                                          | - *Object*<br>- *Information package*<br>- *Metadata*                                                    |                                                   |
| 1d   | Entity is disposed (step 7)                                                                                             | - *Object*<br>- *Information package*<br>- *Metadata*                                                    |                                                   |
| 2    | Create a new identifier according to the TDAs policy for identifier management                                          | - *Identifier creation and management policy*                                                            | - Identifier                                      |
| 3    | Assign the new identifier to the entity and add it as a part of the entity’s Metadata                                   | - *(new) Identifier*<br>- *Object*<br>- *Information package*<br>- *Metadata*                            | - Metadata                                        |
| 4    | If the changed entity has a PID assigned to it: evaluate if a new PID is required                                       | - *Identifier creation and management policy*                                                            | - Need for new PID identified (go back to step 2)<br>- No need for new PID identified (step 5) |
| 5    | Update or add identifier relationships (e.g. hierarchical relations, sequential relations etc.) for the assigned entity |                                                                                                          | - Metadata                                        |
| 6    | Update Provenance metadata for the entity so that identifiers have a history                                            |                                                                                                          | - Provenance metadata                             |
| 7    | If the entity is disposed: retain minimum metadata and the identifier for the disposed entity                           | - *Disposed entity*                                                                                      |                                                   |

## Rationale / Worst Case

| Purpose                                                                                                                                                                       | Worst Case                                                                                                                                                    |
| :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| The rationale for implementing PIDs in TDAs stems from fundamental challenges in maintaining long-term access to digital objects and the core mission of preservation itself. | Link rot as well as problems and challenges in: Internal data management problemsm, System migrations, Format migrations, Activity tracking, Interoperability |

## Relationships

| Type               | Related CPP | Description                                                                                                                                                                  |
| :----------------- | :---------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Required by        | CPP-016     | While ingesting into a TDA, the Metadata should be assigned an identifier. Also, the management functions of the Metadata may require replacing and/or updating identifiers. |
| Required by        | CPP-017     | When the life cycle of the Digital Object or File ends, the identifier should be updated to “retired” status.                                                                |
| Required by        | CPP-021     | When an AIP gets a new version, the new AIP version must also be assigned a new identifier.                                                                                  |
| Required by        | CPP-024     | Enabling Discovery should make use of identifiers.                                                                                                                           |
| Required by        | CPP-025     | Accessing Digital Object, File(s) or Metadata should be based on identifiers as parameters.                                                                                  |
| Required by        | CPP-029     | The ingestion workflow is responsible for assigning identifiers to various entities in TDA, such as Files and Metadata.                                                      |
| May be required by | CPP-004     | If a File is corrupted, it may need to be repaired or replaced. During this process, a new identifier may be created.                                                        |
| May be required by | CPP-011     | When a Digital Object or File is replicated, the replicant may be assigned a new identifier.                                                                                 |
| May be required by | CPP-013     | The management and reporting should require that the data is identified with identifiers.                                                                                    |
| May be required by | CPP-014     | During format migration, the migrated File format may be assigned a new identifier.                                                                                          |
| May be required by | CPP-019     | The data quality assessment may include validating the identifiers and their linked resources.                                                                               |
| May be required by | CPP-026     | A normalised File format may be assigned with a new identifier.                                                                                                              |
| May be required by | CPP-027     | A repaired File may get a new identifier.                                                                                                                                    |
| May be required by | CPP-028     | A derivative of a File may get its own identifier.                                                                                                                           |

## Framework Mappings

- **CoreTrustSeal**
  - **Term:** Persistent Identifiers
  - **Section:** R09 Preservation Plan
    
    R12 Discovery and Identification
- **Nestor Seal**
  - **Term:** Persistent Identifiers
  - **Section:** C27 Identification
- **ISO 16363**
  - **Term:** Persistent Identifiers
  - **Section:** 4.2.4
    
    4.2.5.4
    
    4.2.6.3
- **OAIS**
  - **Term:** Persistent Identifiers
  - **Section:** 6.2.4
- **PREMIS**
  - **Term:** Persistent Identifiers
  - **Section:** Data dictionary, 1.1 objectIdentifier

## Reference Implementations

### Use Cases
- **DOI given for a research dataset by TDA**
  - **Institution:** CSC, Finland (Digital Preservation Service for Research Data)
  - **Documentation:** https://wiki.eduuni.fi/x/9ZRYH
  - **Problem:** Research dataset does not have a DOI
  - **Solution:**
```python
Before submitting a dataset to TDA (DPS in Finland), the user describes the dataset via a description tool or via a metadata API. When a dataset has been submitted, TDA automatically creates a DataCite description including a new DOI, and eventually it creates a corresponding publicly available website for the dataset Metadata.
```

### Public Documentation
- **TIB – Leibniz Information Centre for Science and Technology and University Library**
  - **Link:** https://wiki.tib.eu/confluence/spaces/lza/pages/93608951/Metadata#Metadata-Identifyingmetadata
- **CSC – IT Center for Science Ltd.**
  - **Link:** https://urn.fi/urn:nbn:fi-fe2020100578094
  - **Comment:** section 2.4.1.
- **Archivematica**
  - **Link:** https://www.archivematica.org/en/docs/archivematica-1.17/user-manual/transfer/transfer/#transfer-tab-microservices



---

