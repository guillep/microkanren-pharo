"
A goal that succeeds when either firstGoal or secondGoal (or both) succeeds.

Instance variables:
  - firstGoal
  - secondGoal
"
Class {
	#name : #MKDisjGoal,
	#superclass : #MKGoal,
	#instVars : [
		'firstGoal',
		'secondGoal'
	],
	#category : 'MicroKanren-Core'
}

{ #category : #'instance creation' }
MKDisjGoal class >> of: firstGoal and: secondGoal [
	^ self new setFirstGoal: firstGoal secondGoal: secondGoal
]

{ #category : #'goal evaluation' }
MKDisjGoal >> evaluateOn: anEnv [ 
	^ MKEvaluationResult delayed: [ 
		(self firstGoal evaluateOn: anEnv), (self secondGoal evaluateOn: anEnv) ]
]

{ #category : #'private - accessing' }
MKDisjGoal >> firstGoal [
	^ firstGoal
]

{ #category : #'private - accessing' }
MKDisjGoal >> secondGoal [
	^ secondGoal
]

{ #category : #'private - initialization' }
MKDisjGoal >> setFirstGoal: aGoal secondGoal: anotherGoal [
	firstGoal := aGoal.
	secondGoal := anotherGoal
]
