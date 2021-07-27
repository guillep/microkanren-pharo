Class {
	#name : #MKObjectTest,
	#superclass : #TestCase,
	#category : 'MicroKanren-Tests'
}

{ #category : #tests }
MKObjectTest >> testObjectFailsToUnifyWithBoundVarIfValuesNotEqual [
	| v e |
	
	v := MKVar new.
	e := v unifyWith: #x on: MKEnv empty.
	
	self assert: (#y unifyWith: v on: e) isNil
]

{ #category : #tests }
MKObjectTest >> testObjectFailsToUnifyWithObjectIfNotEqual [
	self assert: (#x unifyWith: #y on: MKEnv empty) isNil
]

{ #category : #tests }
MKObjectTest >> testObjectReifyToSelf [
	| s |
	
	s := MKState initial: MKEnv empty.
	
	self assert: (#x reifyUsing: s) equals: #x
]

{ #category : #tests }
MKObjectTest >> testObjectUnifiesWithBoundVarIfValuesEqual [
	| v e |
	
	v := MKVar new.
	e := v unifyWith: #x on: MKEnv empty.
	
	self assert: (#x unifyWith: v on: e) isNotNil
]

{ #category : #tests }
MKObjectTest >> testObjectUnifiesWithFreshVar [
	self assert: (#x unifyWith: (MKVar new) on: MKEnv empty) isNotNil
	
]

{ #category : #tests }
MKObjectTest >> testObjectUnifiesWithObjectIfEqual [
	self assert: (#x unifyWith: #x on: MKEnv empty) isNotNil
]
