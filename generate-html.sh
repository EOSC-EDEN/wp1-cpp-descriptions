#!/bin/env bash
for file in CPP-*/cpp-*.xml; do
    name="$(basename "${file%.*}")"
    target="docs/${name}.html"
    echo "Processing $file -> $target..."
    xsltproc cpp2html.xsl "$file" > "$target"
done