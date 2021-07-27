"
An MKVar is a placeholder for a value in an environment (see MKEnv).


"
Class {
	#name : #MKVar,
	#superclass : #Object,
	#category : 'MicroKanren-Core'
}

{ #category : #'instance creation' }
MKVar class >> fresh: aBlockClosure [ 
	| args |

	args := Array new: aBlockClosure numArgs.

	1 to: args size do: [ :i |
		args at: i put: MKVar new ].

	^ aBlockClosure valueWithArguments: args
]

{ #category : #reification }
MKVar >> reifyUsing: aState [
	^ aState valueAt: self
]

{ #category : #unification }
MKVar >> unifyWith: anObject on: anEnv [
	^ (anObject walkOver: anEnv) unifyWithVar: self using: anEnv
]

{ #category : #unification }
MKVar >> unifyWithObject: anObject on: anEnv [
	^ anEnv bind: self to: (anObject walkOver: anEnv)
]

{ #category : #unification }
MKVar >> unifyWithVar: aVar using: anEnv [
	^ self unifyWithObject: aVar on: anEnv
]

{ #category : #unification }
MKVar >> walkOver: anEnv [ 
	| value |

	value := anEnv valueAt: self ifAbsent: [ self ].
	value = self ifTrue: [ ^ self ].

	^ value walkOver: anEnv
]
