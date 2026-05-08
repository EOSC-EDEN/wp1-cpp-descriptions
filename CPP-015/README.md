# Emulation and Rendering Tools

**Short Definition:** The TDA enables the rendering of Objects via the application of emulation and/or other specialist tools.

## Description and Scope
Digital preservation is all about ensuring long-term access to digital content despite the challenges of obsolescence, degradation, and technological change. Emulation and Rendering tools are important strategies in achieving that goal, and together with *File* migration ensure that digital content remains usable to the *Designated Community*.

Emulation attempts to recreate the original habitat - both hardware and software - of the digital *Object* in order to interact with it in the way it was intended. This is achieved by preserving both the content and the experience of the original environment. The purpose of emulation is to simulate the original operating system and the tools that are needed to interact with the *Object*.

Rendering tools interpret and display the digital *Objects* in the current environment using viewers based on modern technology. It is not uncommon for rendering tools to convert the digital *Object* into a more accessible form before displaying it. In such cases, viewers and converters collaborate to achieve the required result.

In addition to maintaining the *Bitstream* integrity of its holdings, semantic digital preservation entails ensuring their continued readability and usability. This necessitates that the TDA identifies the required environments and tools to support the actions its *Designated Community* is authorised to perform, regardless of whether direct access to the holdings is currently being provided.

Emulation and Rendering are two very different techniques to achieve a similar goal. They differ in some essential aspects: * *Authenticity*: Emulation aims for the best authenticity by reproducing the entire look and feel of the original environment. The output of the rendering process may do a pretty decent job in reproducing the original *Representation* of the *Object*, but the interaction will be simulated at best. The rendering’s conversion operation can be lossy and generate a less accurate result. Rendering is also more vulnerable to slight format changes and thus requires Format Validation. * *User Experience*: Again, Emulation obtains the highest score as it will reinstate the original hard- and software as good as possible and allows the user to interact with the *Object* to its full potential. Rendering will typically reduce the experience to a read-only view of the data with a limited set of operations available. * *Preservation Scope*: In order to render the *Object*, only the content needs to be preserved. For emulation, however, both content and its environment need to be preserved. * *Technical Overhead*: The requirements for Emulation are very high. A lot of resources (e.g. CPU and memory) are required to fire up the emulation. Moreover, the configuration and maintenance of an emulation environment is complex and time consuming. Performance may suffer and emulation does not scale easily. Rendering on the other hand, is relatively simple to set up, especially when no conversion is required or the conversion is done beforehand. Performance is mostly great, unless the *Object* is stored in slow off-line storage. The technique causes little problems for scaling. * *Licensing*: Licensing of the operating system and software interacting with the *Object* may be a concern for emulation. For rendering of most common file formats, open source libraries and tools are available and licensing is less of a concern.

The choice for emulation versus rendering is captured in the Emulation and Rendering Policy. There are many possible decision factors and strategies for choosing emulation over rendering. For example: * Manual configuration by archive maintainer; * Requested by consumer; * Decision based on format; * Decision based on *Technical metadata*; * Decision based on collection preferences, policies, agreements with producer, etc.

## Authors
- Kris Dekeyser

## Contributors
- Bertrand Caron
- Johan Kylander

## Evaluators
- Felix Burer
- Maria Benauer

## Process Definition

### Inputs

| Type     | Input                          |
| :------- | :----------------------------- |
| Data     | Representation                 |
| Guidance | Emulation and rendering policy |

### Trigger Events

| Description                          | Corresponding CPP |
| :----------------------------------- | :---------------- |
| Access requested to a given *Object* | `CPP-025`         |

## Process Steps

| Step | Supplier(s) | Input(s)                               | Description                                                                         | Output(s)                              | Customer(s) |
| :--- | :---------- | :------------------------------------- | :---------------------------------------------------------------------------------- | :------------------------------------- | :---------- |
| 1    | `CPP-025`   | - *Representation* identifier          | Collect *the Object's* *Representation*                                             | - *Representation*<br>                *Technical metadata* |             |
| 2    |             | - *Representation*<br>- *Technical metadata* | Collect the Environment *Objects* associated with the *Representation* (if present) | - Environment *Objects*                |             |
| 3    | `CPP-012`   | - *Representation*<br>- *Technical metadata*<br>- Environment *Object*<br>- Emulation and rendering policy | Decide on strategy                                                                  | - Emulation (proceed to "Emulation")<br>- Rendering (proceed to "Rendering") |             |
| E1   |             | - Environment *Object*                 | Retrieve the emulation properties from the Environment:<br>                <br>•  Hardware to be emulated<br>                  <br>•  Operation System type and version<br>                  <br>•  Tools to be installed in the OS | - Emulation information                |             |
| E2   |             | - Emulation information                | Prepare Emulation environment:<br>                <br>•  initialise the virtual machine based on operating system requirement<br>                  <br>•  install the software requirements | - Initialised emulated environment     |             |
| E3   |             | - Emulated environment<br>- *Representation* information | Inject or copy the *Representation* content in the emulated environment             | - Complete emulated environment        |             |
| E4   |             | - Complete emulated environment        | Start the emulated environment and redirect input and output to the consumer        |                                        |             |
| R1   | `CPP-025`   | - *Representation* identifier          | Get the *Object*'s *representation*                                                 | - *Representation*<br>                  *Technical metadata* |             |
| R2   |             | - *Representation*<br>                  *Technical metadata* | Retrieve the *Representation* content                                               | - *Representation* content             |             |
| R3   | `CPP-012`   | - *Representation* Information<br>- Emulation and rendering policy | Make a choice of rendering tool                                                     | - Rendering tool                       |             |
| R4   |             | - *Representation* content<br>- Rendering tool | Execute the Rendering tool and hand over the *Representation*<br>                  content |                                        |             |

## Rationale / Worst Case

| Purpose                                                            | Worst Case |
| :----------------------------------------------------------------- | :--------- |
| It is good practice to provide the tools to let the consumer<br>                interact with the data (Except in the case of dark<br>                archives). |            |

## Relationships

| Type           | Related CPP | Description                                                                        |
| :------------- | :---------- | :--------------------------------------------------------------------------------- |
| Requires       | CPP-025     | The access request is the trigger to invoke the rendering process<br>                or start up the emulated environment. |
| Requires       | CPP-010     | In order to have a decent level of confidence in the rendering <br>                process, the *File*’s format needs to be validated. |
| Requires       | CPP-012     | Risk Mitigation is in charge of defining the emulation and<br>                rendering policy that is meant to be applied by this CPP. |
| Requires       | CPP-022     | Rendering should be evaluated based on significant properties.<br>                The faulty rendering of an *Object* because of unsuitable hardware<br>                or software may go unnoticed and produce wrong interpretations<br>                from the TDA’s community. |
| Required by    | CPP-013     | The process of selecting tools for emulation and rendering<br>                provides data to the TDA for reporting to the designated<br>                communities. |
| Facilitated by | CPP-014     | May be needed to support rendering tools in the long term.                         |
| Facilitated by | CPP-026     | Normalisation of the file formats can reduce the effort and<br>                complexity for rendering and emulation significantly. |
| Facilitated by | CPP-028     | Derivatives in formats and/or structures that are easier to render<br>                can be created prior to the rendering process to avoid time and<br>                resource consuming conversion processes. |

## Framework Mappings

| Framework     | Term                                           | Section                                                                         |
| :------------ | :--------------------------------------------- | :------------------------------------------------------------------------------ |
| CoreTrustSeal | Preservation Plan                              | R09 - Preservation Plan refers to emulation as a possible<br>                preservation strategy |
| Nestor Seal   | Emulation strategy                             | C24 Interpretability of the archival information                                |
| ISO 16363     | /                                              | In scope of 3.3.1 “The repository shall have defined its<br>                Designated Community and associated knowledge base(s) and shall<br>                have these definitions appropriately accessible.” |
| OAIS          | Representation Information<br>        Rendering Software and Access Software | 4.3.2.3.3 Representation Information Networks                                   |
| PREMIS        | Emulation<br>        Render                    | Emulation is mentioned several times w.r.t. PreservationLevel and<br>                Environment Objects. Rendering is mentioned in sections<br>                discussing Representations, Relations and Environment objects.<br>                Both processes are also described in the glossary. |

## Reference Implementations

### Use Cases

| Title                                      | Institution                      | Documentation | Problem                                                                            | Solution                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| :----------------------------------------- | :------------------------------- | :------------ | :--------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Rendering images with ICC profile embedded | Bibliothèque nationale de France |               | The diversity of born-digital images collected by BnF requires<br>                rendering software aware of its complexity. The rendering tool<br>                should be able to handle several file formats, different colour<br>                models, and many other more or less common characteristics of<br>                image *Files*: multi-image TIFFs, orientation indicated by an EXIF<br>                tag, etc. In particular, it should use the embedded ICC profile<br>                to enable proper colour management. | <pre><code>BnF selected the XnView freeware as its solution for displaying
                images to its *Designated Community*. Though the software was
                natively supporting embedded ICC profiles, the setting was not
                activated by default, which illustrates the importance of
                adjusting the tool settings to ensure faithful rendering of
                digital *Objects*.</code></pre> |

### Public Documentation

| Institution                                                                        | Link                                                                                                              | Comment   |
| :--------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------- | :-------- |
| TIB – Leibniz Information Centre for Science and Technology and University Library | https://wiki.tib.eu/confluence/spaces/lza/pages/93608641/Preservation+Management#PreservationManagement-Emulation |           |
| CSC – IT Center for Science Ltd.                                                   | https://urn.fi/urn:nbn:fi-fe2025040925236                                                                         | section 8 |



---

