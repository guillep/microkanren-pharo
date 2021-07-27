Extension { #name : #Object }

{ #category : #'*MicroKanren-goal combinators' }
Object >> @@ anObject [
	^ MKUnifyGoal unify: self with: anObject
]

{ #category : #'*MicroKanren-reification' }
Object >> reifyUsing: aState [ 
	^ self
]

{ #category : #'*MicroKanren-unification' }
Object >> unifyWith: anObject on: anEnv [ 
	^ (anObject walkOver: anEnv) unifyWithObject: self on: anEnv
]

{ #category : #'*MicroKanren-unification' }
Object >> unifyWithCons: aCons on: anEnv [  
	^ self unifyWithObject: aCons on: anEnv
]

{ #category : #'*MicroKanren-unification' }
Object >> unifyWithObject: anObject on: anEnv [ 
	self = anObject ifTrue: [ ^ anEnv ].
	^ nil
]

{ #category : #'*MicroKanren-unification' }
Object >> unifyWithVar: aVar using: anEnv [
	^ (aVar walkOver: anEnv) unifyWithCons: self on: anEnv

]

{ #category : #'*MicroKanren-unification' }
Object >> walkOver: anEnv [ 
	^ self
]
