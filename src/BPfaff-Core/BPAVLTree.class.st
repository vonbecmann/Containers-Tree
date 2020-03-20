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
	| parent current visited direction |
	parent := nil.
	current := root.
	visited := OrderedCollection new.
	[ current isNullNode ]
		whileFalse: [ 
			(self is: current model lessThan: anObject)
				ifTrue: [ 
					direction := 2.
					current balanceFactor isZero
						ifFalse: [ visited addFirst: (Array with: parent with: direction with:	current) ].
					parent := current.
					current := current right ]
				ifFalse: [ 
					(self is: current model greaterThan: anObject)
						ifTrue: [ 
							direction := 1.
							current balanceFactor isZero
								ifFalse: [ visited addFirst: (Array with: parent with: direction with:	current) ].
							parent := current.
							current := current left ]
						ifFalse: [ 
							(self is: current model equalTo: anObject)
								ifTrue: [ ^ current model ]
								ifFalse: [ self error ] ] ] ].
	parent
		ifNil: [ root := self newTreeNodeWith: anObject ]
		ifNotNil: [ parent childrenAt: direction put: (self newTreeNodeWith: anObject) ].
	[ visited isEmpty ]
		whileFalse: [ | currentBalanceFactor pivot |
			parent := visited first first.
			direction := visited first second.
			current := visited removeFirst third.
			currentBalanceFactor := current balanceFactor.
			currentBalanceFactor == -2
				ifTrue: [ | leftBalanceFactor |
					leftBalanceFactor := current left balanceFactor.
					leftBalanceFactor == -1
						ifTrue: [ pivot := current rotateRight ]
						ifFalse: [ 
							leftBalanceFactor == 1
								ifTrue: [ pivot := current rotateLeftThenRight ] ] ]
				ifFalse: [ 
					currentBalanceFactor == 2
						ifTrue: [ | rightBalanceFactor |
							rightBalanceFactor := current right balanceFactor.
							rightBalanceFactor == 1
								ifTrue: [ pivot := current rotateLeft ]
								ifFalse: [ 
									rightBalanceFactor == -1
										ifTrue: [ pivot := current rotateRightThenLeft ] ] ] ].
			(currentBalanceFactor == -2 or: [currentBalanceFactor == 2]) 
				ifTrue: [ 
					parent
						ifNil: [ root := pivot ]
						ifNotNil: [ parent childrenAt: direction put: pivot ] ]
			] .
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
