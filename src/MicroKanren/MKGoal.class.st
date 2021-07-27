"
An MKGoal is an expression that either succeedes or fails. A successful result is an MKEvaluationResult that contains at least one environment.
"
Class {
	#name : #MKGoal,
	#superclass : #Object,
	#category : 'MicroKanren-Core'
}

{ #category : #accessing }
MKGoal class >> failure [
	^ MKFailureGoal instance
]

{ #category : #accessing }
MKGoal class >> success [
	^ MKSuccessGoal instance
]

{ #category : #'goal combinators' }
MKGoal >> , aGoal [
	"Answer a goal that is the conjuction of self and aGoal. This new goal will succeed iff both self and aGoal succeed when evaluated."
	 
	^ MKConjGoal of: self and: aGoal
]

{ #category : #'goal evaluation' }
MKGoal >> evaluateOn: anEnv [
	"Evaluate self in the given environment, returning a MKEvaluationResult on success or nil on failure."
	
	self subclassResponsibility
]

{ #category : #'goal combinators' }
MKGoal >> | aGoal [ 
	^ MKDisjGoal of: self and: aGoal
]
