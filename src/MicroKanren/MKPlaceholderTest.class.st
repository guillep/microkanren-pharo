Class {
	#name : #MKPlaceholderTest,
	#superclass : #TestCase,
	#category : 'MicroKanren-Tests'
}

{ #category : #tests }
MKPlaceholderTest >> testPlaceholderReifiesToSelf [
	| p s |
	
	p := MKPlaceholder withId: 0.
	s := MKState initial: MKEnv empty.
	
	self assert: (p reifyUsing: s) equals: p
]
