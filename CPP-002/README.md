# Checksum Validation

**Short Definition:** The TDA validates checksums against those stored in the Information Package at Ingest or Access.

## Description and Scope
The Checksum Validation process compares the checksums that come with the Information Package, with checksums based on the current state of the File's data. Checksums of Files are validated at Ingest or Access to a TDA. The checksums may be either part of 1) a SIP; 2) an imported AIP; or 3) an AIP stored in the TDA. A misalignment between the checksum algorithms used in the Information Package and the TDA's checksum policy's list of algorithms may occur. For example, incoming Information Packages (SIPs and AIPs) may include a checksum with a different algorithm created by the producer. In the case of AIPs, the checksum policy might have been updated during the lifecycle of the TDA, resulting in the removal and/or addition of algorithms. In such cases, the process should use whatever algorithm is associated with a given checksum to the best of its potential.

## Authors
- Kris Dekeyser

## Contributors
- Johan Kylander

## Evaluators
- Felix Burger
- Maria Benauer
- Laura Molloy

## Process Steps

### Step 1
Get the list of pre-calculated checksums with their respective algorithms

**Inputs:**
- Fixity information
- Fixity information from SIP

**Outputs:**
- List of checksums and algorithms

### Step 2
Evaluate for each algorithm individually if it is supported by the system.

**Inputs:**
- List of checksums and algorithms
- Digital archive system configuration

**Outputs:**
- Algorithm supported (step 3)
- Algorithm not supported: examine further procedure (e.g. based on legal agreements; submission policies; communication with producer, if possible) Process completed

### Step 3
For each algorithm, recalculate the checksum of the File and match it with the given checksum

**Inputs:**
- File
- List of checksums and algorithms

**Outputs:**
- All File checksums match (step 5)
- Alert that any of the File checksums does not match: Examine further procedure Process completed

### Step 5
Document the event and its timestamp

**Inputs:**
- All File checksums match

**Outputs:**
- Datetime for the checksum generation in the Provenance metadata

