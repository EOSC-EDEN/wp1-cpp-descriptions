# Metadata Extraction

**Short Definition:** The TDA extracts characteristics (such as size, image dimensions, video codec, audio run time, creating application).

## Description and Scope
Metadata extraction is the process of analysing a File or a set of Files (i.e. a PREMIS Representation) by means of metadata extractor tools in order to retrieve its characteristics in an automated way. In the digital preservation community, this operation is sometimes referred to as “Characterisation”. Within EDEN, however, characterisation is used to identify all operations aiming to extract properties from digital Files (CPP-008 File Format Identification, CPP-009 Metadata Extraction, and CPP-010 File Format Validation). Metadata Extraction is generally performed at a File level; in some cases it has to be applied to a complex file structure that is not wrapped in a container File. For example, moving images stored as a sequence of DPX Files are handled as a whole by the metadata extractor tool MediaInfo. File properties as gathered through Metadata Extraction are generally considered “Technical metadata”. However, by parsing the File, the process also extracts a wide range of its internal Descriptive, Provenance and Rights metadata. Knowledge of these characteristics is a key requirement for many subsequent operations. In particular, it is essential for CPPs producing new Representations (i.e. CPP-026 File Normalisation, CPP-027 File Repair, CPP-014 Format Migration, and CPP-028 Creation of Derivatives) as they require further Metadata beyond the file format information as provided by CPP-008. Audiovisual Files are the most obvious example: Most identification tools provide information about the only container format, while any of the operations mentioned above will need at least the video and audio stream format. This is equally true for all other data types: TIFF may contain image streams compressed by different algorithms, PDF 1.7 might be portfolios containing arbitrary Files, etc. There are different types of extraction tools available: a) Generalist metadata extractor tools which are able to perform metadata extraction on a great variety of file formats of different content types (e.g. Exiftool), b) content-specific tools which cover most of the file formats for a specific content type (e.g. MediaInfo for AV Files), c) format-specific tools which are specialised on a particular format (e.g. EPUBcheck for EPUBs, metaflac for FLAC Files, etc.). Metadata extraction therefore relies on a format identification and is performed differently depending on the file format. TDAs might decide to apply several metadata extractor tools if a single tool cannot extract all required properties. Metadata extraction - like any parsing operation - can fail and result in diagnostic error messages. These errors require systematic analysis to inform troubleshooting. In particular, the following issues may be detected by Metadata extraction errors: Encrypted Files; Truncated or broken Files Files assigned incorrect file format information. The output of the metadata extractor tools should be recorded in the Information Package, as Technical, Descriptive, Rights or Provenance Metadata. It may be recorded directly as-is, or mapped to a metadata standard according to the TDA policy on metadata recording.

## Authors
- Bertrand Caron

## Contributors
- Juha Lehtonen

## Evaluators
- Matthew Addis
- Maria Benauer
- Fen Zhang

## Process Steps

### Step 1
Select a suitable metadata extractor tool for the File(s), depending on its format identifier and on requirements from Significant Properties Definition, Data Quality Assessment and Risk Definition and Extraction

**Inputs:**
- Format identifier
- Significant properties policy and detection method
- Risk properties policy and detection method
- Quality properties policy and detection method

**Outputs:**
- Metadata extractor tool If relevant: configure the tool settings - syntax (XML, JSON, CSV, etc.), format (e.g., EBUCore, PBCore, in case of an AV File) and verbosity level.

### Step 2
Applying one or sometimes several metadata extractor tool(s).

**Inputs:**
- File
- Metadata extractor tool configured according to selected settings

**Outputs:**
- Tool(s) output
- Errors and warnings

### Step 3
Analyse the errors and troubleshoot, e.g., by removing encryption

**Inputs:**
- Errors and warnings

### Step 4
Map the extractor tool(s) output to metadata standard(s) The output of the extractor tool may be recorded as-is in the Information package, or may be mapped into a technical metadata standard (e.g., MIX for still images).

**Inputs:**
- Tool(s) output
- Policy on metadata recording

**Outputs:**
- Tool output in standard format(s)

### Step 5
Recording the results in the Information Package (i.e. in practice, in the digital archive database and/or in the physical Information Package)

**Inputs:**
- Tool output in a standard format

**Outputs:**
- Technical metadata, optionally other types of metadata, recorded in the Information Package

### Step 6
Document the event and its datetime

**Outputs:**
- Provenance metadata

