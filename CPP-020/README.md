# Rights management

**Short Definition:** The TDA manages rights related to the Information Objects, both for agents inside its scope (access, migrate, etc.) and for end users (access, reuse, etc.)

## Description and Scope
Rights Management is the process of performing rights assessments for *Objects* and *Metadata* preserved by the TDA, and managing a rights registry that describes rights basis applicable to these. The rights assessment process must investigate and, if possible, obtain rights applying to both the TDA for retaining and performing its preservation activities, and the consumer for accessing and reusing the *Objects*.

The entity responsible for creating rights statements is the TDA, based on input from the rights stakeholders. Managing rights can be complex and involve multiple and conflicting perspectives. For example, a TDA will typically seek the rights to preserve its holdings and provide open access to the widest possible community, but it also needs to respect rights that limit what it can do and what access it can provide (e.g. data privacy under GDPR). This adds extra complexity, for example a TDA will often be a data processor for the data it is holding and providing access to on behalf of others, but it may also be a data controller if ownership has been assigned to it or if it is directly involved in data collection. Furthermore, in order to perform its mission, it may collect further data about its users (e.g. to allow it to better understand and meet the needs of its designated community) and this usage data also has rights associated with it.

The process of rights assessment consists in determining the rights status of a specific *Object* or *Metadata* regarding different rights basis. Rights basis, as defined as PREMIS, are of different types: * Copyright and intellectual property * Laws * Licenses * Patents * TDA institutional policies * Contracts and service level agreements with the TDA partners * Etc.

The output of rights assessment is a rights statement that defines: * The rights basis applicable to the *Object* and *Metadata*; * The period of time during which the *Object* is governed by said rights basis; * The rules these rights basis prescribe.

Rules are actions (e.g. migrate, give access to, reuse, share, etc.) allowed, prohibited or required by a certain agent (e.g. rights holder, grantor, data controller etc.) to a certain agent (i.e. assignee), and conditions or restrictions limiting the scope of such rules. Among these actions, retention is a crucial one that might be limited in time as *Objects* may be subject to a retention schedule. After that time they can become a liability and may be deleted.

The output of Rights Management is used to define the rights of the TDA to perform several other processes. Only the most obvious ones are mentioned as direct customers for the rights statement: Ingest, Enabling Access, Format Migration, Normalisation, File Repair, Enabling Discovery, and Disposal. In other words, TDAs must ensure to obtain the right to perform preservation actions from laws, licenses or explicit rights assignment from rights stakeholders (i.e. rights holders, data subjects, data controllers, regulators, funding bodies, etc.). They should also clarify to their consumers the actions they are allowed to perform with the *Objects*. This implies that TDAs must provide rights statements to the consumers.

Although Rights statements are commonly attached to Intellectual Entities (IE), they may also apply to specific Representations of such IEs. They should also apply to all *Metadata* provided to internal users or consumers, in particular to discovery *Metadata*. This is especially important in cases where the *Metadata* contains personal data. Complying with the restrictions set in rights statements forms a part of how a TDA manages information security.

Rights management, as the production of rights statements, is a recurrent activity. A minimal rights assessment must be performed at the ingest phase, but a more comprehensive assessment may be postponed to a later time in the *Object*’s life cycle, in particular, when a request for access is made to the TDA. In some cases the outcome of a rights assessment process triggers a TDA to facilitate the update and management of *Metadata* (e.g. cases where data must be pseudonymised or anonymised) or even disposal, if the legal basis for preserving the data has changed. External events can also trigger rights re-assessment activities (e.g. legislative holds for compliance reasons, changes in consent, or notifications of possible infringement for example copyright). In other cases, rights management can trigger or schedule changes in access given to *Objects* for a designated community (e.g. embargoes and leases on research data). A lease is the opposite of an embargo. An embargo restricts access until a given time, for example a dataset can be publicly accessible but only after a given date. A lease says that a dataset can be made accessible but only before a given date and afterwards access is restricted or removed. Likewise, rights may inform retention schedules that trigger future events such as transfer or disposal. Therefore, it is important that the temporal aspect of rights are properly tracked and managed.

A single rights basis usually applies to several *Objects* or *Metadata* (e.g. a Creative Commons license). Thus, the Rights Management process also consists in managing a rights basis registry.

## Authors
- Bertrand Caron

## Contributors
- Johan Kylander

## Evaluators
- Felix Burger
- Maria Benauer
- Matthew Addis

## Process Definition

### Inputs

| Type     | Input                |
| :------- | :------------------- |
| Data     | Object               |
| Metadata | Descriptive metadata |
| Metadata | Provenance metadata  |

### Outputs

| Type     | Output                    |
| :------- | :------------------------ |
| Metadata | Optional: Rights metadata |
| Guidance | Rights statement          |

### Trigger Events

| Description                                                                              | Corresponding CPP |
| :--------------------------------------------------------------------------------------- | :---------------- |
| Appraisal or re-appraisal                                                                |                   |
| Any process that requires rights clearance to act upon an *Object*,<br>                        if a comprehensive rights assessment was not performed at ingest | `CPP-025`         |
| In particular, access request                                                            | `CPP-025`         |
| Revision after the end of a fixed-term rule (e.g. embargo, lease, etc.)                  |                   |
| Changes in legislation, changes in consent, infringement or take down<br>                        requests, etc. |                   |

## Process Steps

| Step | Supplier(s) | Input(s)                                                 | Description                                                                                          | Output(s)                                         | Customer(s) |
| :--- | :---------- | :------------------------------------------------------- | :--------------------------------------------------------------------------------------------------- | :------------------------------------------------ | :---------- |
| 1    |             | - *Object*<br>- *Metadata*<br>- Input from producer, rights holder and data controller | Determine which rights basis apply to the *Object* or *Metadata*                                     | - Applicable rights basis                         |             |
| 2    |             | - Applicable rights basis<br>- Input from producer, rights holder and data controller | Determine (if possible by negotiation with producer, rights holder and<br>                            data controller) the rules implied by the rights basis (action,<br>                            assignee, duration, restrictions or conditions) | - Applicable rules                                |             |
| 3    |             | - Applicable rights basis<br>- Input from producer, rights holder and data controller | Determine (if possible by negotiation with producer, rights holder and<br>                            data controller) the applicable dates of the rights basis (start and end<br>                            date) | - Time-delimited status                           |             |
| 4    |             | - Applicable rights basis<br>- Applicable rules<br>- Time-delimited status | If needed (depending on the the existing status of the *Object*<br>                            and the applicable rights basis and rules) negotiate with the producer<br>                            new rights assignment | - New rights basis (e.g. contract, license, etc.) |             |
| 5    |             | - New rights basis (e.g. contract, license, etc.)        | If a new rights basis had to be created (e.g. a new contract, new<br>                            license, etc.), preserve its complete documentation | - Rights basis documentation                      |             |
| 6    |             | - *Object*<br>- Applicable rights basis<br>- Applicable rules<br>- Time-delimited status | Associate the *Object* with the rights statement                                                     | - Rights statement                                | `CPP-014`<br>`CPP-017`<br>`CPP-024`<br>`CPP-025`<br>`CPP-026`<br>`CPP-027`<br>`CPP-029` |
| 7    |             | - Rights statement                                       | Optionally, encode / map rights statement into machine-actionable form<br>                            and record it as Rights metadata | - Rights metadata                                 | `CPP-016`   |
| 8    |             | - *Metadata*<br>- Information Packages                   | If the updated rights statement requires, trigger one of the following<br>                            processes:<br>                        <br>•  *Metadata* must be anonymised (or pseudonymised)<br>                            <br>•  Disposal of Information packages<br>                            <br>•  Grant / deny access to a specific community. |                                                   | `CPP-016`<br>`CPP-017`<br>`CPP-025` |

## Rationale / Worst Case

| Purpose                                                                                      | Worst Case                                                                                     |
| :------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------- |
| A minimal rights assessment at the ingest phase is required, although a more<br>                    comprehensive process may be carried out at a later time in the *Object*<br>                    life cycle. | Without rights assessment, a TDA might be incapable of performing preservation<br>                    actions.<br>                Its consumers might be discouraged to use the *Object* if no explicit<br>                    rights statement is provided by the TDA.<br>                The TDA might be exposed to liability or legal and financial harm.<br>                The TDA may end up retaining data for longer than needed or allowed, which can<br>                    increase costs (e.g. storage). |

## Relationships

| Type        | Related CPP | Description                                                                           |
| :---------- | :---------- | :------------------------------------------------------------------------------------ |
| Required by | CPP-016     | Any information regarding the rights for the TDA and the end users needs to be<br>                    stored and should be searchable and retrievable for all data. |
| Required by | CPP-025     | The TDA must assess access rights to check if it is authorised to provide<br>                    access to the requester. |
| Required by | CPP-029     | Some minimal rights assessment must be performed during ingest to verify that<br>                    the TDA should be in charge of preserving the content of the SIP. |

## Framework Mappings

| Framework     | Term                                                                | Section                                                                                              |
| :------------ | :------------------------------------------------------------------ | :--------------------------------------------------------------------------------------------------- |
| CoreTrustSeal | Rights management                                                   | R02. The repository maintains all applicable rights and monitors compliance                          |
| Nestor Seal   | Monitor[ing] and document[ing] conformity with relevant regulations | C7 Legal conformity                                                                                  |
| ISO 16363     | /                                                                   | 3.5.1.1 The repository shall have contracts or deposit agreements which<br>                    specify and transfer to it all necessary preservation rights, and those rights<br>                    transferred shall be documented. |
| OAIS          | No exact matching term exists in the OAIS functional model.         | Among many rights considerations, OAIS reserves a specific treatment to Access<br>                    RIghts Information in its informational model (section 4.3.2.4.3 “Preservation<br>                    Description Information”). In addition, the section 3.3.3 “Obtains sufficient<br>                    control for long term preservation” describes one of the OAIS’ responsibilities,<br>                    providing some insights into the rights management process for the TDA internal<br>                    needs. |
| PREMIS        | No exact matching term exists in PREMIS                             | PREMIS describes all metadata elements required to describe a comprehensive<br>                    rights statement in its section on the Rights Entity. The topic of rights<br>                    management is also covered in another section, “More on Rights”. |

## Reference Implementations

### Use Cases

| Title                                                                  | Institution                                    | Documentation | Problem                                                                                          | Solution                                                                                                                                                                                                                                                                                                                                                           |
| :--------------------------------------------------------------------- | :--------------------------------------------- | :------------ | :----------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Negotiating Rights for Born-Digitals at the National Library of France | Bibliothèque nationale de France (BnF), France | /             | The assessment usually leads to the signature of a contract which allows<br>                        BnF to collect, copy, give access, migrate and exhibit *Objects*. In<br>                        the case where the producer released the *Object* under an open<br>                        license, it may allow BnF to perform such actions on the content without<br>                        negotiating an explicit contract with the rights holder(s). | <pre><code>Rights negotiations cover primarily access rights (remotely and without
                        any restriction via the digital library Gallica, on-premise via Gallica
                        Intra Muros or on the library’s public workstations via an access request),
                        retrieval (download) and reuse rights.</code></pre> |

### Public Documentation

| Institution                                                                        | Link                                                                                                  | Comment           |
| :--------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------- | :---------------- |
| TIB – Leibniz Information Centre for Science and Technology and University Library | https://wiki.tib.eu/confluence/spaces/lza/pages/93608951/Metadata#Metadata-ADMAdministrativemetadata" | Rights metadata   |
| CSC – IT Center for Science Ltd.                                                   | https://urn.fi/urn:nbn:fi-fe2024051731943                                                             | Service contracts |
| Archivematica                                                                      | https://www.archivematica.org/en/docs/archivematica-1.17/user-manual/ingest/ingest/#add-premis-rights | Rights statements |
| Rosetta                                                                            | https://www.archivematica.org/en/docs/archivematica-1.17/user-manual/ingest/ingest/#add-premis-rights | Acess rights      |



---

