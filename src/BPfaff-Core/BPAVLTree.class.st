Class {
	#name : #BPAVLTree,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #'BPfaff-Core'
}

{ #category : #'instance creation' }
BPAVLTree class >> with: anObject [
	^ self new
		add: anObject;
		yourself
]

{ #category : #visiting }
BPAVLTree >> acceptVisitor: aTreeVisitor [
	aTreeVisitor visitNode: root
]

{ #category : #adding }
BPAVLTree >> add: anObject [
	| parent current nonZeroNode nonZeroParentNode newNode pivot |
	parent := BPAVLNullNode uniqueInstance.
	current := nonZeroNode := nonZeroParentNode := root.
	[ current isNullNode ]
		whileFalse: [ (self is: current model lessThan: anObject)
				ifTrue: [ current direction: 2.
					current balanceFactor == 0
						ifFalse: [ nonZeroNode := current.
							nonZeroParentNode := parent ].
					parent := current.
					current := current right ]
				ifFalse: [ (self is: current model greaterThan: anObject)
						ifTrue: [ current direction: 1.
							current balanceFactor == 0
								ifFalse: [ nonZeroNode := current.
									nonZeroParentNode := parent ].
							parent := current.
							current := current left ]
						ifFalse: [ (self is: current model equalTo: anObject)
								ifTrue: [ ^ current model ]
								ifFalse: [ self error ] ] ] ].
	newNode := self newTreeNodeWith: anObject.
	parent
		ifNull: [ root := newNode ]
		ifNotNull: [ parent childrenAtDirectionPut: newNode ].
	nonZeroNode ifNull: [ ^ anObject ].
	nonZeroNode updateBalanceFactorsUpTo: newNode.
	pivot := self rebalance: nonZeroNode ifNotNecessary: [ ^ anObject ].
	nonZeroParentNode
		ifNull: [ root := pivot ]
		ifNotNull: [ nonZeroParentNode childrenAtDirectionPut: pivot ].
	^ anObject
]

{ #category : #testing }
BPAVLTree >> arrayRepresentation [
	| evalStack |
	evalStack := OrderedCollection new.
	BPDepthFirstVisitor new 
	   	postOrderBlock: [ :node | 
			node isNullNode
				ifTrue: [ evalStack addFirst: #() ]
				ifFalse: [ | heightChildren |
					heightChildren := evalStack removeFirst: node childrenSize.
					evalStack addFirst: (Array with: node model with: heightChildren reversed) ] ];
		visit: self.
	^ evalStack first
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
	root := BPAVLNullNode uniqueInstance
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
BPAVLTree >> isBalanceFactorCorrect [
	^ root balanceFactor = root calculateBalanceFactor
]

{ #category : #testing }
BPAVLTree >> isEmpty [
	^ root isNullNode
]

{ #category : #private }
BPAVLTree >> newTreeNodeWith: anObject [
	^ BPAVLTreeNode with: anObject
]

{ #category : #private }
BPAVLTree >> rebalance: nonZeroNode ifNotNecessary: aBlock [
	| pivot |
	nonZeroNode balanceFactor == -2
		ifTrue: [ | leftChild |
			leftChild := nonZeroNode left.
			leftChild balanceFactor == -1
				ifTrue: [ 
					pivot := nonZeroNode rotateRight.
					leftChild balanceFactorBeZero.
					nonZeroNode balanceFactorBeZero ]
				ifFalse: [ 
					leftChild balanceFactor == 1
						ifTrue: [ 
							pivot := nonZeroNode rotateLeftThenRight.
							pivot balanceFactor == -1
								ifTrue: [ 
									leftChild balanceFactorBeZero.
									nonZeroNode balanceFactor: 1 ].
							pivot balanceFactor == 0
								ifTrue: [ 
									leftChild balanceFactorBeZero.
									nonZeroNode balanceFactorBeZero ].
							pivot balanceFactor == 1
								ifTrue: [ 
									leftChild balanceFactor: -1.
									nonZeroNode balanceFactorBeZero ].
							pivot balanceFactorBeZero ] ] ]
		ifFalse: [ 
			nonZeroNode balanceFactor == 2
				ifTrue: [ | rightChild |
					rightChild := nonZeroNode right.
					rightChild balanceFactor == 1
						ifTrue: [ 
							pivot := nonZeroNode rotateLeft.
							rightChild balanceFactorBeZero.
							nonZeroNode balanceFactorBeZero ]
						ifFalse: [ 
							rightChild balanceFactor == -1
								ifTrue: [ 
									pivot := nonZeroNode rotateRightThenLeft.
									pivot balanceFactor == 1
										ifTrue: [ 
											rightChild balanceFactorBeZero.
											nonZeroNode balanceFactor: -1 ].
									pivot balanceFactor == 0
										ifTrue: [ 
											rightChild balanceFactorBeZero.
											nonZeroNode balanceFactorBeZero ].
									pivot balanceFactor == -1
										ifTrue: [ 
											rightChild balanceFactor: 1.
											nonZeroNode balanceFactorBeZero ].
									pivot balanceFactorBeZero ] ] ]
				ifFalse: [ aBlock value ] ].
	^ pivot
]

{ #category : #'initialize-release' }
BPAVLTree >> release [
	root := nil.
	super release
]

{ #category : #accessing }
BPAVLTree >> size [
	^ root size
]
