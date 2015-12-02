These notes are for the EDITORS of pato

## Editors Version

Do you have an ID range in the idranges file (pato-idranges.owl),
in this directory). If not, get one from the head curator. 

The editors version is pato-edit.obo

** DO NOT EDIT pato.obo OR pato.owl **

pato.obo is the release version

## ID Ranges

TODO - these are not set up

These are stored in the file

 * [pato-idranges.owl](pato-idranges.owl)

** ONLY USE IDs WITHIN YOUR RANGE!! **

## Setting ID ranges in OBO-Edit

In the Metadata menu, select the ID manager option. You can set the ID range of any 
profile you create here by clicking on the settings icon (cog wheels) next to the profile 
name. In the window that appears, you can set the ID range by editing the default rule: 
"ID:$sequence(<number of digits>,<minimum of range>,<maximum of range>)$"
Thus, "PATO:$sequence(8,2000000,2999999)$" will set a range of 8 digit IDs from 200000 
to 2999999.  
 
## Git Quick Guide

TODO add instructions here

## Release Manager notes

to release:

    cd src/ontology
    make

If this looks good:

    git commit -a

And type a brief description of the release in the editor window

# How to release the ontology

The -edit file is generally not visible to the public (of course they
can find it in github if they try). The editors are free to make
changes they are not yet comfortable releasing.

When ready for release, the process is as follows:

First check the file is valid - see the Jenkins job below. Additional
spot checks would not do any harm.

Type:

    make release

This generates derived files such as pato.owl and pato.obo and places
them in the top level (../..). The versionIRI will be added.

Commit and push these files.

IMMEDIATELY AFTERWARDS (do *not* make further modifications) go here:

 * https://github.com/obophenotype/pato/releases
 * https://github.com/obophenotype/pato/releases/new

The value of the "Tag version" field MUST be

    vYYYY-MM-DD

The initial lowercase "v" is REQUIRED. The YYYY-MM-DD *must* match
what is in the versionIRI of the derived pato.owl (data-version in
pato.obo).

Release title should be YYYY-MM-DD, optionally followed by a title (e.g. "january release")

Then click "publish release"

NO MORE THAN ONE RELEASE PER DAY.

In addition, this will be picked up by the central obolibrary job
within 24hrs, which will produce two files:

 1. http://purl.obolibrary.org/obo/pato.obo
 2. http://purl.obolibrary.org/obo/pato.owl

This is used by obolibrary users and OWL people

For questions on this contact Chris Mungall or email obo-admin AT obofoundry.org

# Travis Continuous Integration System

Check the build status here: [![Build Status](https://travis-ci.org/pato-ontology/pato.svg?branch=master)](https://travis-ci.org/pato-ontology/pato)

## General Guidelines

See:
http://wiki.geneontology.org/index.php/Curator_Guide:_General_Conventions
