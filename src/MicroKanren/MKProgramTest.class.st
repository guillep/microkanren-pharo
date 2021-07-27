Class {
	#name : #MKProgramTest,
	#superclass : #TestCase,
	#category : 'MicroKanren-Tests'
}

{ #category : #tests }
MKProgramTest >> testBoundedRunReturnsRequestedResults [
	| program |
	
	program :=
		MKProgram script: [ :x |
			MKVar fresh: [ :y :z |
				((x @@ y), (y @@ 1)) | ((x @@ z), (z @@ 2)) ] ].
		
	self assert: (program runAnsweringAtMost: 1)
			equals: { 1 . 2 } asOrderedCollection
]

{ #category : #tests }
MKProgramTest >> testRunReifiesResults [
	self assert: (MKProgram run: [ :x | MKGoal success ])
			equals: (OrderedCollection with: (MKPlaceholder withId: 0))
]

{ #category : #tests }
MKProgramTest >> testRunWalksOverResults [
	| results |
	
	results := MKProgram run: [ :x |
		MKVar fresh: [ :y :z |
			(x @@ y), (y @@ z), (z @@ 1) ]].
	
	self assert: results equals: { 1 } asOrderedCollection 
]

{ #category : #tests }
MKProgramTest >> testRunningFailingScriptProducesEmptyCollection [
	self assert: (MKProgram run: [ :x | 1 @@ 0 ]) isEmpty
	
]

{ #category : #tests }
MKProgramTest >> testRunningSucceedingProgramReturnsListOfBindings [
	| values |
	
	values := MKProgram run: [ :x | x @@ 1 ].
	
	self assert: values equals: {1} asOrderedCollection
]

{ #category : #tests }
MKProgramTest >> testUnboundedRunReturnsAllResults [
	| program |
	
	program :=
		MKProgram script: [ :x |
			MKVar fresh: [ :y :z |
				((x @@ y), (y @@ 1)) | ((x @@ z), (z @@ 2)) ] ].
		
	self assert: program run equals: { 1 . 2 } asOrderedCollection
]
