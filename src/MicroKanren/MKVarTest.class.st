Class {
	#name : #MKVarTest,
	#superclass : #TestCase,
	#category : 'MicroKanren-Tests'
}

{ #category : #tests }
MKVarTest >> testBoundVarFailsToUnifyWithBoundVarIfValuesDontUnify [
	| u v e |
	
	u := MKVar new.
	v := MKVar new.
	e := u unifyWith: #x on: MKEnv empty.
	e := v unifyWith: #y on: e.
			
	self assert: (u unifyWith: v on: e) isNil
]

{ #category : #tests }
MKVarTest >> testBoundVarFailsToUnifyWithConsIfValueDoesNotUnify [
	| v e |
	
	v := MKVar new.
	e := v unifyWith: #(x y z) asMKCons on: MKEnv empty.
	
	self assert: (v unifyWith: #(x 2 z) asMKCons on: e) isNil
]

{ #category : #tests }
MKVarTest >> testBoundVarFailsToUnifyWithObjectIfValuesNotEq [
	| v e |
	
	v := MKVar new.
	e := v unifyWith: #x on: MKEnv empty.
	
	self assert: (v unifyWith: #y on: e) isNil
]

{ #category : #tests }
MKVarTest >> testBoundVarReifiesToValue [
	| v e s |
	
	v := MKVar new.
	e := v unifyWith: #x on: MKEnv empty.
	s := MKState initial: e.
	
	self assert: (v reifyUsing: s) equals: #x
]

{ #category : #tests }
MKVarTest >> testBoundVarUnifiesWithBoundVarIfValuesUnify [
	| u v e |
	
	u := MKVar new.
	v := MKVar new.
	e := u unifyWith: #x on: MKEnv empty.
	e := v unifyWith: #x on: e.
			
	self assert: (u unifyWith: v on: e) isNotNil
	
]

{ #category : #tests }
MKVarTest >> testBoundVarUnifiesWithConsIfValueUnifies [
	| v e |
	
	v := MKVar new.
	e := v unifyWith: #(x y z) asMKCons on: MKEnv empty.
	
	self assert: (v unifyWith: #(x y z) asMKCons on: e) isNotNil
]

{ #category : #tests }
MKVarTest >> testBoundVarUnifiesWithObjectIfValueEq [
	| v e |
	
	v := MKVar new.
	e := v unifyWith: #x on: MKEnv empty.
	
	self assert: (v unifyWith: #x on: e) isNotNil
]

{ #category : #tests }
MKVarTest >> testCreateNFreshVarsWithFactoryMethod [
	MKVar fresh: [ :x :y :z |
		self deny: (x = y).
		self deny: (x = z).
		self deny: (y = z).
		self assert: ({ x . y . z } inject: true into: [ :b :v | b and: [ v isKindOf: MKVar ]]) ]
]

{ #category : #tests }
MKVarTest >> testCreateOneFreshVarsWithFactoryMethod [
	MKVar fresh: [ :v |
		self assert: (v isKindOf: MKVar) ]
]

{ #category : #tests }
MKVarTest >> testFreshVarReifiesToPlaceholder [
	| s |
	
	s := MKState initial: MKEnv empty.
	
	self assert: (MKVar new reifyUsing: s) equals: (MKPlaceholder withId: 0)
]

{ #category : #tests }
MKVarTest >> testFreshVarUnifiesWithBoundVar [
	| u v e |
	
	u := MKVar new.
	v := MKVar new.
	e := v unifyWith: #x on: MKEnv empty.
	
	self assert: ((u unifyWith: v on: e) valueAt: u) equals: #x
]

{ #category : #tests }
MKVarTest >> testFreshVarUnifiesWithCons [
	| v e |
	
	v := MKVar new.
	e := v unifyWith: (MKCons with: #x) on: MKEnv empty.
	
	self assert: (e valueAt: v) equals: (MKCons with: #x)
]

{ #category : #tests }
MKVarTest >> testFreshVarUnifiesWithFreshVar [
	| u v |
	
	u := MKVar new.
	v := MKVar new.
	
	self assert: ((u unifyWith: v on: MKEnv empty) valueAt: v) equals: u
]

{ #category : #tests }
MKVarTest >> testFreshVarUnifiesWithObject [
	| v |
	
	v := MKVar new.
	
	self assert: ((v unifyWith: #x on: MKEnv empty) valueAt: v) equals: #x
]

{ #category : #tests }
MKVarTest >> testFreshVarUnifiesWithSelf [
	| v |
	
	v := MKVar new.
	
	self assert: (v unifyWith: v on: MKEnv empty) isNotNil
	
]
