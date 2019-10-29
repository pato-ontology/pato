## Customize Makefile settings for pato
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

$(ONT).obo: $(ONT)-base.owl
	$(ROBOT) annotate --input $< --ontology-iri $(URIBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ \
		convert --check false -f obo $(OBO_FORMAT_OPTIONS) -o $@.tmp.obo && grep -v ^owl-axioms $@.tmp.obo > $@ && rm $@.tmp.obo
