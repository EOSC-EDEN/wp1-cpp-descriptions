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

## Process Steps

| Step | Description                                                                                                                                                                            | Inputs                                           | Outputs                                                                                                 |
|:----:|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------:|:-------------------------------------------------------------------------------------------------------:|
| 1    | Gather a batch of targets to check and their corresponding *Fixity metadata* (e.g. *Information Packages* whose last-checked timestamp is older than the specified checking frequency) | - Storage management policy - Integrity checking | - *AIPs*<br>- *Fixity metadata*                                                                         |
| 2a   | For each *AIP* in the selected batch: Gather the *AIP*'s fixity metadata                                                                                                               | - *Fixity metadata*                              | - *Fixity metadata*                                                                                     |
| 2b   | Calculate the checksum of the *AIP* from the specified *File* path                                                                                                                     | - *Fixity metadata* (algorithms)                 | - *Fixity metadata*                                                                                     |
| 2c   | Compare the calculated checksum with the stored checksum                                                                                                                               | - *Fixity metadata*                              | - Checksums match: proceed to next step<br>- Alert that any of the checksums does not match: mark broken *AIP* for repair and proceed to next step |
| 2d   | Store the new integrity checking event to the *AIP*                                                                                                                                    |                                                  | - Provenance metadata                                                                                   |
| 2e   | Update the timestamp of the integrity check                                                                                                                                            |                                                  | - *Fixity metadata* (timestamp)                                                                         |
| 3    | Document the event and its timestamp                                                                                                                                                   |                                                  | - Provenance metadata                                                                                   |

