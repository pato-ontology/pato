## Customize Makefile settings for pato
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile


pre_release: $(SRCOWL)
	

$(ONT).obo: t
	$(ROBOT) annotate --input $(ONT)-simple.owl --ontology-iri $(URIBASE)/$(ONT).owl --version-iri $(ONTBASE)/releases/$(TODAY)/$@ \
		convert --check false -f obo $(OBO_FORMAT_OPTIONS) -o $@.tmp.obo && grep -v ^owl-axioms $@.tmp.obo > $@ && rm $@.tmp.obo

pato-edit-donotedit.owl:
	$(ROBOT) merge --input $(SRC) \
		convert -f owl -o $@

t: #pato-edit-donotedit.owl
	$(ROBOT) merge -i pato-edit-donotedit.owl \
		reason --reasoner ELK --equivalent-classes-allowed all --exclude-tautologies structural \
		relax \
		remove --axioms equivalent \
		relax \
		filter --term-file $(SIMPLESEED) --select "annotations ontology anonymous self" --trim true --signature true \
		reduce -r ELK \
		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $(ONT)-simple.owl