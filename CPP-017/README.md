# Disposal

**Short Definition:** The TDA enables the managed disposal of Information Packages and permits the retention and maintenance of Metadata even when the content of the Information Package has been removed from the TDA.

## Description and Scope
Disposal refers to the process of removing or decommissioning *Information objects* from a TDA when its preservation is no longer needed or possible, or the *Object* has fulfilled its short-term preservation requirements. The latter requires appraisal and scheduling, where institutions establish clear policies defining how long different types of *Objects* should be preserved. Disposal is usually triggered on *AIP* level.

Disposal can be triggered by the following reasons: * The TDA no longer has a legal basis to retain data (e.g. there is no consent); * The TDA has been requested to remove data (e.g. there is a legitimate take down request); * The TDA has transferred data to another TDA and no longer needs to retain the data; * The data is no longer usable by the designated community (e.g. because it has been corrupted or damaged and is beyond repair, or because quality assessment shows that it is no longer usable); * The data is no longer being used by the designated community, there is no expectation of future use, and organisation policy requires it to be disposed of (e.g. to reduce operational costs); * The retention period for data has expired and the data should be disposed of (e.g. to ensure regulatory or legislative compliance); * The TDA has alternative versions of the data that allow the original to be disposed of (e.g. as a result of normalisation or migration, or because a depositor has provided a superior version); * The funding bodies that support the TDA no longer require or fund retention of the data (e.g. because the data no longer has funding body requirements for it to be accessible); * The TDA elects to dispose of data (e.g. to help ensure its long-term sustainability in economic or ecological terms).

The TDA must have a disposal policy, that in addition to the disposal of *Objects* or (derivative) *Files* includes related *Technical* and *Descriptive metadata*. This is especially important when the related *Metadata* contains sensitive or confidential information. The policy may state that all or most of the *Metadata* is retained, disposed, or something in between. However, at minimum, TDA must create and retain provenance *Metadata* about the disposal and provide (e.g. some “tombstone metadata” for keeping the PIDs resolvable).

The TDA must also consider the technical aspects of disposal, such as secure deletion methods that prevent data recovery, and the potential impact on related *Objects* that may reference the disposed items.

As the *Objects* can be copied and distributed across multiple storage systems and different storage media within a TDA, the complete physical removal of all copies might be complex and needs a timeframe. For instance, whereas a *File* is quick and easy to remove from a hard drive, it may be practically impossible to remove it from a magnetic tape. Thus, the actual disposal of copies of *Files* on tapes may occur only at the time when the tape is refreshed (i.e. the disposed *File* is then not included on the new tape). Therefore, the first step to do could be a “logical disposal” (i.e. preventing access to the *Object*, which gives time for the TDA to dispose of the physical copies). Sometimes this is referred to as “Deaccessioning” where *Objects* are removed from the collections that an organisation holds before the *Objects* are physically disposed of. The storage management information must be updated accordingly.

Disposal decisions must be made carefully, as recovering disposed *Objects* may be impossible after physical deletion has been performed. Thus, effective disposal requires clear policies, robust documentation, secure technical procedures, and ongoing monitoring. The disposal process must produce audit trails and other relevant documentation about the disposal. An organisation may choose to implement additional safeguards as part of the disposal process depending on the type of data they hold. For example, data may be moved to a ‘trash bin’ for a period of time before permanent deletion takes place, which can be used to provide a short-term recovery window to guard against unwanted deletion (accidental or deliberate). Request, review or approval processes may also be employed. For example to prevent permanent deletion of an *Object* without explicit and documented approval from a requisite number of staff members who are authorised to approve disposal.

## Authors
- Mikko Laukkanen
- Juha Lehtonen

## Contributors
- Kris Dekeyser
- Johan Kylander

## Evaluators
- Matthew Addis
- Felix Burger
- Maria Benauer

## Process Definition

### Inputs

| Type     | Input                         |
| :------- | :---------------------------- |
| Data     | Information objects           |
| Metadata | Rights metadata               |
| Metadata | Technical metadata            |
| Metadata | Descriptive metadata          |
| Guidance | Appraisal reports             |
| Guidance | Quality reports               |
| Guidance | Retention Policy              |
| Guidance | Policies                      |
| Guidance | Legal aspects (e.g. licenses) |

### Outputs

| Type     | Output                                                                                               |
| :------- | :--------------------------------------------------------------------------------------------------- |
| Metadata | Provenance metadata                                                                                  |
| Metadata | Tombstone metadata                                                                                   |
| Guidance | Audit trails                                                                                         |
| Guidance | Possible certificates/records of disposal (especially in the case of sensitive or confidential data) |

### Trigger Events

| Description                                                                                 | Corresponding CPP |
| :------------------------------------------------------------------------------------------ | :---------------- |
| *Information packages* or *Files* are identified as corrupted and not<br>                        recoverable. Data corruption management may trigger the disposal. | `CPP-004`         |
| Changes to community needs                                                                  | `CPP-018`         |
| The data quality assessment tasks may discover intolerably low-quality issues <br>                        in a digital *Object* and provide a trigger for disposal | `CPP-019`         |
| Changes in legislature, rights, regulations, licenses, standards and alike                  | `CPP-020`         |
| Detected risks                                                                              | `CPP-023`         |
| The file repair process may end up with a situation where the *File*<br>                        cannot be repaired. In such cases, disposal is required by the file<br>                        repair process. | `CPP-027`         |

## Process Steps

| Step | Supplier(s) | Input(s)                                                      | Description                                                                                                        | Output(s)                                                             | Customer(s) |
| :--- | :---------- | :------------------------------------------------------------ | :----------------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------- | :---------- |
| 1a   | `CPP-004`   | - Quality reports                                             | TDA finds out, from management events or other triggering events,<br>                                that an *AIP* or *File* is corrupted and is not recoverable. The TDA<br>                                decides to dispose of it. | - Storage management information (list of affected *AIPs*, *Files*)<br>- Disposal request |             |
| 1b   | `CPP-018`   | - Changes to the needs of the designated community            | The designated community no longer has a need for the data, it is<br>                                demonstrably not making any use of the data, and there is no expectation <br>                                that it will make any future use of the data. Therefore, the TDA decides to <br>                                dispose of the data. | - *Storage management information* (list of affected *AIPs*, *Files*)<br>- Disposal request |             |
| 1c   | `CPP-019`   | - Quality reports                                             | The quality of the data no longer meets the minimum requirements of the <br>                                designated community or the data is available in an alternative and higher quality<br>                                version or format. Therefore, the TDA decides to dispose of the data. | - *Storage management information* (list of affected *AIPs*, *Files*)<br>- Disposal request |             |
| 1d   | `CPP-020`<br>`CPP-023` | - Quality reports<br>- Intellectual property change<br>- Risk detection | TDA gets a trigger event indicating that an *AIP* or *File* needs <br>                                to be disposed of. | - *Storage management information* (list of affected *AIPs*, *Files*)<br>- Disposal request |             |
| 1e   |             | - Appraisal reports                                           | The retention period of the data has been fulfilled according to the<br>                                appraisal or reappraisal of the data. | - *Storage management information* (list of affected *AIPs*, *Files*) |             |
| 2    |             | - *Storage management information* (list of affected *AIPs*, <br>                            *Files*)<br>- Disposal request<br>- TDAs policy on disposal | Creation of a disposal plan for the data in question from the policy. It should <br>                        address the following issues:<br>                    <br>•  Creation of tombstone metadata for PIDs<br>                        <br>•  Defining the retention period between logical disposal and physical disposal<br>                        <br>•  Documenting the disposal request | - Disposal plan                                                       |             |
| 3    |             | - Disposal request                                            | Document the disposal request (such as the reason), the affected<br>                        *AIPs* or *Files*, timestamps | - *Provenance metadata*                                               |             |
| 4    |             | - Disposal plan<br>- *Storage management information*         | Implement deaccessioning/logical disposal. Prevent access to the<br>                        *Object*, its discovery, and exclude it from any external reporting<br>                        (such as statistical data generation). | - *Provenance metadata*                                               |             |
| 5    |             | - Disposal plan                                               | If identifiers exist: the creation of tombstone metadata.                                                          | - *Tombstone metadata*                                                |             |
| 6    |             | - Disposal plan                                               | Physical disposal of copies from primary random access media,<br>                        such as hard disk drives. Update *storage management information*<br>                        (removal of storage locations). | - *Storage management information*<br>- *Provenance metadata*         |             |
| 7    |             | - Disposal plan<br>- *Storage management information*         | Physical disposal of copies from secondary sequential access media, such as <br>                        magnetic tapes and off-line copies. Usually done at later stages during (e.g.<br>                        Refreshment). Update *storage management information* (removal<br>                        of storage locations). | - *Storage management information*<br>- *Provenance metadata*         |             |
| 8    |             | - Disposal is complete                                        | If evidence is required that disposal has been completed,<br>                        then create a certification of destruction that confirms that all<br>                        copies of the data have been permanently deleted. | - Destruction Certificate                                             |             |

## Rationale / Worst Case

| Purpose                                                                                        | Worst Case                                                                                 |
| :--------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------- |
| Disposal could be legally mandatory in terms of privacy and retaining only<br>                    necessary content. | Legal consequences                                                                         |
| Not disposing of data in a timely way results in unnecessary and irrelevant<br>                    content being retained. This could worsen the consequences of cyber<br>                    attacks (e.g. ransomware of data that should have been disposed of before<br>                    the attack). Or if the data is compromised then it could result in<br>                    privacy breaches. | Exploitation of security vulnerabilities, more costly to recover from cyber <br>                    attacks, data privacy breaches |
| Retaining data that is no longer needed can impact on data quality<br>                    and integrity. Removing outdated, duplicated, or corrupted *Objects* helps<br>                    maintain the quality and usability of the TDA. | Reduction in data quality and integrity                                                    |
| Removing data reduces the TDA’s storage and processing footprint.                              | Increased costs data storage costs. Increased environmental footprint. Increased <br>                    time and effort for future preservation activities (e.g. re-appraisal) |

## Relationships

| Type                    | Related CPP | Description                                                                                            |
| :---------------------- | :---------- | :----------------------------------------------------------------------------------------------------- |
| Requires                | CPP-005     | Identifiers must be taken care of during disposal                                                      |
| Requires                | CPP-018     | Soft dependency (i.e. may require): Community watch treats Disposal as a customer in <br>                    cases where, for instance, a collection previously archived within the TDA has <br>                    been also added to a different TDA and will be preserved there. Required actions <br>                    downstream must be taken into account within the disposal process (e.g. notifying <br>                    stakeholders about the changed preservation location). |
| Requires                | CPP-025     | Disposal prevents access to the *Objects*. Also, preventing access can be <br>                    considered as "logical disposal" |
| Required by             | CPP-016     | A tombstone consisting of only Metadata - without the actual data -<br>                    has to be kept as a witness of the data’s former presence. |
| Not to be confused with | CPP-006     | Disposal does not export the *Objects* from TDA.                                                       |

## Framework Mappings

| Framework     | Term                             | Section                                                                       |
| :------------ | :------------------------------- | :---------------------------------------------------------------------------- |
| CoreTrustSeal | Deletion                         | R14 The repository applies documented processes to ensure data and *Metadata*<br>                    storage and integrity. |
| ISO 16363     | Disposal<br>                Disposal records | 3.3.3<br><br>4.2.3.3                                                          |
| OAIS          | Deletion                         | 3.3.6                                                                         |
| PREMIS        | Deaccession                      | Glossary                                                                      |

## Reference Implementations

### Public Documentation

| Institution                                                                        | Link                                                                                                                                                                                                       | Comment                                                                                                |
| :--------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------- |
| TIB - Leibniz Information Centre for Science and Technology and University Library | https://knowledge.exlibrisgroup.com/Rosetta/Product_Documentation/Rosetta_Staff_Users_Guide/Data_Managers/005_Delete%2C_Restore%2C_Move%2C_and_Purge_IEs#About_Deleting.2C_Recovering.2C_and_Purging_an_IE |                                                                                                        |
| Archivematica                                                                      | https://www.archivematica.org/en/docs/archivematica-1.17/user-manual/archival-storage/archival-storage/#delete-aip                                                                                         | No explicit support for retention management, but there is a request/approve workflow for AIP deletion |



---

