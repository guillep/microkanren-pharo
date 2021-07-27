"
A MKDelayedEvaluationResult will take a block that evaluates to a evaluation result, and when any operation is requested, will evaluate that block and delegate onto it.
"
Class {
	#name : #MKDelayedEvaluationResult,
	#superclass : #MKEvaluationResult,
	#instVars : [
		'delayedBlock',
		'forcedResult'
	],
	#category : 'MicroKanren-Core'
}

{ #category : #'instance creation' }
MKDelayedEvaluationResult class >> delay: aBlockClosure [ 
	"Answer an delayed (lazy) evaluation result."
	
	^ self new setDelayedBlock: aBlockClosure
]

{ #category : #'private - accessing' }
MKDelayedEvaluationResult >> env [
	^ self forcedResult env
]

{ #category : #'private - lazy evaluation' }
MKDelayedEvaluationResult >> force [
	"Ensure the delayd block is forced."
	
	forcedResult ifNil: [ forcedResult := delayedBlock value ]
]

{ #category : #'private - accessing' }
MKDelayedEvaluationResult >> forcedResult [
	^ forcedResult
]

{ #category : #testing }
MKDelayedEvaluationResult >> isEmpty [
	"Answer whether the delayed result is empty or not. This operation will force the delayed result if necessary."
	
	self force.
	
	^ self forcedResult isEmpty
]

{ #category : #'private - accessing' }
MKDelayedEvaluationResult >> nextResult [
	^ self forcedResult nextResult
]

{ #category : #'private - initialization' }
MKDelayedEvaluationResult >> setDelayedBlock: aBlockClosure [ 
	delayedBlock := aBlockClosure 
]
