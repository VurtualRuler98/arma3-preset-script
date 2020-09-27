#!/bin/bash
#MODLIST=$(cat mods.txt | sed -E "s/(.*) \- (https.*)/\1\n\2/")
MODLIST=$(cat mods.txt)
#echo -e "${MODLIST}"
touch output.html

OUTPUT=$(cat output_format.html | sed -E "s/STR_PRESET_NAME/foo/g")
MODFORMAT=$(cat modformat.html)
#echo -e "${OUTPUT}"
while IFS= read -r line; do
	MODNAME=$(echo "${line}" | sed -E "s/(.*) \- (https.*)/\1/")
	MODLINK=$(echo "${line}" | sed -E "s/(.*) \- (https.*)/\2/")
	MOD=$(echo -e "${MODFORMAT}" | sed -E 's/STR_MOD_NAME/'"${MODNAME}"'/' | sed -E 's,STR_MOD_LINK,'"${MODLINK}"',g')
	OUTPUT="${OUTPUT}${MOD}"
done <<< "$MODLIST"
SUFFIX=$(cat output_suffix.html)
OUTPUT="${OUTPUT}${SUFFIX}"
echo -e "${OUTPUT}" > output.html
	

