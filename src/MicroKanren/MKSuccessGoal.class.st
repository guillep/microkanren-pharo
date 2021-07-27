"
A goal that always succeeds.
"
Class {
	#name : #MKSuccessGoal,
	#superclass : #MKGoal,
	#classVars : [
		'Instance'
	],
	#category : 'MicroKanren-Core'
}

{ #category : #accessing }
MKSuccessGoal class >> instance [
	^ Instance ifNil: [ Instance := self new ]
]

{ #category : #'goal evaluation' }
MKSuccessGoal >> evaluateOn: anEnv [
	^ MKEvaluationResult with: anEnv
]
