These notes are for the EDITORS of pato

For more details on ontology management, please see the OBO tutorial:

 * https://github.com/jamesaoverton/obo-tutorial

## Editors Version

Do you have an ID range in the idranges file (pato-idranges.owl),
in this directory). If not, get one from the head curator. 

The editors version is [pato-edit.obo](pato-edit.obo)

** DO NOT EDIT pato.obo OR pato.owl **

pato.obo is the release version

The editors version can be edited using OBO-Edit. Protege can be used
ONLY IF the version is 5beta-snapshot18 or higher. DO NOT EDIT WITH
PREVIOUS VERSIONS.

## ID Ranges

TODO - these are not set up

These are stored in the file

 * [pato-idranges.owl](pato-idranges.owl)

** ONLY USE IDs WITHIN YOUR RANGE!! **
 
## Git Quick Guide

TODO add instructions here

## Release Manager notes

First you should have docker installed. This release pipeline uses the obolibrary/osk container on dockerhub.

You should only attempt to make a release AFTER the edit version is
committed and pushed, and the travis build passes.

to release:

    cd src/ontology
    ./run make

If this looks good type:

    ./run make release

This generates derived files such as pato.owl and pato.obo and places
them in the top level (../..). The versionIRI will be added.

Commit and push these files.

    git commit -a -m 'new release'

And type a brief description of the release in the editor window

    git push origin master

IMMEDIATELY AFTERWARDS (do *not* make further modifications) go here:

 * https://github.com/pato-ontology/pato/releases
 * https://github.com/pato-ontology/pato/releases/new

The value of the "Tag version" field MUST be

    vYYYY-MM-DD

The initial lowercase "v" is REQUIRED. The YYYY-MM-DD *must* match
what is in the versionIRI of the derived pato.owl (data-version in
pato.obo). Note - docker is GMT, so the date may be the next day depending on which time zone you are in. 

Release title should be YYYY-MM-DD, optionally followed by a title (e.g. "january release")

Then click "publish release"

__IMPORTANT__: NO MORE THAN ONE RELEASE PER DAY.

The PURLs are already configured to pull from github. This means that
BOTH ontology purls and versioned ontology purls will resolve to the
correct ontologies. Try it!

 * http://purl.obolibrary.org/obo/pato.owl <-- current ontology PURL

 Publish the release in GitHub. Then check the file using the link below.
 * http://purl.obolibrary.org/obo/pato/releases/YYYY-MM-DD/pato.owl <-- change to the release you just made

For questions on this contact Chris Mungall or email Nicole Vasilevsky at vasilevs @ ohsu.edu

# Travis Continuous Integration System

Check the build status here: [![Build Status](https://travis-ci.org/pato-ontology/pato.svg?branch=master)](https://travis-ci.org/pato-ontology/pato)

This replaces Jenkins for this ontology

## General Guidelines

See:
http://wiki.geneontology.org/index.php/Curator_Guide:_General_Conventions
