OBO=http://purl.obolibrary.org/obo
USECAT= --catalog-xml catalog-v001.xml

all: all_imports release

ARTEFACTS = pato.obo pato.owl pato.json pato_ext.owl pato_ext.json pato-base.obo pato-base.owl pato-base.json
release: $(ARTEFACTS) copy-release

TARGETS = $(ARTEFACTS) imports
copy-release:
	cp -pr $(TARGETS) ../..

test: all

# ----------------------------------------
# BUILD
# ----------------------------------------

# This is a standard OORT build
# We add a custom step to unfold the import closure in the obo version, because obo does not handle imports well

# TODO: allow-equivalent-pairs is there for the CL:cell vs GO:cell
pato.owl: pato-edit.obo
	robot reason -i $< -r elk -o $@
pato.json: pato.owl
	robot -i $< -o $@
pato_ext.json: pato_ext.owl
	robot -i $< -o $@
pato.obo: build/pato.owl
	owltools $(USECAT) $< --merge-imports-closure -o -f obo $@
pato-basic.owl: pato.owl
	owltools $< --remove-axioms -t DisjointClasses --set-ontology-id $(OBO)/pato/$@ -o $@
pato-basic.obo: pato-basic.owl
	robot -i $< -o $@.tmp && grep -v ^owl-axioms $@.tmp > $@

# ----------------------------------------
# Base
# ----------------------------------------
pato_ext-no-imports.owl: pato_ext.owl
	owltools $(USECAT) $< --remove-imports-declarations -o $@
pato-base.owl: pato-edit.obo pato_ext-no-imports.owl
	owltools $^ --merge-support-ontologies --set-ontology-id $(OBO)/pato/$@ -o $@
pato-base.json: pato-base.owl
	robot convert -i $< -o $@
pato-base.obo: pato-base.owl
	robot convert -i $< -o $@

# ----------------------------------------
# Regenerate imports
# ----------------------------------------
# Uses OWLAPI Module Extraction code

# Type 'make imports/X_import.owl' whenever you wish to refresh the import for an ontology X. This is when:
#
#  1. X has changed and we want to include these changes
#  2. We have added onr or more new IRI from X into pato-edit.owl
#  3. We have removed references to one or more IRIs in X from pato-edit.owl
#
# You should NOT edit these files directly, changes will be overwritten.
#
# If you want to add something to these, edit pato-edit.owl and add an axiom with a IRI from X. You don't need to add any information about X.

# Base URI for local subset imports
PATO_IMPORTS_BASE_URI = $(OBO)/pato

# Ontology dependencies
# Add back 'uberon' if PATO references Uberon terms in the future. Currently it causes a ROBOT error
# to perform an `extract` resulting in an empty ontology.
IMPORTS = go pco ro

# Make this target to regenerate ALL
all_imports: $(patsubst %, imports/%_import.owl,$(IMPORTS)) $(patsubst %, imports/%_import.obo,$(IMPORTS))

KEEPRELS = http://purl.obolibrary.org/obo/BFO_0000050 http://purl.obolibrary.org/obo/BFO_0000051 http://purl.obolibrary.org/obo/RO_0002202 http://purl.obolibrary.org/obo/RO_0002495

# Create an import module using the OWLAPI module extraction code via OWLTools.
# We use the standard catalog, but rewrite the import to X to be a local mirror of ALL of X.
# After extraction, we further reduce the ontology by creating a "mingraph" (removes all annotations except label) and by 
imports/%_import.owl: mirror/%.owl imports/terms.txt
	robot extract -i $< -T imports/terms.txt --method BOT -O $(PATO_IMPORTS_BASE_URI)/$@ -o $@

imports/%_import.obo: imports/%_import.owl
	owltools $(USECAT) $< -o -f obo $@

# clone remote ontology locally, perfoming some excision of relations and annotations
mirror/%.owl: 
	owltools $(OBO)/$*.owl --remove-annotation-assertions -l --remove-dangling-annotations  --make-subset-by-properties -f $(KEEPRELS)  -o $@
mirror/ro.owl: 
	owltools $(OBO)/ro.owl --remove-annotation-assertions -l  -o $@
mirror/uberon.owl:
	owltools $(OBO)/uberon/basic.owl --remove-annotation-assertions -l -s -d --remove-axiom-annotations --remove-dangling-annotations --make-subset-by-properties -f $(KEEPRELS) --set-ontology-id $(OBO)/uberon.owl -o $@
.PRECIOUS: mirror/uberon.owl
mirror/pr.owl: mirror/pr.obo
	owltools $< --remove-dangling --set-ontology-id $(OBO)/pr.owl -o $@
.PRECIOUS: mirror/%.owl

# ----------------------------------------
# Reports
# ----------------------------------------
REPORTS=edges basicReport
all_reports: $(patsubst %, reports/pato-%.csv, $(REPORTS))

reports/pato-%.csv: pato.owl sparql/%.sparql
	arq --data $< --query sparql/$*.sparql --results csv > $@.tmp && mv $@.tmp $@


## EXPERIMENTAL

value_no_ldef.tsv: pato-edit.obo
	blip-findall  -i $< "entity_partition(X,value_slim),\+genus(X,_)" -select X -label > $@
