#!/bin/bash

declare -a antirepackagingParams
declare -a obfuscapkParams
obfPar="false"
for var in "$@"
do
  if [ "$var" = "--obfuscapk" ]; then
    obfPar="true"
    continue
  fi
  if [ "$obfPar" = "true" ]; then
    obfuscapkParams+=("$var")
  else
    antirepackagingParams+=("$var")
  fi
done


java -jar /bin/antirepackaging.jar "${antirepackagingParams[@]}"

if [ "$obfPar" = "true" ]; then
  python3 -m obfuscapk.cli "${obfuscapkParams[@]}"
fi