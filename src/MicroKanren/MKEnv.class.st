"
An MKEnv is a simple O(n) mapping between MKVar instances and arbitrary Pharo objects. It is a persistent (immutable) data structure.

It supports two basic operations:
  - binding a variable to a value (#bind:to:)
  - retrieving the value of a variable (#valueAt: and #valueAt:ifAbsent:)


"
Class {
	#name : #MKEnv,
	#superclass : #Object,
	#instVars : [
		'var',
		'val',
		'next'
	],
	#classVars : [
		'EmptyEnv'
	],
	#category : 'MicroKanren-Core'
}

{ #category : #'variable binding' }
MKEnv class >> bind: aVar to: anObject over: anEnv [ 
	"Answer a new environment that contains all bindings in anEnv plus the mapping from aVar to anObject"
	 ^ self new setVar: aVar val: anObject next: anEnv
]

{ #category : #accessing }
MKEnv class >> empty [
	"Answer the empty environment"
	^ EmptyEnv ifNil: [ EmptyEnv := self new ]

]

{ #category : #'variable binding' }
MKEnv >> bind: aVar to: anObject [ 
	"Bind the variable aVar to the value anObject in a new environment based on the receiver and return that new environment"
	
	 ^ self class bind: aVar to: anObject over: self
]

{ #category : #'private - initialization' }
MKEnv >> setVar: aVar val: anObject next: anEnv [ 
	var := aVar.
	val := anObject.
	next := anEnv.
]

{ #category : #'variable binding' }
MKEnv >> valueAt: aVar [
	"Answer the value bound to aVar in this environment or nil if no binding present"
	
	^ self valueAt: aVar ifAbsent: [ ^ nil ]
]

{ #category : #'variable binding' }
MKEnv >> valueAt: aVar ifAbsent: aBlockClosure [
	"Answer the value bound to aVar in this environment or the result of evaluating aBlockClosure if no binding present"
	
	var ifNil: [ ^ aBlockClosure value ]. 
	aVar = var ifTrue: [ ^ val ].
	^ next valueAt: aVar ifAbsent: aBlockClosure 
]
