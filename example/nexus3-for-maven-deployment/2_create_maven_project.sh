#!/bin/bash

GROUP_ID=${1}
ARTIFACT_ID=${2}
VERSION=${3}

echo "GROUP_ID=${GROUP_ID}"
echo "ARTIFACT_ID=${ARTIFACT_ID}"
echo "VERSION=${VERSION}"

mvn archetype:generate \
  -DarchetypeGroupId=org.apache.maven.archetypes \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DarchetypeVersion=1.3 \
  -DinteractiveMode=false \
  -DgroupId=${GROUP_ID} \
  -DartifactId=${ARTIFACT_ID} \
  -Dversion=${VERSION}
