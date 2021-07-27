"
A MKConjGoal is a goal that succeeds iff both firstGoal and secondGoal succeed.

Instance variables: 
  - firstGoal
  - secondGoal

"
Class {
	#name : #MKConjGoal,
	#superclass : #MKGoal,
	#instVars : [
		'firstGoal',
		'secondGoal'
	],
	#category : 'MicroKanren-Core'
}

{ #category : #'instance creation' }
MKConjGoal class >> of: aGoal and: anotherGoal [
	^ self new setFirstGoal: aGoal secondGoal: anotherGoal
]

{ #category : #'goal evaluation' }
MKConjGoal >> evaluateOn: anEnv [
	^ MKEvaluationResult delayed: [
		(firstGoal evaluateOn: anEnv) flatCollect: [ :e |
			secondGoal evaluateOn: e ]]
]

{ #category : #'private - initialization' }
MKConjGoal >> setFirstGoal: aGoal secondGoal: anotherGoal [
	firstGoal := aGoal.
	secondGoal := anotherGoal
]
