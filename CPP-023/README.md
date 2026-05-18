# Risk Properties Definition and Extraction

**Short Definition:** The TDA monitors preservation risks and defines detection methods for determining whether the deposited digital objects are subject to these risks.

## Description and Scope
Risk Properties Definition and Extraction is a multi-tiered process that a) identifies risks caused by the specific properties and content of a file, b) defines methods to detect these risks based on file analysis (i.e. format identification, metadata extraction and format validation), and c) holds responsibility for performing technology watch. Together with CPP-012 Risk Mitigation, which defines which actions can be undertaken to reduce the likelihood or impact of the risk, CPP-023 Risk Properties Definition and Extraction is an essential process in the scope of the broader, on-going “risk management” activity.

Risk Properties Definition and Extraction is also the process responsible for technology watch. It receives updates from Community Watch (CPP-018), such as conference papers, specialised literature and journals, vendor announcements, etc. Based on that, it evaluates the impact of the risk with regard to the skills, objectives and means of the Designated Community. In particular, the two following activities are in scope of this CPP: * Risk Identification involves cataloging potential threats to digital materials, including technological obsolescence (e.g. hardware or software becoming unavailable), media degradation (e.g. physical deterioration of storage devices), format obsolescence ( e.g. file formats being no longer supported), organisational risks (e.g. loss of institutional knowledge or funding), and environmental hazards (e.g. human failure and disasters such as power failures or security breaches). * Risk Assessment evaluates the likelihood and potential impact of identified risks. This typically involves analysing object- and organisation-related factors like the criticality of the digital materials; the object’s primary and secondary value; the stability of their formats; and the resources available for preservation activities.

Problems in the rendering or reuse of *Files* by the TDA’s end users may stem from several reasons. For example, one common reason is the use of certain file format features, that rendering tools may misinterpret. To mitigate such misinterpretation, preservation actions (e.g. CPP-014 File Migration, CPP-027 File Repair, CPP-015 Emulation and Rendering Tools, etc.) should go beyond file format or validity status and consider risk properties. Risk properties are *File* or *Representation* properties that help identify whether a *File* is subject to a specific risk. Some examples of risk properties are: * Discontinued support of file format; * Erroneous file format structures; * Encryption; * External dependencies (e.g. non-embedded fonts); * Embedded *Files*; * Advanced multimedia features; * Specific creating application, when said application is known to have created faulty *Files*; * etc.

It is important to note that risk properties, in some cases, may be also considered significant properties, however, this is not necessarily the case For example, a valid PDF may be encrypted with an [empty password](https://qpdf.readthedocs.io/en/stable/encryption.html#user-and-owner-passwords). This is a risk property (it may endanger the following preservation processes) but it may not be considered a significant property (the TDA may decide to decrypt the PDF and keep it decrypted). Risk properties are typically defined by digital preservation analysts, while significant properties should be defined by the TDA management and stakeholders.

The step-by-step description below focuses more specifically on the risk extraction part of the process. Like Risk Mitigation, Risk Properties Definition and Extraction focuses on a specific subset of risks - in this case, risks related to inherent properties of *Files*. Although of major impact, the definition and detection of risks caused by organisational, financial or security issues are not described.

## Authors
- Bertrand Caron

## Contributors
- Kris Dekeyser

## Evaluators
- Franziska Schwab
- Maria Benauer
- Felix Burger

## Process Definition

### Outputs

| Type     | Output                         |
| :------- | :----------------------------- |
| Guidance | Risk property                  |
| Guidance | Risk property detection method |
| Guidance | Updated risk inventory         |

### Trigger Events

| Description       | Corresponding CPP |
| :---------------- | :---------------- |
| Community alerts  | `CPP-018`         |
| Technology alerts |                   |

## Process Steps

| Step | Supplier(s) | Input(s)                                                             | Description                                                                                   | Output(s)                                                                                           | Customer(s) |
| :--- | :---------- | :------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------- | :---------- |
| 1    | `CPP-010`<br>`CPP-018`<br>`CPP-023` | - Information sources for digital preservation<br>- New findings gained through technical analysis<br>- Risk properties policy and detection method | Receive community and technology alerts                                                       | - Risk                                                                                              |             |
| 2    |             | - Risk                                                               | Evaluate the risk likelihood and impact.                                                      | - Assessment of risk likelihood and impact                                                          |             |
| 3    |             | - Risk                                                               | Gather a test set of *Files* (compiled of both files that are<br>                            subject to this risk and a control group). | - Test set                                                                                          |             |
| 4    |             | - Risk                                                               | Select a candidate tool for identifying the risk                                              | - Candidate extractor tool                                                                          |             |
| 5    |             | - Test set<br>- Candidate extractor tool                             | Run the candidate extractor tool on the test set                                              | - Candidate extractor tool output                                                                   |             |
| 6    |             | - Candidate extractor tool output                                    | Determine which property in the candidate extractor tool output helps<br>                            distinguish those *Files* that are affected by the risk and those<br>                            that are not. | - Successful identification of a risk property detection method<br>                                (extractor tool) (step 7)<br>- No method identified: resume steps 3-5 |             |
| 7    |             | - Chosen extractor tool output                                       | Determine the interpretation of the extractor tool output                                     | - Risk property detection method: path / expression to extract the<br>                                risk property from the tool’s output.<br>                            (This interpretation should resolve to a true/false statement<br>                                about the file being subject to the risk or not. It can be simple<br>                                (an XPATH to the textual content of an element in an XML output) or<br>                                more complex. See, about this, the use case about multipage TIFFs<br>                                below.) |             |
| 8    |             | - Risk<br>- Risk property<br>- Risk property detection method: path / expression to extract the<br>                                risk property from the tool’s output | Update the risk inventory with the risk, risk property and risk<br>                            property detection method. | - Updated risk inventory                                                                            | `CPP-009`   |

## Rationale / Worst Case

| Purpose                                                                                     | Worst Case                                                          |
| :------------------------------------------------------------------------------------------ | :------------------------------------------------------------------ |
| Risk assessment is critical for digital preservation activities because<br>                    identifying risks related to the inherent characteristics of *Files* is<br>                    required for a semantic / logical preservation approach. | The impact of the absence of risk assessment on *Files*’<br>                    characteristics may lead to different problems:<br>                <br>•  Broken, undetected dependencies;<br>                    <br>•  Unusual features badly supported by rendering tools;<br>                    <br>•  etc. |

## Relationships

| Type          | Related CPP | Description                                                                                          |
| :------------ | :---------- | :--------------------------------------------------------------------------------------------------- |
| Requires      | CPP-008     | Risks can be related to file format generic properties and concern all<br>                    instances of it. In such a case, File Format Identification is sufficient to<br>                    determine whether the file is affected by the risk. For example, Microsoft<br>                    announced the discontinuation of its software product Publisher. As a<br>                    consequence, all .pub files are now affected by the absence of a suitable<br>                    software environment. |
| Requires      | CPP-009     | Risks can be related to properties common to one or several file formats. In<br>                    such a case, Metadata Extraction is required to determine whether the file is<br>                    affected by the risk. For example, running a metadata extractor like Apache Tika<br>                    is required to check whether a PDF is encrypted or not. |
| Requires      | CPP-018     | Risk is measured against the skills and tools available in the Designated<br>                    Community. |
| Affinity with | CPP-019     | Risk Properties Definition and Extraction and CPP-019 both define properties<br>                    that the TDA should consider and assess against the result of CPP-009 (Metadata<br>                    extraction). |
| Required by   | CPP-009     | Risk Properties Definition and Extraction provides the requirements for the<br>                    selection of an appropriate extractor tool. |
| Required by   | CPP-012     | Risk Properties Properties Definition and Extraction maintains a risk<br>                    inventory that guides the Risk mitigation process. |
| Required by   | CPP-014     | Risk Properites Definition and Extraction identifies risks related to file<br>                    format that would trigger File Migration and provides the method for their<br>                    detection. |

## Framework Mappings

| Framework     | Term                                 | Section                                                                                                     |
| :------------ | :----------------------------------- | :---------------------------------------------------------------------------------------------------------- |
| CoreTrustSeal |                                      | CTS does not explicitly mention Risk Properties Definition and Extraction, although it is<br>                    within the scope of R09 (Preservation planning). |
| Nestor Seal   |                                      | Nestor Seal does not explicitly mention Risk Properties Definition and Extraction,<br>                    although C11 Preservation measures are based on a risk properties definition process as<br>                    described in this CPP. |
| ISO 16363     | “identifying each preservation risk” | ISO 16363 mentions Risk Properties Definition and Extraction in section 4.3.1: “The<br>                    repository shall have documented preservation strategies relevant to its<br>                    holdings.” |
| OAIS          | Preservation watch                   | Risk Properties Definition and Extraction is covered by both Monitor Technology and<br>                    Preservation Watch functions. |
| PREMIS        |                                      | /                                                                                                           |

## Reference Implementations

### Use Cases

| Title                                    | Institution             | Documentation                                                                                          | Problem                                                                                                                                                          | Solution                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| :--------------------------------------- | :---------------------- | :----------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Identification of PDF preservation risks | Koninklijke Bibliotheek | https://bitsgalore.org/2023/05/25/identification-of-pdf-preservation-risks-with-verapdf-and-jhove.html | Encryption or password-protection, multimedia content or external<br>                        dependencies can prevent TDAs from making the content of *Files*<br>                        accessible to its end users. File Format Identification and File Format<br>                        Validation are not sufficient to identify these risks, because these<br>                        features are used by only some instances of the file format and because<br>                        encryption and multimedia objects are perfectly valid and standard PDF<br>                        features. | <pre><code>Van der Knijff provides the reader with a method to determine whether a
                        File is using such features, and therefore has to be flagged at risk.</code></pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Multi-page TIFFs                         | Rosetta Users Group     | https://docs.google.com/spreadsheets/d/1tSpS_1rCeVgOI0dEkmRu8cR9VjlLlYj_CnehswD1aM0/edit?gid=0#gid=0   | The preservation software Rosetta has a functionality for providing risk<br>                        reports that help users to monitor risks and identify *Files* or *Representations* that are at risk in order to take batch action on all<br>                        previously ingested Objects. Triggers for such risk reports include:<br>                        Certificate, Encryption, End of life, Non-Standard, Obsolete, Outdated,<br>                        Propriety.<br>                    This spreadsheet was elaborated by the Rosetta Users Group as a risk<br>                        inventory that provides a list of risks and methods for their detection The<br>                        detection can be based on the file format identifier (PUID, in this case) or<br>                        on a file property. | <pre><code>The line titled “TIFF with multiple pages” is a risk property, identified
                        based on technology and community alerts. Multiple tools can detect this
                        risk but JHOVE was preferred as most of the Rosetta implementations use it
                        for both file format validation and metadata extraction of TIFFs. The
                        interpretation of JHOVE’s output being complex, the extraction of the risk
                        property relies on the analysis of several elements in JHOVE’s output. Those
                        are described in column D as a set of conditions resolving to TRUE or FALSE.</code></pre> |
| 4-channel JPEGs                          | KU Leuven               |                                                                                                        | By comparing the *Technical metadata* of the correct and<br>                        misrendered JPEG, it was noticed that the misrendered JPEG had four samples<br>                        per pixel instead of three, as it happens with most RGB images. Since color<br>                        space information was missing, it was first assumed that there was an alpha<br>                        channel added for transparency.<br>                    However, further investigation into the specification and internet<br>                        articles revealed that an alpha channel was highly unlikely. In a next step,<br>                        the TDA therefore downloaded the files and ran more tools against the JPEGs.<br>                        Exiftool listed a Color Transform value of YCCK, which was confirmed by<br>                        checking the file’s APP14 block data.<br>                    Closer visual inspection of the web viewer revealed indeed small<br>                        variations of different shadings of black in places where there was a lot of<br>                        contrast in the original image. This pattern also seemed consistent with a<br>                        YCbCr interpretation of the YCCK data. An investigation of all the JPEG<br>                        files with 4-channel images and all of them turned out to be indeed in the<br>                        YCCK colorspace. | <pre><code>The TDA at KU Leuven decided to convert all JPEG files to YCbCr. However,
                        all employed tools still seem to result in a file with colors slightly
                        different from the originals, leading to on-going discussions with the
                        producer on the conversion process.</code></pre>                                                                                                                                                                                                                                                                                                                                                      |

### Public Documentation

| Institution                                                                        | Link                                                                                                                   | Comment                                                                                                              |
| :--------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------- |
| TIB – Leibniz Information Centre for Science and Technology and University Library | https://wiki.tib.eu/confluence/spaces/lza/pages/93608641/Preservation+Management#PreservationManagement-Riskmanagement |                                                                                                                      |
| CSC – IT Center for Science Ltd.                                                   | https://urn.fi/urn:nbn:fi-fe2023062157386                                                                              | section 2.1                                                                                                          |
| Archivematica                                                                      | https://www.archivematica.org/en/docs/archivematica-1.17/user-manual/transfer/transfer/#transfer-tab-microservices     | Archivematica can provide some of the information needed to support risk assessment as part of its Transfer process. |



---

