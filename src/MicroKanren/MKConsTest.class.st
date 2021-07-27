Class {
	#name : #MKConsTest,
	#superclass : #TestCase,
	#category : 'MicroKanren-Tests'
}

{ #category : #tests }
MKConsTest >> testConsFailsToUnifyWithBoundVarIfValuesDontUnify [
	| v e |
	
	v := MKVar new.
	e := v unifyWith: (MKCons with: #x) on: MKEnv empty.
	
	self assert: ((MKCons with: #y) unifyWith: v on: e) isNil
]

{ #category : #tests }
MKConsTest >> testConsFailsToUnifyWithObject [
	self assert: ((MKCons with: #x) unifyWith: #x on: MKEnv empty) isNil
]

{ #category : #tests }
MKConsTest >> testConsUnifiesWithBoundVarIfValueUnifies [
	| v e |
	
	v := MKVar new.
	e := v unifyWith: (MKCons with: #x) on: MKEnv empty.
	
	self assert: ((MKCons with: #x) unifyWith: v on: e) isNotNil
]

{ #category : #tests }
MKConsTest >> testConsUnifiesWithConsIfNoFreshVarsInside [
	| x y |
	
	x := #(x y z) asMKCons.
	y := #(x y z) asMKCons.
	
	self assert: (x unifyWith: y on: MKEnv empty) isNotNil
]

{ #category : #tests }
MKConsTest >> testConsUnifiesWithConsWithBoundVar [
	| x v e y |
	
	x := #(x y z) asMKCons.
	v := MKVar new.
	e := v unifyWith: #y on: MKEnv empty.
	y := { #x . v . #z } asMKCons.
	
	self assert: (x unifyWith: y on: e) isNotNil
]

{ #category : #tests }
MKConsTest >> testConsUnifiesWithConsWithFreshVars [
	| x v y e |
	
	x := #(x y z) asMKCons.
	v := MKVar new.
	y := { #x . v . #z } asMKCons.
	e := x unifyWith: y on: MKEnv empty.
	
	self assert: (e valueAt: v) equals: #y
]

{ #category : #tests }
MKConsTest >> testConsUnifiesWithFreshVar [
	| v c e |
	
	v := MKVar new.
	c := MKCons with: #x.
	e := v unifyWith: c on: MKEnv empty.

	self assert: (e valueAt: v) equals: c
]

{ #category : #tests }
MKConsTest >> testConsWithFreshVarsReifiesDeeply [
	| c s |
	
	c := MKCons head: #x tail: (MKCons head: (MKCons with: (MKVar new)) tail: (MKCons with: (MKVar new))).
	s := MKState initial: MKEnv empty.
	
	self assert: (c reifyUsing: s) equals: (MKCons head: #x tail: (MKCons head: (MKCons with: (MKPlaceholder withId: 0)) tail: (MKCons with: (MKPlaceholder withId: 1))))
]

{ #category : #tests }
MKConsTest >> testCreateCollectionFromCons [
	| cons |
	
	cons := { 1 . 2 . 3 } asMKCons.
	
	self assert: cons asOrderedCollection equals: {1 . 2 . 3} asOrderedCollection

]

{ #category : #tests }
MKConsTest >> testCreateConsFromCollection [
	| xs ys |
	
	xs := { #x . #y . #z }.
	ys := MKCons head: #x tail: (MKCons head: #y tail: (MKCons with: #z)).
	
	self assert: xs asMKCons equals: ys
]
