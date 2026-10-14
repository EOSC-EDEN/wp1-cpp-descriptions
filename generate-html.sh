#!/bin/env bash
FILES="CPP-*/cpp-*.xml"
if [ "$1" ]; then
    FILES="$1"
fi

for file in $FILES; do
    name="$(basename "${file%.*}")"
    target="docs/${name}.html"
    echo "Processing $file -> $target..."
    xsltproc cpp2html.xsl "$file" > "$target"
done
