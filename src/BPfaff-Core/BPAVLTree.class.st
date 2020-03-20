Class {
	#name : #BPAVLTree,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #'BPfaff-Core'
}

{ #category : #'as yet unclassified' }
BPAVLTree class >> with: anInteger [
	^ self new
		add: anInteger;
		yourself
]

{ #category : #adding }
BPAVLTree >> add: anObject [
	| parent current direction nonZeroNode nonZeroParentNode nonZeroDirection pivot |
	parent := nil.
	current := root.
	[ current isNullNode ]
		whileFalse: [ 
			(self is: current model lessThan: anObject)
				ifTrue: [ 
					direction := 2.
					current balanceFactor isZero
						ifFalse: [ 
							nonZeroNode := current.
							nonZeroParentNode := parent.
							nonZeroDirection := direction ].
					parent := current.
					current := current right ]
				ifFalse: [ 
					(self is: current model greaterThan: anObject)
						ifTrue: [ 
							direction := 1.
							current balanceFactor isZero
								ifFalse: [ 
									nonZeroNode := current.
									nonZeroParentNode := parent.
									nonZeroDirection := direction ].
							parent := current.
							current := current left ]
						ifFalse: [ 
							(self is: current model equalTo: anObject)
								ifTrue: [ ^ current model ]
								ifFalse: [ self error ] ] ] ].
	parent
		ifNil: [ root := self newTreeNodeWith: anObject ]
		ifNotNil: [ parent childrenAt: direction put: (self newTreeNodeWith: anObject) ].
	nonZeroNode isNil
		ifFalse: [ | nonZeroBalanceFactor |
			nonZeroBalanceFactor := nonZeroNode balanceFactor.
			nonZeroBalanceFactor == -2
				ifTrue: [ | leftBalanceFactor |
					leftBalanceFactor := nonZeroNode left balanceFactor.
					leftBalanceFactor == -1
						ifTrue: [ pivot := nonZeroNode rotateRight ]
						ifFalse: [ 
							leftBalanceFactor == 1
								ifTrue: [ pivot := nonZeroNode rotateLeftThenRight ] ] ]
				ifFalse: [ 
					nonZeroBalanceFactor == 2
						ifTrue: [ | rightBalanceFactor |
							rightBalanceFactor := nonZeroNode right balanceFactor.
							rightBalanceFactor == 1
								ifTrue: [ pivot := nonZeroNode rotateLeft ]
								ifFalse: [ 
									rightBalanceFactor == -1
										ifTrue: [ pivot := nonZeroNode rotateRightThenLeft ] ] ] ].
			(nonZeroBalanceFactor == -2 or: [ nonZeroBalanceFactor == 2 ])
				ifTrue: [ 
					nonZeroParentNode
						ifNil: [ root := pivot ]
						ifNotNil: [ nonZeroParentNode childrenAt: nonZeroDirection put: pivot ] ] ].
	^ anObject
]

{ #category : #accessing }
BPAVLTree >> balanceFactor [
	^ root balanceFactor
]

{ #category : #accessing }
BPAVLTree >> height [
	^ root height
]

{ #category : #initialization }
BPAVLTree >> initialize [
	root := BPAVLNullNode new
]

{ #category : #private }
BPAVLTree >> is: firstObject equalTo: secondObject [
	^ firstObject hash = secondObject hash
		and: [ firstObject = secondObject ]
]

{ #category : #private }
BPAVLTree >> is: firstObject greaterThan: secondObject [
	^ firstObject hash > secondObject hash
]

{ #category : #private }
BPAVLTree >> is: firstObject lessThan: secondObject [
	^ firstObject hash < secondObject hash
]

{ #category : #testing }
BPAVLTree >> isEmpty [
	^ root isNullNode
]

{ #category : #private }
BPAVLTree >> newTreeNodeWith: anObject [
	^ BPAVLTreeNode with: anObject
]

{ #category : #accessing }
BPAVLTree >> size [
	^ root size
]
