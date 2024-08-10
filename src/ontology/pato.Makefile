## Customize Makefile settings for pato
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile


#pre_release: $(SRCOWL)

$(ONT).obo: $(ONT)-simple.owl
	$(ROBOT) annotate --input $(ONT)-simple.owl --ontology-iri $(URIBASE)/$(ONT).owl --version-iri $(ONTBASE)/releases/$(TODAY)/$@ \
		convert --check false -f obo $(OBO_FORMAT_OPTIONS) -o $@.tmp.obo && grep -v ^owl-axioms $@.tmp.obo > $@ && rm $@.tmp.obo

#pato-edit-donotedit.owl:
#	$(ROBOT) convert -i $(SRC) -f owl -o $@

x: 
	$(ROBOT) merge --input $(ONT)-simple.owl \
		convert -f obo --check false -o ../../pato.obo

#t: pato-edit-donotedit.owl
#	$(ROBOT) merge -i pato-edit-donotedit.owl \
#		reason --reasoner ELK --equivalent-classes-allowed all --exclude-tautologies structural \
#		relax \
#		remove --axioms equivalent \
#		relax \
#		filter --term-file $(SIMPLESEED) --select "annotations ontology anonymous self" --trim true --signature true \
#		reduce -r ELK \
#		annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@.tmp.owl && mv $@.tmp.owl $(ONT)-simple.owl

tmp/merged.obo: $(SRC)
	$(ROBOT) merge -i $< convert -f obo --check false -o $@

.PHONY: test_obsolete
test_obsolete: tmp/merged.obo
	! grep "! obsolete" $<

test: test_obsolete

benchmark_imports:
	/usr/bin/time -f %M make refresh-imports

RELEASE_ASSETS_RELEASE_DIR=$(foreach n,$(RELEASE_ASSETS), ../../$(n))

.PHONY: public_release
public_release:
	@test $(GHVERSION)
	ls -alt $(RELEASE_ASSETS_RELEASE_DIR)
	gh auth login
	gh release create $(GHVERSION) --notes "TBD." --title "$(GHVERSION)" --draft $(RELEASE_ASSETS_RELEASE_DIR)  --generate-notes
