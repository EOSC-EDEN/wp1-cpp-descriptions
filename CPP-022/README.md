# Significant Properties Definition

**Short Definition:** The TDA defines significant properties for sets of Information Objects (i.e., properties that it commits to preserve over the long term through preservation actions and rendition).

## Description and Scope
Significant properties is a widely-adopted concept in the analog and digital preservation sectors that can be defined as *“essential characteristics of a digital object which must be preserved over time for the digital object to remain accessible and meaningful”* (definition taken from the [Digital Preservation Coalition, British Library, and JISC joint workshop, “What to preserve? Significant Properties of Digital Objects”](https://web.archive.org/web/20100504081357/http://www.dpconline.org/events/significant-properties.html)). It acknowledges that digital *Object*s - just like analog Objects - are subject to intentional or unintentional changes and that memory organisations should identify which of their properties are significant, and should therefore be preserved by committing efforts and means. For a more in-depth presentation of the concept of significant properties, see Montague, Lynne, and Eleonora Nicchiarelli. “The Concept of Significant Properties.” The National Archives, Österreichischen Nationalbibliothek, May 26, 2010. Available at <https://www.planets-project.eu/docs/reports/Planets_PC3-D23A_TheConceptOfSignificantProperties.pdf> .

Significant properties are declared for a certain *Object* type, although this categorisation will vary. For example, one organisation can declare significant properties for all its still images, while another will specify different significant properties for digital photographs, graphic design works and screenshots. Significant properties are generally classified into five top-level categories:

* *Content*: the main signal(s) conveyed by the *Object* (e.g. textual, visual, audiovisual, etc.); * *Context*: the information documenting the circumstances of creation and history of the *Object*; * *Appearance*: the visual aspects of the *Object* (e.g. fonts, layouts, colours, etc.); * *Structure*: the organisation of the content (e.g. pages, sections, ordering, etc.); * *Behaviour*: all features beyond simple displaying (e.g. links, actions, navigation, etc.)

In addition to these categories, significant properties may be qualified by the possibility to be determined in an automated way, or only by manual observation. Significant properties that can be determined in an automated way are called “extractable”. For example, the visual aspect of source and target PDFs can be easily compared by means of tools like [diffpdf](https://mark-summerfield.github.io/diffpdf.html). On the other hand, those significant properties that only a human action can assess are called “observational”. The step-by-step description below focuses on extractable properties. In cases where observational properties are considered significant by the TDA, it must define a manual determination method that is incorporated in its processes.

Guidance can be provided to memory organisations on which properties of certain *Object*s are generally considered significant, but the final decision of adopting these or not is still the responsibility of the TDA. Thus, the definition of significant properties is an institutional policy. Significant properties might even vary within the same organisation from one project to another. For example, the history of changes recorded as XMP internal *Metadata* in field xmpMM:History may be considered crucial for born-digital digital photographs, but negligible for album thumbnails.

The significant properties policy should be produced or at least confirmed by the TDA management, since it will influence the usability that the *Object*s will support. For this reason, significant properties are likely to be more high-level, organisational properties that will need to be mapped to technical extractable properties. For example, for a significant property “audio signal quality”, the technical properties associated will be sampling frequency, bit depth, etc. These properties might change (e.g. if a conversion from audio signal in DSD64 1 bit / 2.8224 MHz is made to PCM 24 bits / 96kHz) but their evolution should be controlled to ensure the audio signal quality is preserved.

In some cases, significant properties will be dictated by stakeholders (e.g. Producer, Consumer, etc.) - see the use case “Page Layout as Significant Property of Reflowable EPUBs” below. **Community Watch** (CPP-018) must therefore ensure that its significant properties policy is aligned with the needs of its designated community.

## Authors
- Bertrand Caron

## Contributors
- Kris Dekeyser

## Evaluators
- Felix Burger
- Maria Benauer
- Franziska Schwab

## Process Definition

### Inputs

| Type     | Input                                              |
| :------- | :------------------------------------------------- |
| Guidance | Significant properties policy from equivalent TDAs |
| Guidance | Community and stakeholders needs                   |

### Outputs

| Type     | Output                                                |
| :------- | :---------------------------------------------------- |
| Guidance | Significant properties policy for a given Object type |
| Guidance | Significant properties detection method               |

### Trigger Events

| Description                                              | Corresponding CPP |
| :------------------------------------------------------- | :---------------- |
| A new *Object* type is planned to be ingested by the TDA |                   |

## Process Steps

| Step | Supplier(s) | Input(s)                                        | Description                                                            | Output(s)                                                                         | Customer(s) |
| :--- | :---------- | :---------------------------------------------- | :--------------------------------------------------------------------- | :-------------------------------------------------------------------------------- | :---------- |
| 1    | `CPP-018`   | - Community needs                               | Study Community needs and derive required *Object* property            | - Organisational high-level property                                              |             |
| 2    |             | - Organisational high-level property            | Map the organisational high-level property to one or several concrete<br>                            extractable property(ies) | - Associated concrete extractable property(ies)                                   |             |
| 3    |             |                                                 | Gather a test set of a given *Object* type                             | - Test set                                                                        |             |
| 4    |             | - Associated concrete extractable property(ies) | Select a tool capable of extracting the concrete property(ies)         | - Extractor tool                                                                  |             |
| 5    |             | - Test set<br>- Candidate extractor tool        | Run the candidate extractor tool on the test set                       | - Candidate extractor tool output                                                 |             |
| 6    |             | - Candidate extractor tool output               | Determine whether the significant property is identifiable in the<br>                            candidate extractor tool output | - Significant properties detection method confirmed: extractor tool<br>                                chosen (step 7)<br>- No detection method confirmed (resume steps 4-6) |             |
| 7    |             | - Chosen extractor tool output                  | Determine the interpretation of the extractor tool output (path to the<br>                            property, error tolerance, etc.) | - Significant properties detection method: path or expression to<br>                                extract<br>                                the significant properties from the tool’s output | `CPP-009`   |

## Rationale / Worst Case

| Purpose                                                                                        | Worst Case                                                                                          |
| :--------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------- |
| If the TDA aims to do semantic / logical preservation, give access to its<br>                    holdings to end users and create copies out of the original *Object*s,<br>                    defining the significant properties of its *Object*s to be able to assess<br>                    the success or failure of all preservation and access actions is required. | Without a significant properties policy and methods to detect that they are<br>                    maintained in any modified preservation or derivative copy, the TDA may produce<br>                    unnoticed faulty copies or render the *Object*s incorrectly. |

## Relationships

| Type          | Related CPP | Description                                                                                                                                                                |
| :------------ | :---------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Requires      | CPP-018     | The Significant Properties Definition is fundamental to ensure that<br>                    information and features supported by the *Object*s are those that the<br>                    TDA’s designated community is expecting. |
| Affinity with | CPP-019     | As Data Quality Assessment identifies quality properties whose value will<br>                    determine whether the *Object*s are ingested or not, these quality<br>                    properties will likely be also considered significant by the TDA. |
| Affinity with | CPP-016     | A TDA defines significant properties for digital *Object*s. These are<br>                    then translated to Technical metadata that is ingested. The significant<br>                    properties definition process also influences which Technical metadata standards<br>                    are applied. |
| Required by   | CPP-013     | To report on the characteristics of *Object*s for deeper analysis, the<br>                    significant properties must have been defined in the first place.            |
| Required by   | CPP-014     | File Migration implies the production of a *Representation* supposed to<br>                    act as a preservation copy and must rely on significant properties to determine<br>                    its success or failure. |
| Required by   | CPP-015     | Rendering should be evaluated based on significant properties. The faulty<br>                    rendering of an *Object* because of unsuitable hardware or software may<br>                    go unnoticed and produce wrong interpretations from the TDA’s community. |
| Required by   | CPP-026     | Like Format migration, Normalisation should be evaluated based on significant<br>                    propertie                                                             |
| Required by   | CPP-027     | Modifying the *File*’s *Bitstream* in order to correct faulty<br>                    structures can cause unexpected changes to the rendering and behaviour of an *Object*. Thus, file repair should also be evaluated based on significant<br>                    properties. |
| Required by   | CPP-028     | Although derivatives may not be subject to the same requirements as<br>                    preservation *Representation*s, a TDA might consider providing access<br>                    through copies that do not convey significant properties as a failure. |

## Framework Mappings

| Framework     | Term                                                       | Section                                                                                              |
| :------------ | :--------------------------------------------------------- | :--------------------------------------------------------------------------------------------------- |
| CoreTrustSeal | Compar[ing] the essential properties<br>                Storage and Integrity | R07 Provenance and Authenticity                                                                      |
| Nestor Seal   | Identification and documentation of significant properties | C13 Significant properties                                                                           |
| ISO 16363     | Identification of transformational information properties  | 4.1.1 “The repository shall identify the Content Information and associated<br>                    Preservation Objectives and the Transformational Information Properties that the<br>                    repository will preserve.” |
| OAIS          | Transformational information properties                    | 5.2.4.5 “Transformation” and 5.3.4.2 Preservation of Access and Use Services                         |
| PREMIS        | Significant properties                                     | *significantProperties* semantic unit p. 50                                                          |

## Reference Implementations

### Use Cases

| Title                                                   | Institution                                        | Documentation | Problem                                                                                            | Solution                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| :------------------------------------------------------ | :------------------------------------------------- | :------------ | :------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Page Layout as Significant Property of Reflowable EPUBs | Ebooks publishers / digital books service provider |               | In 2009-2010, French publishers were implementing workflows to produce<br>                        digital books. Initially, they were concerned by the users’ ability to<br>                        change the digital books’ visual aspect and page layout. They were tempted<br>                        to use exclusively the EPUB 3 fixed-layout format to prevent users from<br>                        doing so. | <pre><code>An EPUB production service provider had to convince publishers of the
                        benefits of reflowable EPUBs. The publishers had to accept that reflowable
                        ebooks' visual aspect and page layout were not significant.
                    In this example, a stakeholder - a service provider, followed by an
                        industry sector - determined explicitly that a property of a specific *Object* (digital books in reflowable EPUB format) should not be
                        considered significant. TDAs should then acknowledge this and make no
                        attempt at preserving this property.</code></pre> |

### Public Documentation

| Institution                                                                        | Link                                                                                                          | Comment                       |
| :--------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------ | :---------------------------- |
| TIB – Leibniz Information Centre for Science and Technology and University Library | https://wiki.tib.eu/confluence/spaces/lza/pages/93608961/Significant+Properties                               |                               |
| CSC – IT Center for Science Ltd.                                                   | https://urn.fi/urn:nbn:fi-fe2025040925236                                                                     | section 6.2.1                 |
| Bibliothèque nationale de France                                                   | https://bnf.hal.science/hal-03374030v2                                                                        | sections titled “Propriétés…” |
| National Archives and Records Administration                                       | https://github.com/usnationalarchives/digital-preservation/tree/master/Digital_Preservation_Record_Categories |                               |



---

