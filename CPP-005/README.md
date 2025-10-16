# Identifier Management

**Short Definition:** Identifiers are assigned to Objects, Information packages and/or Metadata, and managed along to their life cycle.

## Description and Scope
Identifier management is the process of creating and updating identifiers and assigning them to Objects, Metadata or Information packages. Identifiers are essential components of digital preservation systems, serving as stable, long-term references to Digital Objects that can remain valid even when the Objects themselves are moved, renamed, or migrated to new systems. Identifiers must be managed throughout the entire life cycle, taking into account any changes to their associated Objects, Metadata or Information packages. It is important to consider that not all types of identifiers are globally unique, some are unique only within their own identifier system. A Persistent Identifier (PID) system can be used to generate unequivocal (this term is preferred over the “unique” adjective applied traditionally to identifiers. Indeed, it suggests that an identifier must reference one and only one thing, while “unique” might suggest that the thing must be referenced by only one identifier) identifiers to ensure that Objects can be precisely identified worldwide. PIDs are machine-readable strings of characters that conform to a defined scheme. Through providing and updating the reference link in the Metadata, these identifiers prevent the fundamental problem of "link rot" and ensure reliable access to preserved Digital Objects over time. However, this requires continuous maintenance of the identifiers to keep the Metadata up-to-date. Depending on the use case, it may be useful to assign multiple identifiers from different systems to an entity. To be able to provide user-facing PIDs, a TDA must manage local identifiers which provide the minimal baseline for providing persistent access and control to the data. Common examples of PIDs are Digital Object Identifier (DOI), Uniform Resource Name (URN), handles and Archival Resource Key (ARK). One advantage of using PIDs is that their Metadata can be used to not only provide information about the Object itself, but also about its status, access conditions, and storage location. Even Objects which are not publicly accessible or have been disposed, can be identified and described by a PID. PIDs can also be moved from one organisation’s administration to another. All types of identifiers can be assigned to multiple levels of entities, creating a hierarchical identification structure that reflects the complex nature of digital collections and their preservation requirements. Identifiers are usually assigned on the level of a) Objects, b) collections and aggregations, and c) Information Packages (AIPs and DIPs). In addition, identifiers can be assigned to Metadata entities, collections of other related entities, and even institutions or persons. Identifiers and their Metadata should be updated according to the entity’s life cycle. In particular, when an entity may be deleted, merged, split or become partially unavailable, its identifier should be preserved. Moreover, its Provenance metadata should be updated in order to provide proper detail of information to the end users about its initial entity as well as the relationships to potential new entities that were created from the initial one. When using PIDs, some changes (e.g. the creation of identical parallel copies of the data that create new internal identifiers for each copy) can be documented in the PID version Metadata without creating a new PID. Identifiers in a TDA are created at specific strategic points throughout the preservation life cycle, with timing and methods varying based on institutional policies and system architectures. Identifiers are typically assigned during Ingest as part of the packaging process, ensuring that every preserved Object has a persistent reference from the moment it enters the system. However, some institutions create identifiers earlier in the workflow (e.g. during acquisition planning or transfer preparation). This is especially useful when using PIDs, since it allows for early referencing and tracking of Objects before they undergo preservation processing. Identifiers can also be created after the initial preservation processing is complete, particularly when the final preserved format and structure have been determined. Identifiers can be also assigned to services or Objects which are not stored in the TDA but only generated on the fly based on user requests. Identifiers may reveal the hierarchical relationships in the identifier string (e.g. by using qualifiers) or might hide them by creating a whole new string for components. This CPP does not choose between these approaches. Similarly, it does not make any assumptions on the organisation in charge of managing identifiers and whether identifiers are managed by the TDA directly. Since PID management is relatively resource-intensive and can also be performed outside the scope of digital long-term preservation, no assumptions are made here about the structure or organisation of this work area; instead, reference is made only to the entity “the PID management service”.

## Authors
- Mikko Laukkanen
- Juha Lehtonen

## Contributors
- Bertrand Caron
- Johan Kylander

## Evaluators
- Felix Burger
- Maria Benauer

## Process Steps

### Step 1a
Reservation of identifier prior to new entity assignment (step 2)

**Inputs:**
- A producer or a TDA has a need to reserve an identifier, (e.g. a PID, prior to the entity being added)

**Outputs:**
- 

### Step 1b
New entity added or a need to assign an identifier to an existing entity (step 2)

**Inputs:**
- Object
- Information package
- Metadata

**Outputs:**
- 

### Step 1c
Entity with an identifier has changed (step 4)

**Inputs:**
- Object
- Information package
- Metadata

**Outputs:**
- 

### Step 1d
Entity is disposed (step 7)

**Inputs:**
- Object
- Information package
- Metadata

**Outputs:**
- 

### Step 2
Create a new identifier according to the TDAs policy for identifier management

**Inputs:**
- Identifier creation and management policy

**Outputs:**
- Identifier

### Step 3
Assign the new identifier to the entity and add it as a part of the entity’s Metadata

**Inputs:**
- (new) Identifier
- Object
- Information package
- Metadata

**Outputs:**
- Metadata

### Step 4
If the changed entity has a PID assigned to it: evaluate if a new PID is required

**Inputs:**
- Identifier creation and management policy

**Outputs:**
- Need for new PID identified (go back to step 2)
- No need for new PID identified (step 5)

### Step 5
Update or add identifier relationships (e.g. hierarchical relations, sequential relations etc.) for the assigned entity

**Inputs:**
- 

**Outputs:**
- Metadata

### Step 6
Update Provenance metadata for the entity so that identifiers have a history

**Inputs:**
- 

**Outputs:**
- Provenance metadata

### Step 7
If the entity is disposed: retain minimum metadata and the identifier for the disposed entity

**Inputs:**
- Disposed entity

**Outputs:**
- 

