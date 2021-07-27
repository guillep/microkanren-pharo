"
A goal that always fails.
"
Class {
	#name : #MKFailureGoal,
	#superclass : #MKGoal,
	#classVars : [
		'Instance'
	],
	#category : 'MicroKanren-Core'
}

{ #category : #accessing }
MKFailureGoal class >> instance [
	^ Instance ifNil: [ Instance := self new ]
]

{ #category : #'goal evaluation' }
MKFailureGoal >> evaluateOn: anEnv [
	^ MKEvaluationResult empty
]
