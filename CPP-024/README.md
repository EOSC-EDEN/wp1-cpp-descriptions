# Enabling Discovery

**Short Definition:** The TDA provides catalogue services to its consumers to help them identify Objects that they may be interested in.

## Description and Scope
Enabling Discovery covers the extraction of the subset of *Metadata* from the digital archive database to enable consumers to identify which *Objects* they may be interested in. In OAIS, this subset is called "Descriptive Information".

Discovery relies on CPP-018 (**Community Watch**) to study consumers’ needs regarding searches and elaborate query scenarios. Query scenarios are use cases where the consumers identify a subset of the TDA holdings’ that addresses their needs. Discovery is in charge of providing *Metadata*, query and retrieval features that support these query scenarios in an efficient way. If the TDA wants its Objects to be discoverable in third-party catalogues (e.g. federated catalogues, portals etc.), it must perform this process for each service in order to ensure that *Metadata* and derivatives conform to the specifications of the third-party catalogue(s).

If the TDA provides direct access to its holdings for end users, then it may also generate a *PID* (e.g. a DOI) for each accessible *Object* so that it is referencable and locatable using third-party discovery services. However, this CPP only focuses on the generation of *Metadata* that is subsequently used for discovery (rather than the discovery process and the use of discovery services such as portals and catalogues). The details of registering PIDs, publishing *Metadata* and/or data with third-party catalogues and discovery services, as well as the access to *Objects* via PID resolution and TDA services are beyond the scope of this CPP.

Enabling Discovery is also in charge of verifying the legal status of *Metadata* based on rights assessment as issued by CPP-020 (**Rights Management**). *Metadata* access might indeed need to be restricted, so Discovery must ensure it disseminates these only to authorised users.

In addition to *Metadata*, discovery might provide derivative copies (e.g. thumbnails, textual transcription, redacted copy, etc.) that would help consumers in identifying the content and scope of the relevant *Objects*. Indeed, access to the preservation copies or to a sufficiently complete derivative is often limited to the TDA’s precinct.

## Authors
- Bertrand Caron

## Contributors
- Mattias Levlin

## Evaluators
- Matthew Addis
- Felix Burger
- Maria Benauer

## Process Definition

### Inputs

| Type     | Input                                                                                         |
| :------- | :-------------------------------------------------------------------------------------------- |
| Data     | Optional: Derivatives useful for the consumer to identify the content and scope of the Object |
| Metadata | Digital Archive Database                                                                      |
| Guidance | Query scenarios                                                                               |
| Guidance | Metadata mapping specifications                                                               |

### Outputs

| Type     | Output                   |
| :------- | :----------------------- |
| Metadata | Catalogue service        |
| Metadata | Process execution report |

### Trigger Events

| Description                                   | Corresponding CPP |
| :-------------------------------------------- | :---------------- |
| New *Object* or new *Object* version ingested | `CPP-029`         |

## Process Steps

| Step | Supplier(s) | Input(s)                                              | Description                                                                                                                                  | Output(s)                                                                              | Customer(s) |
| :--- | :---------- | :---------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------- | :---------- |
| 1    | `CPP-018`   | - Query scenarios                                     | Select the relevant *Metadata* (and possibly data) useful to the consumer                                                                    | - Subset of *Metadata* to be exposed in the catalogue                                  |             |
| 2    | `CPP-018`   | - Query scenarios                                     | Select the syntax or serialisations useful to the consumer                                                                                   | - Syntax of *Metadata* to be exposed in the catalogue                                  |             |
| 3a   |             | - New *AIP* or *AIP* version<br>- Subset of *Metadata* to be exposed in the catalogue<br>- Syntax of *Metadata* to be exposed in the catalogue | Extraction: Extract the required subset of *Metadata* from the new *AIP*<br>              or *AIP* version                                   | - Extracted discovery *Metadata*                                                       |             |
| 3b   |             | - Extracted discovery *Metadata*                      | Mapping & transformation: Map and transform the *Metadata* according to<br>              the required format of the discovery catalogue      | - Transformed discovery *Metadata*                                                     |             |
| 3c   |             | - Transformed discovery *Metadata*                    | Validation: Validate the resulting subset of *Metadata* against the target<br>              catalogue's schema                               | - Validation successful: Validated discovery *Metadata* (step 4)<br>- Validation failed: Log the error and flag the record for review.<br>                The record must not proceed to the discovery catalogue until corrected |             |
| 4    | `CPP-020`   | - Validated discovery *Metadata*<br>- Rights statement | Check rights status of discovery *Metadata*                                                                                                  | - Validated discovery *Metadata* with cleared rights                                   |             |
| 5a   |             | - Validated discovery *Metadata* with cleared rights  | Add discovery *Metadata* for the *Object(s)* to the catalogue<br>              service. The catalogue service may be provided by the TDA, by a third-party (e.g. a<br>              federated catalogue), or by a combination of the two. | - Entry in catalogue service                                                           |             |
| 5b   |             | - Validated discovery *Metadata* with cleared rights  | Optional: If the TDA requires a PID (e.g. DOI), because the *Object* or *Metadata* about the *Object* will be publicly accessible (e.g. open<br>              access), the TDA may request a PID from an appropriate registration agency. The TDA<br>              may also add the PID to the *Metadata* in the catalogue service. | - PID                                                                                  |             |
| 5c   | `CPP-025`   | - *DIP* or Derivatives                                | Optional: The TDA may provide versions of its *Objects* for inclusion in<br>              the catalogue service (for example, thumbnails, preview versions, redacted documents<br>              etc.). These are added to the catalogue entry for the *Object*. | - Entry in catalogue service                                                           |             |
| 6    |             | - Query scenarions<br>- Catalogue service             | Verification: Using the defined query scenarions, perform a test query to confirm<br>              that the new or updated *Object* is discoverable in the catalogue service. | - Verification successful: Verification confirmation in the process execution<br>                report<br>- Verification failed: If the *Object* is not found, log the failure as an<br>                incident to investigate the ingest and indexing chain | `CPP-013`   |

## Rationale / Worst Case

| Purpose                                                               | Worst Case                                                                             |
| :-------------------------------------------------------------------- | :------------------------------------------------------------------------------------- |
| If the TDA is providing access to its holdings to consumers, ensuring<br>          query services that suit the consumers’ needs is mandatory. | If the catalogue service does not allow query scenarios useful to<br>          the consumers, discoverability and usage of the TDA holdings is compromised. |

## Relationships

| Type          | Related CPP | Description                                                                                                                                                              |
| :------------ | :---------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Requires      | CPP-005     | Enabling Discovery should make use of PIDs.                                                                                                                              |
| Requires      | CPP-009     | Some Metadata provided to the consumer must have<br>          been extracted from the Files.                                                                             |
| Requires      | CPP-016     | Enabling Discovery relies on a correct metadata management process. In particular, *Metadata* created by and within the TDA is of particular interest to the consumer in<br>          order to understand preservation actions that could have affected the *Object* |
| Requires      | CPP-018     | The TDA must have identified the needs of its designated community in<br>          order to enable queries that support the community's defined query scenarios.         |
| Affinity with | CPP-025     | The distinction between **Enabling Discovery and Enabling Access** may be blurred<br>          as derivative copies may be indexed and searched in the same way as *Metadata*. In<br>          addition, these derivative copies may be sufficient to address some consumers’ needs.<br>          Nevertheless, the distinction is still useful as giving access to the original data is<br>          often governed by specific legal constraints, and requires specific hardware and software<br>          tools. |

## Framework Mappings

| Framework     | Term                                                                                  | Section                                                                                  |
| :------------ | :------------------------------------------------------------------------------------ | :--------------------------------------------------------------------------------------- |
| CoreTrustSeal | Discovery                                                                             | R12 Discovery and Identification                                                         |
| Nestor Seal   | Research (options)                                                                    | C4 Access                                                                                |
| ISO 16363     | Discovery                                                                             | 4.5.1 The repository shall specify minimum information requirements to<br>          enable the Designated Community to discover and identify material of interest. |
| OAIS          | No exact term is available in OAIS for Discovery, but the topic is approached through<br>          the Package Description notion | 4.3.3.7 Unit Description<br><br>4.3.3.9 Collection Descriptions                          |
| PREMIS        | Discovery                                                                             | Section "More on Objects", subsection "Intellectual Entities", p. 8.                     |

## Reference Implementations

### Use Cases

| Title                                                                              | Institution                                                          | Documentation                                             | Problem                                                                                                                                                                                 | Solution                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| :--------------------------------------------------------------------------------- | :------------------------------------------------------------------- | :-------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ePADD Discovery module                                                             | Stanford University's Special Collections & University Archives, USA | https://www.epaddproject.org/using-epadd/discovery-module | Email collections are born-digital material that need and allow specific usages and<br>            access. On the other hand, they raise privacy issues that force memory organisations<br>            to give access to these collections only in the organisation’s precinct. Consumers<br>            therefore need to identify the scope and content of the collection through remote<br>            queries before planning an on-site visit. | <pre><code>Beyond the mails’ Metadata, the full text was indexed and is searchable, though not
            entirely readable - when accessing the mail, the full text is redacted, only the
            searched term and email Metadata are displayed. Access to the mails’ collections is
            possible only in the organisation’s precinct.</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| etsin.fairdata.fi (CSC): Open discovery for datasets with varied access conditions | CSC - IT Center for Science, Finland                                 | https://etsin.fairdata.fi/                                | A TDA can host datasets with a wide variety of access conditions. Some may be open<br>            for<br>            immediate download (e.g. via a use copy), while others may require human-mediated<br>            access (even if their ultimate license is open). The challenge for a discovery service<br>            is to represent a) these different states, b) providing access pathways for each<br>            dataset without compromising the specific rights management and c) providing access<br>            policies defined by the data owner.<br>          The Finnish discovery portal etsin.fairdata.fi (CSC) hosts *Metadata* for<br>            both active research data outside of the AIP context and for formally preserved assets (*AIPs*). The first challenge is to provide a clear and reliable method for users to<br>            discover *only* the preserved assets (with associated AIPs); and second, to<br>            represent the specific access conditions for each of those preserved *AIPs*. | <pre><code>The Fairdata services solve this by addressing the discovery of preserved assets by
            providing
            a specific, filterable view of its catalogue. The URL parameter
            ?data_catalog__title=Fairdata+PAS+datasets in https://etsin.fairdata.fi/ creates a
            dedicated
            view within Etsin that exclusively lists datasets corresponding to verified AIPs in
            the long-term Digital Preservation Service (the filter is also selectable via the Etsin
            user
            interface).
          Within this view where only datasets with an associated AIP are visible, the system
            handles varied access policies, as defined by the data owners. It can enforce a spectrum
            of access conditions>Example 1 (Direct Access): For some *AIPs*, a "use copy"
            is made available for immediate download. Etsin provides a direct link to this copy
            while also linking to the canonical AIP record (which is not available via Etsin),
            separating simple use from the formal preservation record.
          Example 2 (Mediated Access): For other *AIPs*, access is controlled. Etsin
            displays a record that might offer a link to a "preview dataset" but withholds the full
            data. It then provides explicit instructions on the required procedure, such as "To get
            this dataset, please contact [email address]."Example 3 (Fully Mediated Access): The system can also handle cases where no
            preview or data is available, and the only option for a user is to follow the
            human-mediated contact instructions provided in the *Metadata*.
          These examples demonstrate how a discovery service can provide a dedicated view for
            preserved *AIPs* (CPP-024) while interpreting and enforcing a range of different
            access rules—from fully open to fully mediated—as defined by rights and access policies
            (CPP-020) and taken into account during the access process (CPP-025).</code></pre> |

### Public Documentation

| Institution                                                                        | Link                                                              | Comment       |
| :--------------------------------------------------------------------------------- | :---------------------------------------------------------------- | :------------ |
| TIB – Leibniz Information Centre for Science and Technology and University Library | https://wiki.tib.eu/confluence/spaces/lza/pages/93608951/Metadata | Internal use: |



---

