Context: https://docs.google.com/document/d/1SxtqEN8K6_aDdiUAULa70nXG02XPvioTxE4c2JCAyf4/edit#

# Modeling experiments

## Population Pattern

We often want to use PATO to make expressions like

 - increased adipose tissue (in X)
 - decreased population/count of T-cells (in X)
 - decreasd number of teeth teeth
    - missing some teeth from whole mouth
        - missing all teeth from lower jaw
    - missing all teeth from whole mouth

See replacing towards modeling:
https://docs.google.com/document/d/1SxtqEN8K6_aDdiUAULa70nXG02XPvioTxE4c2JCAyf4/edit?ts=5b20ef69#heading=h.eznq5h29ad0w

The goal here is to have a more intuitive representation of counts of entities, concentrations using explicit Population classes

We want to support things like ABSENT/MISSING_ALL subClassOf MISSING_SOME subClassOf DECREASED

We explore 2

 * pop-pattern (EL)
 * pop-pattern-only (uses Universals)

The latter is made from the former, see Makefile

Currently there are no tests as such - get the inferences using the makefile and manually examine

I explore different ways of representing the same class; these are denote C, C2, C3 etc. They should be inferred equivalent.

We expect things like:

 * AbsentTCellPop4 EquivalentTo AbsentTCellPop
 * MissingUpperTeeth SubClassOf MissingSomeTeeth

But not:

 * AbsentTCellPop4 EquivalentTo Absent Absent

The latter is found only the ONLY pattern. Even though this is more expressive, it is prey to unusual inferences. This is because "no fingers" = "no planets". Paradoxically the SOME pattern may be better since we aren't truly interested in representing strict absence, but instead need to relate to a comparator state

TODO: Go back to Rector granularity paper and compare