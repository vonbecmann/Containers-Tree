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
	| parent current visited direction newNode |
	parent := nil.
	current := root.
	visited := OrderedCollection new.
	[ current isNullNode ]
		whileFalse: [ (self is: current model lessThan: anObject)
				ifTrue: [ direction := 2.
					visited
						addFirst:
							{parent.
							direction.
							current}.
					parent := current.
					current := current right ]
				ifFalse: [ (self is: current model greaterThan: anObject)
						ifTrue: [ direction := 1.
							visited
								addFirst:
									{parent.
									direction.
									current}.
							parent := current.
							current := current left ]
						ifFalse: [ (self is: current model equalTo: anObject)
								ifTrue: [ ^ current model ]
								ifFalse: [ self error ] ] ] ].
	newNode := BPAVLTreeNode with: anObject.
	parent
		ifNil: [ root := newNode ]
		ifNotNil: [ parent childrenAt: direction put: newNode ].
	[ visited isEmpty ]
		whileFalse: [ | currentBalanceFactor |
			parent := visited first first.
			direction := visited first second.
			current := visited removeFirst third.
			currentBalanceFactor := current balanceFactor.
			currentBalanceFactor == -2
				ifTrue: [ | leftChild leftBalanceFactor |
					leftChild := current left.
					leftBalanceFactor := leftChild balanceFactor.
					leftBalanceFactor == -1
						ifTrue: [ | pivot |
							pivot := current rotateRight.
							parent
								ifNil: [ root := pivot ]
								ifNotNil: [ parent childrenAt: direction put: pivot ] ]
						ifFalse: [ leftBalanceFactor == 1
								ifTrue: [ | pivot |
									current left: leftChild rotateLeft.
									pivot := current rotateRight.
									parent
										ifNil: [ root := pivot ]
										ifNotNil: [ parent childrenAt: direction put: pivot ] ] ] ]
				ifFalse: [ currentBalanceFactor == 2
						ifTrue: [ | rightChild rightBalanceFactor |
							rightChild := current right.
							rightBalanceFactor := rightChild balanceFactor.
							rightBalanceFactor == 1
								ifTrue: [ | pivot |
									pivot := current rotateLeft.
									parent
										ifNil: [ root := pivot ]
										ifNotNil: [ parent childrenAt: direction put: pivot ] ]
								ifFalse: [ rightBalanceFactor == -1
										ifTrue: [ | pivot |
											current right: rightChild rotateRight.
											pivot := current rotateLeft.
											parent
												ifNil: [ root := pivot ]
												ifNotNil: [ parent childrenAt: direction put: pivot ] ] ] ] ] ].
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

{ #category : #accessing }
BPAVLTree >> size [
	^ root size
]
