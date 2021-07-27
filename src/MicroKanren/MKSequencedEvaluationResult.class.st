"
A MKSecuencedEvaluationResult is a result that contains a reference to an environment and to a subsequent evaluation result.

Instance variables:
  - env, the environment in which the goal was successful
  - nextResult, an object that will return the next result as a response to the #value message. It may be null if no nextResult exists.
"
Class {
	#name : #MKSequencedEvaluationResult,
	#superclass : #MKEvaluationResult,
	#instVars : [
		'env',
		'nextResult'
	],
	#category : 'MicroKanren-Core'
}

{ #category : #'instance creation' }
MKSequencedEvaluationResult class >> head: anEnv delayedTail: aDelayedResult [ 
	^ self new setEnv: anEnv nextResult: aDelayedResult
]

{ #category : #'private - accessing' }
MKSequencedEvaluationResult >> env [
	^ env
]

{ #category : #'private - accessing' }
MKSequencedEvaluationResult >> nextResult [
	"Answer the next result."
	
	^ nextResult
]

{ #category : #'private - initialization' }
MKSequencedEvaluationResult >> setEnv: anEnv nextResult: aResult [
	env := anEnv.
	nextResult := aResult
]
