
t: t1 t2

t1: pop-pattern-inf
t2: pop-pattern-only-inf

%-only.omn: %.omn
	perl -npe 's@has_member some@has_member only@;s@member_count value 0@has_member exactly 0@' $< > $@
.PRECIOUS: %-only.omn

%-inf: %.omn
	owltools $< --run-reasoner -r hermit -u
