"
MKUnifyGoal is a goal that, when evaluated, will succeed if firstObject and secondObject unify.

Instance variables:
  - firstObject
  - secondObject
"
Class {
	#name : #MKUnifyGoal,
	#superclass : #MKGoal,
	#instVars : [
		'firstObject',
		'secondObject'
	],
	#category : 'MicroKanren-Core'
}

{ #category : #'instance creation' }
MKUnifyGoal class >> unify: anObject with: anotherObject [
	"Answer a new goal that, when evaluated, will try to unify  `anObject' with `anotherObject'."

	^ self new setFirstObject: anObject secondObject: anotherObject
]

{ #category : #'goal evaluation' }
MKUnifyGoal >> evaluateOn: anEnv [
	^ MKEvaluationResult with: (self firstObject unifyWith: self secondObject on: anEnv)
]

{ #category : #'private - accessing' }
MKUnifyGoal >> firstObject [
	^ firstObject
]

{ #category : #'private - accessing' }
MKUnifyGoal >> secondObject [
	^ secondObject
]

{ #category : #'private - initialization' }
MKUnifyGoal >> setFirstObject: anObject secondObject: anotherObject [
	firstObject := anObject.
	secondObject := anotherObject
]
