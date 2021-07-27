"
An MKCons is a simple linked list, the only compound data structure directly supported by µKanren.

An MKCons consists of:
  - head, an arbitrary Pharo object
  - tail, an MKCons or nil
 
"
Class {
	#name : #MKCons,
	#superclass : #Object,
	#instVars : [
		'head',
		'tail',
		'size'
	],
	#category : 'MicroKanren-Core'
}

{ #category : #'instance creation' }
MKCons class >> head: anObject tail: aConsOrNil [ 
	"Answer a new cons cell with anObject as head and aConsOrNil as tail"
	^ self new setHead: anObject tail: aConsOrNil
]

{ #category : #'instance creation' }
MKCons class >> with: anObject [ 
	"Answer a single cons cell with anObject as head and nil as tail"
	^ self new setHead: anObject tail: nil
]

{ #category : #comparing }
MKCons >> = aConsOrNil [
	^ self species = aConsOrNil species and: [ 
		self head = aConsOrNil head and: [ 
			self tail = aConsOrNil tail ]]
]

{ #category : #converting }
MKCons >> asOrderedCollection [ 
	| aCollection aCons |
	
	aCollection := OrderedCollection ofSize: self size.
	aCons := self.
	
	1 to: self size do: [ :i |
		aCollection at: i put: aCons head.
		aCons := aCons tail ].
	
	^ aCollection
]

{ #category : #'private - hashing' }
MKCons >> chainHash [
	| hash |
	
	hash := self head hash.
	self tail ifNil: [ ^ hash ].
	^ hash bitXor: self tail chainHash
]

{ #category : #comparing }
MKCons >> hash [
	^ self size bitXor: (self species hash bitXor: self chainHash)
]

{ #category : #accessing }
MKCons >> head [
	"Answer the head of the receiver"
	
	^ head
]

{ #category : #printing }
MKCons >> printOn: aStream [
	aStream
		nextPutAll: 'an MKCons('.
	
	self head printOn: aStream.
	
	aStream nextPutAll: ', '.
	
	self tail printOn: aStream.
	
	aStream nextPut: $).
		
]

{ #category : #reification }
MKCons >> reifyUsing: aState [
	| reifiedHead |
	
	reifiedHead := self head reifyUsing: aState.
	^ self class head: reifiedHead tail: (self tail reifyUsing: aState)
]

{ #category : #'private - initialization' }
MKCons >> setHead: anObject tail: aConsOrNil [ 
	head := anObject.
	tail := aConsOrNil.
	size := aConsOrNil ifNil: [ 1 ] ifNotNil: [ aConsOrNil size + 1]
]

{ #category : #accessing }
MKCons >> size [
	"Answer the length of the chain of cons cells lead by the receiver"
	
	^ size
]

{ #category : #accessing }
MKCons >> tail [
	"Answer the cons cell at the tail of the receiver, or nil if none"
	
	^ tail
]

{ #category : #unification }
MKCons >> unifyWith: anObject on: anEnv [
	^ (anObject walkOver: anEnv) unifyWithCons: self on: anEnv
]

{ #category : #unification }
MKCons >> unifyWithCons: aConsOrNil on: anEnv [
	aConsOrNil ifNotNil: [
		| env cons |
		
		cons := aConsOrNil walkOver: anEnv.
		env := self head unifyWith: cons head on: anEnv.
		env ifNotNil: [
			^ self tail unifyWithCons: cons tail on: env ]].
	
	^ nil
]

{ #category : #unification }
MKCons >> unifyWithObject: anObject on: anEnv [
	^ nil
]

{ #category : #unification }
MKCons >> walkOver: anEnv [
	| walkedHead walkedTail |
	
	walkedHead := self head walkOver: anEnv.
	walkedTail := self tail walkOver: anEnv.
	^ self class head: walkedHead tail: walkedTail
]
