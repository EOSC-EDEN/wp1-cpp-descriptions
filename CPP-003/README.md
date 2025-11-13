# Integrity Checking

**Short Definition:** The TDA supports periodic integrity checking, reporting any damaged or missing Files.

## Description and Scope
Integrity checking is a periodically performed process where a checksum is calculated for a target *Information Package* and compared to the existing stored checksum (as calculated in CPP-001 Checksum Generation and Recording). The goal of integrity checking is to confirm that a target *Information Package* has remained unaltered across its life cycle. A *TDA* must perform and document periodic checks, and the frequency of the checks should be defined in its policy as part of the Risk Mitigation (CPP-012) approach.

Integrity checking is closely related to the process of Checksum Validation (CPP-002). Whereas Checksum Validation is tied to *Ingest* (CPP-029), Enabling *Access* (CPP-025), or Replication (CPP-011) (i.e. processes where *Files* are transferred or new copies are created), Integrity Checking is related to continuous risk management. Integrity checking aims to mitigate bit rot and provides evidence for trustworthy preservation by maintaining a continuous audit trail verifying that a *File* has remained unchanged and authentic over time.

Periodic integrity checks are performed separately on all accessible copies of a target *Information Package* (for example, off-line copies in a dark archive are usually excluded from periodic integrity checks). Copies on different storage media might be subjected to different intervals of checks. The results of the integrity checks, including *Fixity Metadata*, should be documented as preservation actions.

If integrity checks discover problems in the integrity of the target *Information Packages*, this information must be clearly documented in a digital archive's system, so that the broken *Information Packages* can be restored from valid copies (see CPP-004 Data Corruption Management).

## Authors
- Johan Kylander

## Contributors
- Bertrand Caron

## Evaluators
- Maria Benauer
- Felix Burger
- Laura Molloy

## Process Definition

### Inputs

| Type     | Input                                           |
| :------- | :---------------------------------------------- |
| Data     | Information Package                             |
| Metadata | Fixity metadata                                 |
| Metadata | Storage management information                  |
| Guidance | Storage management policy - Integrity checking  |
| Guidance | Storage management policy - Checksum algorithms |

### Outputs

| Type     | Output              |
| :------- | :------------------ |
| Metadata | Fixity metadata     |
| Metadata | Provenance metadata |

### Trigger Events

| Description                                                            | Corresponding CPP |
| :--------------------------------------------------------------------- | :---------------- |
| Frequency of integrity checks defined in a digital archive's policy    | `CPP-012`         |
| Suspicion of an error triggering an integrity check on an ad hoc basis |                   |

## Process Steps

| Step | Supplier(s) | Input(s)                                         | Description                                                                                                                                                                            | Output(s)                                                                                               | Customer(s) |
| :--- | :---------- | :----------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------ | :---------- |
| 1    | `CPP-012`   | - Storage management policy - Integrity checking | Gather a batch of targets to check and their corresponding *Fixity metadata* (e.g. *Information Packages* whose last-checked timestamp is older than the specified checking frequency) | - *AIPs*<br>- *Fixity metadata*                                                                         |             |
| 2a   | `CPP-001`   | - *Fixity metadata*                              | For each *AIP* in the selected batch: Gather the *AIP*'s fixity metadata                                                                                                               | - *Fixity metadata*                                                                                     |             |
| 2b   |             | - *Fixity metadata* (algorithms)                 | Calculate the checksum of the *AIP* from the specified *File* path                                                                                                                     | - *Fixity metadata*                                                                                     |             |
| 2c   |             | - *Fixity metadata*                              | Compare the calculated checksum with the stored checksum                                                                                                                               | - Checksums match: proceed to next step<br>- Alert that any of the checksums does not match: mark broken *AIP* for repair and proceed to next step | `CPP-004`   |
| 2d   |             |                                                  | Store the new integrity checking event to the *AIP*                                                                                                                                    | - Provenance metadata                                                                                   |             |
| 2e   |             |                                                  | Update the timestamp of the integrity check                                                                                                                                            | - *Fixity metadata* (timestamp)                                                                         |             |
| 3    |             |                                                  | Document the event and its timestamp                                                                                                                                                   | - Provenance metadata                                                                                   |             |

## Rationale / Worst Case

| Purpose                                 | Worst Case                                                                                                                           |
| :-------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------- |
| Periodic integrity checks on all copies | Data can get corrupted and degenerate (i.e. the chain of custody is not safeguarded, and the authenticity of *IPs* may be destroyed) |

## Relationships

| Type                    | Related CPP | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| :---------------------- | :---------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Requires                | CPP-001     | CPP-001 is responsible for creating checksums that are used in integrity checking.                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| Requires                | CPP-012     | The frequency and target of periodic integrity checks (CPP-003) is defined by an institutional storage management policy as part of risk mitigation (CPP-012).                                                                                                                                                                                                                                                                                                                                                              |
| Required by             | CPP-013     | Periodic integrity checking provides reports on the integrity of data and reports corrupted *AIPs*.                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Required by             | CPP-016     | The timestamp of the *AIPs*' checksums needs to be updated to keep track of the last successful check.                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Affinity with           | CPP-007     | Both processes aim to ensure the "health" of files. However, Integrity Checking focuses on detecting technical corruption of *Files* (e.g. bit rot), whereas virus scanning looks to mitigate human-made risks ( e.g. malicious code).                                                                                                                                                                                                                                                                                      |
| Not to be confused with | CPP-002     | Both CPPs can get input from CPP-001, and both calculate a checksum from an *Information Package* and compare it to a given checksum. The difference is that CPP-002 is done during the *Ingest* or *Access* phases (relating to transfer of content, changes in space), while CPP-003 is done periodically during the preservation of the contents in the archival storage (relating to changes over time). Thus, CPP-002 and CPP-003 are not only triggered by different processes, but also trigger different responses. |

## Framework Mappings

| Framework     | Term             | Section                                          |
| :------------ | :--------------- | :----------------------------------------------- |
| CoreTrustSeal | Fixity checks    | R14 Storage & Integrity                          |
| Nestor Seal   | Integrity checks | C15 Integrity: Functions of the archival storage |
| ISO 16363     | Fixity checks    | 4.4.1.2                                          |
| OAIS          | Error checking   | 4.2.3.4                                          |
| PREMIS        | Fixity check     | 1.5.2, Glossary                                  |

## Reference Implementations

### Public Documentation

| Institution                                                                        | Link                                                                                                                    | Comment |
| :--------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------- | :------ |
| TIB - Leibniz Information Centre for Science and Technology and University Library | https://wiki.tib.eu/confluence/spaces/lza/pages/93608391/Preservation+of+data+integrity+as+part+of+the+process+routines |         |
| TIB - Leibniz Information Centre for Science and Technology and University Library | https://wiki.tib.eu/confluence/spaces/lza/pages/93608373/Archival+Storage#ArchivalStorage-Integrityassurance            |         |
| CSC - IT Center for Science Ltd.                                                   | https://digitalpreservation.fi/en/services/quality_reports/2024                                                         |         |
| Archivematica                                                                      | https://www.archivematica.org/en/docs/storage-service-0.23/fixity/#fixity-docs                                          |         |
| AUSSDA - Austrian Social Science Data Archive                                      | https://aussda.at/fileadmin/user_upload/p_aussda/Documents/kaczmirek_bischof_2024_preservation_fixity_checks_v1_0-1.pdf |         |



---

