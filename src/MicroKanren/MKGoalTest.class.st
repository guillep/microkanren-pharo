Class {
	#name : #MKGoalTest,
	#superclass : #TestCase,
	#category : 'MicroKanren-Tests'
}

{ #category : #tests }
MKGoalTest >> testConjCanBeConjed [
	| g |
	
	g := MKGoal success, MKGoal success, MKGoal success.
	
	self deny: (g evaluateOn: MKEnv empty) isEmpty
]

{ #category : #tests }
MKGoalTest >> testConjFailsIfBothGoalsFail [
	| g |
	
	g := MKGoal failure, MKGoal failure.
	
	self assert: (g evaluateOn: MKEnv empty) isEmpty
]

{ #category : #tests }
MKGoalTest >> testConjFailsIfFirstGoalFails [
	| g |
	
	g := MKGoal failure, MKGoal success.
	
	self assert: (g evaluateOn: MKEnv empty) isEmpty
]

{ #category : #tests }
MKGoalTest >> testConjFailsIfSecondGoalFails [
	| g |
	
	g := MKGoal success, MKGoal failure.
	
	self assert: (g evaluateOn: MKEnv empty) isEmpty
]

{ #category : #tests }
MKGoalTest >> testConjSucceedsIfBothGoalsSucceed [
	| g |
	
	g := MKGoal success, MKGoal success.
	
	self deny: (g evaluateOn: MKEnv empty) isEmpty
]

{ #category : #tests }
MKGoalTest >> testDisjFailsIfBothGoalsFail [
	| g |
	
	g := (#x @@ #y) | (#x @@ #y).
	
	self assert: (g evaluateOn: MKEnv empty) isEmpty
]

{ #category : #tests }
MKGoalTest >> testDisjSucceedsIfBothGoalsSucceed [
	| g |
	
	g := (#x @@ #x) | (#x @@ #x).
	
	self deny: (g evaluateOn: MKEnv empty) isEmpty
]

{ #category : #tests }
MKGoalTest >> testDisjSucceedsIfFirstGoalSucceeds [
	| g |
	
	g := (#x @@ #x) | (#x @@ #y).
	
	self deny: (g evaluateOn: MKEnv empty) isEmpty
]

{ #category : #tests }
MKGoalTest >> testDisjSucceedsIfSecondGoalSucceeds [
	| g |
	
	g := (#x @@ #y) | (#x @@ #x).
	
	self deny: (g evaluateOn: MKEnv empty) isEmpty
]

{ #category : #tests }
MKGoalTest >> testUnifyGoalFailsIfValuesDoNotUnify [
	| g |
	
	g := #x @@ #y.
	
	self assert: (g evaluateOn: MKEnv empty) isEmpty
]

{ #category : #tests }
MKGoalTest >> testUnifyGoalSucceedsIfValuesUnify [
	| g |
	
	g := #x @@ #x.
	
	self deny: (g evaluateOn: MKEnv empty) isEmpty
]

{ #category : #tests }
MKGoalTest >> testUnifyGoalTerminatesEvaluation [
	| g |
	
	g := #x @@ #x.
	
	self assert: (g evaluateOn: MKEnv empty) nextResult isEmpty
]
