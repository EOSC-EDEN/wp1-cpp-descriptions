#!/bin/env bash
for file in CPP-*/cpp-*.xml; do
    name="${file%.*}"
    xsltproc cpp2html.xsl "$file" > "$name.html"
done