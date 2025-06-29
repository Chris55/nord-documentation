#!/bin/bash

if [ "$1" != "stage" ] && [ "$1" != "lead" ]; then
    echo $1 is not supported.
    exit -1
fi

rm -rf ./out
mkdir ./out

# extract all online doc from the source code and save it as markdown files

if [ "$1" == "stage" ]; then
    jsdoc2md ../src/server/ns3/program/*.js > ./ns3/program/ns3-doc.md
    jsdoc2md ../src/server/ns2/program/*.js > ./ns2/program/ns2-doc.md
fi

if [ "$1" == "lead" ]; then
    jsdoc2md ../src/server/nla1/program/*.js > ./nla1/program/nla1-doc.md
fi

# cleanup markdown files

node ./src/build-doc.js


# build pdf file

PANDOC_OPT="--css=./../pandoc2.css -V geometry:margin=2cm -V geometry:a4paper -V linkcolor:blue"

if [ "$1" == "stage" ]; then
    PANDOC_OUT="./nord-mapping-stage.pdf"
    pandoc ./ns3/program/header.yaml ./out/*-stage.md -s -o $PANDOC_OUT $PANDOC_OPT
    echo Nord Stage documentation updated, $PANDOC_OUT
fi

if [ "$1" == "lead" ]; then
    PANDOC_OUT="./nord-mapping-lead.pdf"
    pandoc ./nla1/header.yaml ./out/*-lead.md -s -o $PANDOC_OUT $PANDOC_OPT
    echo Nord Lead A1 documentation updated, $PANDOC_OUT
fi

# build doc web site

cat ./out/*-stage.md >./index.md
