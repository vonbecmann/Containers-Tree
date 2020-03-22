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
	| parent current nonZeroNode nonZeroParentNode newNode pivot |
	parent := nil.
	current := nonZeroNode := nonZeroParentNode := root.
	[ current isNullNode ]
		whileFalse: [ 
			(self is: current model lessThan: anObject)
				ifTrue: [ 
					current direction: 2.
					current balanceFactor isZero
						ifFalse: [ 
							nonZeroNode := current.
							nonZeroParentNode := parent ].
					parent := current.
					current := current right ]
				ifFalse: [ 
					(self is: current model greaterThan: anObject)
						ifTrue: [ 
							current direction: 1.
							current balanceFactor isZero
								ifFalse: [ 
									nonZeroNode := current.
									nonZeroParentNode := parent ].
							parent := current.
							current := current left ]
						ifFalse: [ 
							(self is: current model equalTo: anObject)
								ifTrue: [ ^ current model ]
								ifFalse: [ self error ] ] ] ].
	newNode := self newTreeNodeWith: anObject.
	parent
		ifNil: [ root := newNode ]
		ifNotNil: [ parent childrenAtDirectionPut: newNode ].
	nonZeroNode ifNull: [ ^ anObject ].
	nonZeroNode updateBalanceFactorsUpTo: newNode.
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
											nonZeroNode balanceFactor: -1  ].
									pivot balanceFactor == 0 
										ifTrue: [
											rightChild balanceFactorBeZero.
											nonZeroNode balanceFactorBeZero ].
									pivot balanceFactor == -1 
										ifTrue: [ 
											rightChild balanceFactor: 1.
											nonZeroNode balanceFactorBeZero ].
									pivot balanceFactorBeZero ] ] ]
				ifFalse: [ ^ anObject ] ].
	nonZeroParentNode
		ifNil: [ root := pivot ]
		ifNotNil: [ nonZeroParentNode childrenAtDirectionPut: pivot ]. 
	^ anObject
]

{ #category : #testing }
BPAVLTree >> arrayRepresentation [
	| evalStack |
	evalStack := OrderedCollection new.
	self
		depthFirstWithPreOrder: nil
		andPostOrder: [ :node | 
			node isNullNode
				ifTrue: [ evalStack addFirst: #() ]
				ifFalse: [ | heightChildren |
					heightChildren := evalStack removeFirst: node childrenSize.
					evalStack addFirst: (Array with: node model with: heightChildren reversed) ] ].
	^ evalStack first
]

{ #category : #accessing }
BPAVLTree >> balanceFactor [
	^ root balanceFactor
]

{ #category : #visiting }
BPAVLTree >> depthFirstWithPreOrder: preOrderBlock andPostOrder: postOrderBlock [
	| visitStack |
	visitStack := OrderedCollection
		with: (Association key: root value: false).
	[ visitStack isEmpty ]
		whileFalse: [ | element node visited |
			element := visitStack first.
			node := element key.
			visited := element value.
			visited
				ifTrue: [ 
					visitStack removeFirst.
					postOrderBlock ifNotNil: [ postOrderBlock cull: node ] ]
				ifFalse: [ 
					element value: true.
					preOrderBlock ifNotNil: [ preOrderBlock cull: node ].
					node reversedChildrenDo: [ :child | 
						visitStack addFirst: (Association key: child value: false) ] ] ]
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

{ #category : #accessing }
BPAVLTree >> size [
	^ root size
]
