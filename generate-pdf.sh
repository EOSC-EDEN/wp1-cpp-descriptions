#!/bin/env bash
# Generates a PDF next to each CPP-xxx/cpp-xxx.xml file, using cpp2fo.xsl (XSL-FO) and Apache FOP.
# Requires: xsltproc, xmllint, fop (e.g. `sudo apt-get install fop`).
set -e
FILES="CPP-*/cpp-*.xml"
if [ "$1" ]; then
    FILES="$1"
fi

for file in $FILES; do
    dir="$(dirname "$file")"
    target="${dir}/$(basename "$file" .xml).pdf"
    fo="$(mktemp --suffix=.fo)"
    fo="${dir}/$(basename "$file" .xml).fo"
    echo "Processing $file -> $target..."
    # fop -xml "$file" -xsl "cpp2fo.xsl" -c ".fop/fop.xml" -pdf "$target"
    xsltproc cpp2fo.xsl "$file" > "$fo"
    fop -fo "$fo" -pdf "$target"
    # rm -f "$fo"
done
