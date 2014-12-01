These notes are for the EDITORS of pato

## Editors Version

The editors version is pato-edit.obo

** DO NOT EDIT pato.obo OR pato.owl **

pato.obo is the release version

## ID Ranges

TODO - these are not set up

These are stored in the file

  pato-idranges.owl

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

When ready for release, the process is as follows.

First check the file is valid - see the Jenkins job below. Additional
spot checks would not do any harm.

The pato-edit.obo file should be copied to

 * ftp://ftp.hgu.mrc.ac.uk/pub/MouseAtlas/Anatomy/PATO.obo

JAX users will download from here.

In addition, this will be picked up by the central obolibrary job
within 24hrs, which will produce two files:

 1. http://purl.obolibrary.org/obo/pato.obo
 2. http://purl.obolibrary.org/obo/pato.owl

This is used by obolibrary users and OWL people

For questions on this contact Chris Mungall or email obo-admin AT obofoundry.org


# Jenkins Continuous Integration System

TODO - editors do you want this set up?

Check:

http://build.berkeleybop.org/job/build-pato/

after committing

== General Guidelines ==

See:
http://wiki.geneontology.org/index.php/Curator_Guide:_General_Conventions
