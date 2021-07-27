"
an MKState contains the state of a reification: a id generator to initialize instances of MKPlaceholder, and an environment to evaluate variables and values.

"
Class {
	#name : #MKState,
	#superclass : #Object,
	#instVars : [
		'currentId',
		'env'
	],
	#category : 'MicroKanren-Core'
}

{ #category : #'instance creation' }
MKState class >> initial: anEnv [ 
	^ MKState new setCurrentId: 0 env: anEnv
]

{ #category : #'private - reification' }
MKState >> nextId [
	| x |
	
	x := currentId.
	currentId := currentId + 1.
	
	^ x
]

{ #category : #'private - initialization' }
MKState >> setCurrentId: anInteger env: anEnv [
	currentId := anInteger.
	env := anEnv
]

{ #category : #reification }
MKState >> valueAt: aVar [ 
	^ (env valueAt: aVar ifAbsent: [ MKPlaceholder withId: self nextId ]) reifyUsing: self
	
]
