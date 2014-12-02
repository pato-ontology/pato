# About pato_ext.owl

PATO contains terms for many qualities that can logically defined in terms of implications of the bearer or partonomy of the bearer.  pato_ext.owl contains GCI axioms that capture these implications.  For example:

* 'has part' some cilium EquivalentTo 'bearer of' some ciliatedness
* 'bearer of' some multinucleate EquivalentTo 'has component' min 2 nucleus
*  not ('has part' some nucleus) EquivalentTo 'bearer of' some anucleate
* 'bearer of' some unicellular SubClassOf cell
* 'bearer of' some 'process quality' SubClassOf occurrent
* 'has part' some ('bearer of' some mass) EquivalentTo 'bearer of' some mass
 
Note that some of these axioms are outside of EL (e.g. because of use of cardinality constraints or negation).  Of these, some could be relaxed to provide safe but useful assertions in EL.  For example

* 'bearer of' some multinucleate EquivalentTo 'has component' min 2 nucleus

> could be relaxed to 

* 'bearer of' some multinucleate subClassOf 'has part' some nucleus


_Question:_ Can we devise some way to automatically relax these constraints?  Or should we be adding relaxed versions manually - perhaps with some tagging system to flag EL vs non EL GCIs?
