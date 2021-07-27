"
An MKPlaceholder is the result of reifying a fresh variable. It is simply a marker for ""any value""

"
Class {
	#name : #MKPlaceholder,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : 'MicroKanren-Core'
}

{ #category : #'instance creation' }
MKPlaceholder class >> withId: anInteger [ 
	^ MKPlaceholder new setId: anInteger
]

{ #category : #comparing }
MKPlaceholder >> = aPlaceholder [
	^ self species = aPlaceholder species and: [ 
		self id = aPlaceholder id ]
]

{ #category : #'private - accessing' }
MKPlaceholder >> id [
	^ id
]

{ #category : #'private - initialization' }
MKPlaceholder >> setId: anInteger [ 
	id := anInteger
]
