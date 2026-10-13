#!/bin/env bash
FILES="CPP-*/cpp-*.xml"
if [ "$1" ]; then
    FILES="$1"
fi

export SGML_CATALOG_FILES=".xml/catalog.xml"

for file in $FILES; do
    name="${file%.*}"
    xmllint --noout --catalogs --schema ./cpp.xsd "$file"
done
