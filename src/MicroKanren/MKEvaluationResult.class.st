"
An MKEvaluationResult is the outcome of a successful MKGoal.
"
Class {
	#name : #MKEvaluationResult,
	#superclass : #Object,
	#classVars : [
		'EmptyResult'
	],
	#category : 'MicroKanren-Core'
}

{ #category : #'instance creation' }
MKEvaluationResult class >> delayed: aBlockClosure [
	"Answer a new delayed evaluation result. aBlockClosure will be evaluated once when any operation is requested, assuming the returned value is a evaluation result. All messages will be delegated into this evaluation result."
	
	^ MKDelayedEvaluationResult delay: aBlockClosure
]

{ #category : #accessing }
MKEvaluationResult class >> empty [
	"Answer the empty evaluation result."
	
	^ EmptyResult ifNil: [ EmptyResult := self new ]
]

{ #category : #'instance creation' }
MKEvaluationResult class >> with: anEnv [
	"Create a MKEvaluationResult with a single element, the given environment."
	
	^ anEnv
		ifNil: [ self empty ]
		ifNotNil: [ self with: anEnv then: self empty]
]

{ #category : #'instance creation' }
MKEvaluationResult class >> with: anEnv then: aDelayedResult [
	^ MKSequencedEvaluationResult head: anEnv delayedTail: aDelayedResult
]

{ #category : #'goal combinators' }
MKEvaluationResult >> , aResult [
	"Answer a new evaluation result that contains all environments in self followed by all environments in aResult."
	 
	self isEmpty ifTrue:[ ^ aResult ].
	
	aResult isEmpty ifTrue: [ ^ self ].
	
	^ self class with: self env then: [ self nextResult value, aResult ]
]

{ #category : #converting }
MKEvaluationResult >> asOrderedCollection [
	| collection result |
	
	collection := OrderedCollection new.
	result := self.
	
	[ result isEmpty ] whileFalse: [ 
		collection add: result env.
		result := result nextResult value ].
	
	^ collection
]

{ #category : #'private - accessing' }
MKEvaluationResult >> env [
	self subclassResponsibility 
]

{ #category : #enumerating }
MKEvaluationResult >> flatCollect: aBlockClosure [
	self isEmpty
		ifTrue: [ ^ self ].
		
	^ self class delayed: [ 
		(aBlockClosure value: self env) , (self nextResult value flatCollect: aBlockClosure) ]
]

{ #category : #testing }
MKEvaluationResult >> isEmpty [
	"Answer whether this is an empty evaluation result."
	
	^ self = self class empty
]

{ #category : #'private - accessing' }
MKEvaluationResult >> nextResult [
	self subclassResponsibility
]

{ #category : #enumerating }
MKEvaluationResult >> take: anInteger [
	"Answer a evaluation result that contains (at most) the first anInteger elements in self."
	
	(anInteger isZero or: [self = self class empty])
		ifTrue: [ ^ self ].
	
	^ self class delay: [
		self class
			with: self head
				then: (self class delay: [ self nextResult take: anInteger - 1 ])]
]
