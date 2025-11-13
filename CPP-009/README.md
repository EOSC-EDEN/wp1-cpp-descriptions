# Metadata Extraction

**Short Definition:** The TDA extracts characteristics (such as size, image dimensions, video codec, audio run time, creating application).

## Description and Scope
Metadata extraction is the process of analysing a File or a set of Files (i.e. a PREMIS Representation) by means of metadata extractor tools in order to retrieve its characteristics in an automated way. In the digital preservation community, this operation is sometimes referred to as “Characterisation”. Within EDEN, however, characterisation is used to identify all operations aiming to extract properties from digital Files (CPP-008 File Format Identification, CPP-009 Metadata Extraction, and CPP-010 File Format Validation).

Metadata Extraction is generally performed at a File level; in some cases it has to be applied to a complex file structure that is not wrapped in a container File. For example, moving images stored as a sequence of DPX Files are handled as a whole by the metadata extractor tool MediaInfo.

File properties as gathered through Metadata Extraction are generally considered “Technical metadata”. However, by parsing the File, the process also extracts a wide range of its internal Descriptive, Provenance and Rights metadata.

Knowledge of these characteristics is a key requirement for many subsequent operations. In particular, it is essential for CPPs producing new Representations (i.e. CPP-026 File Normalisation, CPP-027 File Repair, CPP-014 Format Migration, and CPP-028 Creation of Derivatives) as they require further Metadata beyond the file format information as provided by CPP-008. Audiovisual Files are the most obvious example: Most identification tools provide information about the only container format, while any of the operations mentioned above will need at least the video and audio stream format. This is equally true for all other data types: TIFF may contain image streams compressed by different algorithms, PDF 1.7 might be portfolios containing arbitrary Files, etc.

There are different types of extraction tools available: a) Generalist metadata extractor tools which are able to perform metadata extraction on a great variety of file formats of different content types (e.g. [Exiftool](https://exiftool.org/)), b) content-specific tools which cover most of the file formats for a specific content type (e.g. [MediaInfo](https://mediaarea.net/fr/MediaInfo) for AV Files), c) format-specific tools which are specialised on a particular format (e.g. [EPUBcheck](https://www.w3.org/publishing/epubcheck/) for EPUBs, [metaflac](https://xiph.org/flac/documentation_tools_metaflac.html) for FLAC Files, etc.). Metadata extraction therefore relies on a format identification and is performed differently depending on the file format. TDAs might decide to apply several metadata extractor tools if a single tool cannot extract all required properties.

Metadata extraction - like any parsing operation - can fail and result in diagnostic error messages. These errors require systematic analysis to inform troubleshooting. In particular, the following issues may be detected by Metadata extraction errors: * Encrypted Files; * Truncated or broken Files * Files assigned incorrect file format information.

The output of the metadata extractor tools should be recorded in the Information Package, as Technical, Descriptive, Rights or Provenance Metadata. It may be recorded directly as-is, or mapped to a metadata standard according to the TDA policy on metadata recording.

## Authors
- Bertrand Caron

## Contributors
- Juha Lehtonen

## Evaluators
- Matthew Addis
- Maria Benauer
- Fen Zhang

## Process Definition

**Inputs:**
- File or, in some specific cases, Representation
- Policies and detection methods for significant properties, risk properties and quality properties
- Metadata recording Policy

**Outputs:**
- Technical Metadata
- Provenance metadata
- Descriptive Metadata
- Structural Metadata
- Rights Metadata
- Errors and Warnings

**Trigger Events:**
- Ingest (see `CPP-029`)
- Re-run of metadata extraction because of the release of a new metadata extractor tool or tool version
- Verify the output of processes creating new Files or Representations (see `CPP-014`)

## Process Steps

| Step | Inputs                                                                                                                          | Description                                                                                                                                                                                                          | Outputs                                                                                                                                              |
| :--- | :------------------------------------------------------------------------------------------------------------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1    | - Format identifier<br>- Significant properties policy and detection method<br>- Risk properties policy and detection method<br>- Quality properties policy and detection method | Select a suitable metadata extractor tool for the File(s), depending on its format identifier and on requirements from Significant Properties Definition, Data Quality Assessment and Risk Definition and Extraction | - Metadata extractor tool<br>                        <br><br>If relevant: configure the tool settings - syntax (XML, JSON, CSV, etc.), format (e.g., EBUCore, PBCore, in case of an AV File) and verbosity level. |
| 2    | - *File*<br>- [Metadata extractor tool](https://coptr.digipres.org/index.php/Metadata_Extraction) configured according to selected settings | Applying one or sometimes several metadata extractor tool(s).                                                                                                                                                        | - Tool(s) output<br>- Errors and warnings                                                                                                            |
| 3    | - Errors and warnings                                                                                                           | Analyse the errors and troubleshoot, e.g., by removing encryption                                                                                                                                                    |                                                                                                                                                      |
| 4    | - Tool(s) output<br>- Policy on metadata recording                                                                              | Map the extractor tool(s) output to metadata standard(s)<br>                    <br><br>The output of the extractor tool may be recorded as-is in the Information package, or may be mapped into a technical metadata standard (e.g., MIX for still images). | - Tool output in standard format(s)                                                                                                                  |
| 5    | - Tool output in a standard format                                                                                              | Recording the results in the Information Package (i.e. in practice, in the digital archive database and/or in the physical Information Package)                                                                      | - Technical metadata, optionally other types of metadata, recorded in the Information Package                                                        |
| 6    |                                                                                                                                 | Document the event and its datetime                                                                                                                                                                                  | - Provenance metadata                                                                                                                                |

## Rationale / Worst Case

| Purpose                                                                                                                                                                                                                                                                         | Worst Case                                                                                                                                        |
| :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------ |
| All preservation actions beyond bit-level preservation are based on a comprehensive understanding of the File’s characteristics.                                                                                                                                                | Files of poor quality may be unidentified.<br>                <br><br>Derivatives may be unadapted to the end users’ needs.<br>                <br><br>The result of a migration may be partial, as some parts of the source File may not have been identified, thus not been copied to the target File. |
| Metadata extraction involves accessing the contents of the File. Hence it is an essential means to detect problematic Files (including errors like: corrupted, non-conformant to format specification, encrypted or password protected, wrong file format identification etc.). | Problematic Files are not detected.                                                                                                               |

## Relationships

| Type               | Related CPP | Description                                                                                                                                                                                                                                                                                                        |
| :----------------- | :---------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Required by        | CPP-002     | CPP-002 relies on fixity information as produced and stored by CPP-001, when triggered by CPP-025 Enabling Access and CPP-006 AIP Batch Export. When triggered by CPP-029 Ingest CPP-002 rather relies on the fixity information supplied in the SIP.                                                              |
| Required by        | CPP-008     | The selection of an appropriate extractor tool depends on file format information.                                                                                                                                                                                                                                 |
| Required by        | CPP-019     | The selection of an appropriate extractor tool depends on requirements from the Data Quality Assessment CPP.                                                                                                                                                                                                       |
| Required by        | CPP-022     | The selection of an appropriate extractor tool depends on requirements from the Significant Properties Definition CPP.                                                                                                                                                                                             |
| Required by        | CPP-023     | The selection of an appropriate extractor tool depends on requirements from the Risk Definition and Extraction CPP.                                                                                                                                                                                                |
| Required by        | CPP-012     | Preservation actions (i.e. migration, emulation) in the storage depend on the identification of Files that share the same properties.                                                                                                                                                                              |
| Required by        | CPP-014     | File format identification is generally limited to an indication of the container format, while migration can apply to any property of the Files. Technical metadata extraction is required to both assess the compliance of files format to the Archive’s format policy and control the outcome of the migration. |
| Required by        | CPP-016     | Any metadata that was extracted from the File needs to be stored, searchable and retrievable                                                                                                                                                                                                                       |
| Required by        | CPP-019     | Metadata extraction returns Metadata that are used to assess the File quality (e.g. for an audiovisual File quality assessment may rely on Metadata such as bit depth, sampling frequency, etc.).                                                                                                                  |
| Required by        | CPP-023     | Metadata extraction returns Metadata that are used to identify preservation threats (e.g. for a PDF, the presence of an open password).                                                                                                                                                                            |
| Required by        | CPP-024     | Some Metadata provided to the consumer must have been extracted from the Files.                                                                                                                                                                                                                                    |
| Required by        | CPP-029     | Metadata extraction is one of the core processes that must be performed as part of Ingest.                                                                                                                                                                                                                         |
| May be required by | CPP-010     | Depending on the precision of the format registry used in the format identification process, the resulting information may be insufficient for selecting the right validation tool.<br>                <br><br>In such cases, additional Metadata from an extraction tool may be required. For example, if an organisation uses Unix File as its identification tool, which does not distinguish between different PDF “flavours”, and wants to validate PDF/A against the PDF/A standard.<br>                <br><br>In that case, metadata extraction will be necessary to identify the conformance level and select veraPDF as the suitable validation tool |
| May be required by | CPP-021     | The documented event, datetime, and Provenance metadata from the metadata extraction may be required by AIP Versioning.                                                                                                                                                                                            |
| May be required by | CPP-027     | Tools extracting properties of the File or Representation are useful (and sometimes even necessary) for identifying erroneous format structures.                                                                                                                                                                   |
| Affected by        | CPP-018     | Either due to changing significant properties or due to updated tools, metadata extraction requirements can be affected.                                                                                                                                                                                           |

## Framework Mappings

- **CoreTrustSeal**
  - **Term:** Quality control checks
  - **Section:** Section R10 (Quality assurance) implicitly requires metadata extraction as one of
                        the processes implementing “quality control checks in place [that] ensure the
                        completeness and understandability of data and metadata”.
- **Nestor Seal**
  - **Term:** Technical metadata collect[ion]
  - **Section:** C30 Technical metadata
- **ISO 16363**
  - **Section:** /
- **OAIS**
  - **Section:** /
- **PREMIS**
  - **Term:** Metadata extraction
  - **Section:** The PREMIS Data Dictionary mentions this operation as “characterization” ([p.
                        249,
                            section Special Topics / Format information](https://www.loc.gov/standards/premis/v3/premis-3-0-final.pdf#page=259)), but the event type
                        vocabulary maintained by the PREMIS Editorial Committee at [id.loc.gov](http://id.loc.gov) uses the term [“metadata
                        extraction”](https://id.loc.gov/vocabulary/preservation/eventType/mee.html).

## Reference Implementations

### Use Cases
- **Metadata Extraction from AV material**
  - **Institution:** Bibliothèque nationale de France
  - **Problem:** Discussion with AV experts required that several quality properties be extracted, in particular properties related to the [group of pictures](https://en.wikipedia.org/wiki/Group_of_pictures) .
                    

XML was the preferred syntax for the extractor tool output, as it could be easily wrapped in METS Files.
  - **Solution:**
```python
BnF has selected the tool MediaInfo as its extractor tool for AV Files, according to requirements collected by BnF. MPEG-7, one of its output formats, being standardised and expressed in XML, was selected as the format for Metadata to be stored in Archival Information Packages. As MediaInfo provides natively MPEG-7 as one of its output formats, no mapping from the tool output to a standard metadata format was required.
```

### Public Documentation
- **TIB – Leibniz Information Centre for Science and Technology and University Library**
  - **Link:** https://wiki.tib.eu/confluence/spaces/lza/pages/93608618/Ingest
- **CSC – IT Center for Science Ltd.**
  - **Link:** https://urn.fi/urn:nbn:fi-fe2020100578096
  - **Comment:** section 5
- **Archivematica**
  - **Link:** https://www.archivematica.org/en/docs/archivematica-1.17/user-manual/preservation/preservation-planning/#characterization



---

