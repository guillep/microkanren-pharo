Extension { #name : #SequenceableCollection }

{ #category : #'*MicroKanren-conversion' }
SequenceableCollection >> asMKCons [
	| c |
	
	c:= nil.
	
	self size to: 1 by: -1 do: [ :i | 
		c := MKCons head: (self at: i) tail: c ].
	
	^ c
]
