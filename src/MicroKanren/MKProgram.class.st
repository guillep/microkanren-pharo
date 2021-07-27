"
A MKProgram represents a microKanren computation. Its responsibilities are:
  1. Run microKanren scripts (blocks that receive one variable and return a goal)
  2. Offer syntactic sugar for commonly used constructs (conde, condi, etc.)
"
Class {
	#name : #MKProgram,
	#superclass : #Object,
	#instVars : [
		'script'
	],
	#category : 'MicroKanren-Core'
}

{ #category : #running }
MKProgram class >> run: aBlockClosure [
	"Run aBlockClosure as a microKanren program, answering all possible results as a collection."

	^ (MKProgram script: aBlockClosure) run
]

{ #category : #'instance creation' }
MKProgram class >> script: aBlockClosure [ 
	"Answer a new microKanren program, using aBlockClosure as its script."
	
	^ self new setScript: aBlockClosure
]

{ #category : #running }
MKProgram >> run [
	"Answer all possible results of this program."
	
	^ self runAnsweringAtMost: Float infinity
]

{ #category : #running }
MKProgram >> runAnsweringAtMost: resultLimit [
	"Answer at most resultLimit results of this program."
	| variable results |
	
	variable := MKVar new.
	results := (script value: variable) evaluateOn: MKEnv empty.
	"resultLimit ~= Float infinity ifTrue: [
		results := results take: resultLimit ]."

	^ results asOrderedCollection
		collect: [ :env | variable reifyUsing: (MKState initial: env) ]
			thenReject: [ :val | val isNil ]
]

{ #category : #'private - initialization' }
MKProgram >> setScript: aBlockClosure [ 
	script := aBlockClosure
]
