# Enabling Access

**Short Definition:** The TDA gives access to its Information Objects to authorised internal users or end users.

## Description and Scope
Data access in digital preservation refers to the ability to retrieve, view, and use preserved digital materials in meaningful ways over extended periods of time. The access as a whole involves several aspects. This CPP concentrates on the aspects within technical accessibility, and leaves out aspects like **Enabling Discovery** (CPP-024) and delivery methods (e.g. user interfaces and APIs). A TDA must implement access to the data it preserves to consumers that are authorised to access the data in question.

Technical accessibility means ensuring that digital *Files* remain readable and usable despite technological change. This requires maintaining compatibility with current systems through **File Migration** (CPP-014), emulation strategies (CPP-015 **Emulation and Rendering Tools**), or preservation of legacy hardware and software environments. The preserved data must be retrievable from storage systems and renderable in forms that users can actually engage with.

From a technical point of view, **Enabling Access** is about providing *DIPs* containing the requested data in appropriate *Representations*. The TDA, upon receiving a request, creates and provides a *DIP* from one or more *AIPs* stored in the TDA. The TDA also, if it supports this, provides access to derivatives that are *Representations* of the preserved data that are specifically created for use, viewing, or interaction, rather than giving them access to the master data. The derivatives can be created at different stages of digital preservation: in pre-ingest phase, during ingest, within the preservation lifespan, or on the fly when the derivative is needed. This approach is TDA-dependent and can be enforced by a policy. In any of these cases, however, the access process should always provide the data in the form of a *DIP* by a TDA to a consumer (e.g. end user; portal or aggregator; data publication platform or some other service or system communicating with the TDA).

The accessed data may include restrictions or sensitive, confidential or rights-protected parts (CPP-020 **Rights Management**). Also, an organisation’s data can be non-public, and/or non-accessible for other organisations. Therefore, access should incorporate authentication and authorisation functions to control who can access what data, implementing necessary restrictions while enabling legitimate use. Restrictions on accessing data (particularly digital *Objects*) are usually different from restrictions to find and discover data (CPP-024 **Enabling Discovery**).

## Authors
- Mikko Laukkanen
- Johan Kylander

## Contributors
- Kris Dekeyser

## Evaluators
- Matthew Addis
- Felix Burger
- Maria Benauer

## Process Definition

### Inputs

| Type     | Input                                                                                                |
| :------- | :--------------------------------------------------------------------------------------------------- |
| Data     | Request for a DIP                                                                                    |
| Metadata | Request Metadata specifying the kind of digital Objects to be accessed (master Files or derivatives) |
| Guidance | Access policy                                                                                        |

### Outputs

| Type     | Output             |
| :------- | :----------------- |
| Metadata | Technical metadata |

### Trigger Events

| Description         | Corresponding CPP |
| :------------------ | :---------------- |
| Request for a *DIP* |                   |

## Process Steps

| Step | Supplier(s) | Input(s)                                    | Description                                                                                                                                                               | Output(s)                                                                         | Customer(s) |
| :--- | :---------- | :------------------------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :-------------------------------------------------------------------------------- | :---------- |
| 1    |             | - *DIP* request                             | The TDA receives a *DIP* request specifying the type of data to be accessed                                                                                               | - Requester info from the request                                                 |             |
| 2    |             | - Requester info from the request           | The TDA authenticates the request                                                                                                                                         | - Authenticated request (step 3)<br>- Rejected request (return rejection message to requester, got to step 4 and then<br>					end the process after logging it) |             |
| 3    | `CPP-020`   | - Requester info from the request<br>- Rights statement | The TDA authorises the request                                                                                                                                            | - Authorised request (step4)<br>- Rejected request (return rejection message to requester, got to step 4 and then<br>					end the process after logging it) |             |
| 4    |             | - *DIP* request                             | The TDA logs the request for statistical reporting and auditing                                                                                                           | - Access log                                                                      |             |
| 5a   |             | - Authenticated and authorised request      | The TDA locates the *AIP* or set of *AIPs*, from which the *DIP* is created                                                                                               | - *AIP* or a set of *AIPs*                                                        |             |
| 5b   |             | - Non-authenticated or unauthorised request | The TDA responds with error                                                                                                                                               | - Error response                                                                  |             |
| 6a   |             | - *AIP* or a set of *AIPs*                  | The TDA ensures that the selected *AIP* or set of *AIPs* is valid and intact (e.g. performs checksum validation and other potential checks)                               | - *AIP* or a set of *AIPs*                                                        |             |
| 6b   | `CPP-020`   | - *AIP* or a set of *AIPs*                  | If the request includes derivatives that should be created, the TDA uses CPP-028 (**Creation of Derivatives**) to create the copies on the fly (if the TDA supports this) | - *AIP* or a set of *AIPs*                                                        |             |
| 6c   |             | - *AIP* or a set of *AIPs*                  | The TDA creates a *DIP* from the *AIP* or set of *AIPs* (*AIP* to DIP transformation) and the potential derivatives                                                       | - *DIP*                                                                           |             |
| 6d   |             | - *DIP*                                     | The TDA checks that the created *DIP* is valid according to its specifications before making it available                                                                 | - *DIP*                                                                           |             |
| 7    |             | - *DIP*                                     | The TDA makes the *DIP* available to the requester or consumer                                                                                                            | - Delivered *DIP*                                                                 |             |

## Rationale / Worst Case

| Purpose                                                                 | Worst Case                                                               |
| :---------------------------------------------------------------------- | :----------------------------------------------------------------------- |
| Data access is an essential functionality of a TDA, because of<br>				its purpose to maintain	the long-term availability of the<br>				preserved information. Preservation aims to ensure that information<br>				remains discoverable, accessible and usable. | Without access, digital preservation becomes just an expensive storage.<br>				Thus, the TDA fails to fulfill its purpose to maintain the long-term<br>				availability of digital *Objects* over time. |

## Relationships

| Type                    | Related CPP | Description                                                                   |
| :---------------------- | :---------- | :---------------------------------------------------------------------------- |
| Requires                | CPP-002     | During the access process, the fixity of the provided digital<br>				*Object* is validated. |
| Requires                | CPP-005     | Accessing digital *Objects*, *Files* or *Metadata* should be<br>				based on identifiers as parameters. |
| Requires                | CPP-020     | The TDA must assess access rights to check it is<br>				authorised to provide access to the requester. |
| Required by             | CPP-015     | The access request is the trigger to invoke the rendering process or start up<br>				the emulated environment. |
| Required by             | CPP-017     | Disposal prevents access to the *Objects*. Also, preventing access can be<br>				considered as "logical disposal". |
| Required by             | CPP-028     | The request for access can trigger the creation of a derivative<br>				for rendering purposes (e.g. derivatives may be created on<br>				the fly if Access cannot rely on an existing derivative). |
| Affinity with           | CPP-013     | Access of contents includes providing *Provenance* metadata, statistical<br>				data and quality reports to the consumer. |
| Affinity with           | CPP-019     | *DIPs* should conform to the quality aspects specified by the TDA.            |
| Affinity with           | CPP-024     | Enabling Discovery is about making data findable, while Enabling Access<br>				is about providing the data to a consumer. Data may have different<br>				restrictions for discovery and access. |
| Not to be confused with | CPP-006     | Enabling Access does not export the data from TDA.                            |

## Framework Mappings

| Framework     | Term                      | Section                                                                                              |
| :------------ | :------------------------ | :--------------------------------------------------------------------------------------------------- |
| CoreTrustSeal | Access                    | R01 The repository has an explicit mission to provide access to and preserve digital objects.<br><br>R03 The Repository has a plan to ensure ongoing access to and preservation of its data and metadata. |
| Nestor Seal   | Access                    | C4 Access                                                                                            |
| ISO 16363     | Access<br>        Access management | 3.1.1<br><br>4.6                                                                                     |
| OAIS          | Access                    | 4.2.3.8. Access                                                                                      |
| PREMIS        | Dissemination             | Glossary                                                                                             |

## Reference Implementations

### Public Documentation

| Institution                                                                        | Link                                                            | Comment                         |
| :--------------------------------------------------------------------------------- | :-------------------------------------------------------------- | :------------------------------ |
| TIB – Leibniz Information Centre for Science and Technology and University Library | https://wiki.tib.eu/confluence/spaces/lza/pages/93608366/Access |                                 |
| CSC - IT Center for Science Ltd., Finland                                          | https://urn.fi/urn:nbn:fi-fe2023062157386                       | section 2.2, Principles 3 and 5 |



---

