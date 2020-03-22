Class {
	#name : #BPAVLTreeNode,
	#superclass : #Object,
	#instVars : [
		'model',
		'children',
		'balanceFactor',
		'direction'
	],
	#category : #'BPfaff-Core'
}

{ #category : #'instance creation' }
BPAVLTreeNode class >> with: anObject [
	^ self basicNew initializeModel: anObject
]

{ #category : #accessing }
BPAVLTreeNode >> balanceFactor [
	"balance factor: For any node in an AVL tree (see AVL tree), the difference between the height of the node's right subtree and left subtree. "

	"^ self right height - self left height"

	^ balanceFactor
]

{ #category : #accessing }
BPAVLTreeNode >> balanceFactor: anInteger [
	balanceFactor := anInteger
]

{ #category : #accessing }
BPAVLTreeNode >> balanceFactorBeZero [
	balanceFactor := 0
]

{ #category : #testing }
BPAVLTreeNode >> calculateBalanceFactor [
	"balance factor: For any node in an AVL tree (see AVL tree), the difference between the height of the node's right subtree and left subtree. "

	^ self right height - self left height
]

{ #category : #private }
BPAVLTreeNode >> childAtDirection [
	^ children at: direction
]

{ #category : #private }
BPAVLTreeNode >> childrenAtDirectionPut: anAVLTreeNode [
	children at: direction put: anAVLTreeNode
]

{ #category : #accessing }
BPAVLTreeNode >> childrenSize [
	^ children size
]

{ #category : #visiting }
BPAVLTreeNode >> depthFirstWithPreOrder: preOrderBlock andPostOrder: postOrderBlock [
	| visitStack |
	visitStack := OrderedCollection
		with: (Association key: self value: false).
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

{ #category : #private }
BPAVLTreeNode >> direction: anObject [
	direction := anObject
]

{ #category : #accessing }
BPAVLTreeNode >> height [
	"	^ (self left height max: self right height) + 1"

	| evalStack |
	evalStack := OrderedCollection new.
	self
		depthFirstWithPreOrder: nil
		andPostOrder: [ :node | 
			node isNullNode
				ifTrue: [ evalStack addFirst: node height ]
				ifFalse: [ | heightChildren |
					heightChildren := evalStack removeFirst: node childrenSize.
					evalStack
						addFirst: (heightChildren inject: 0 into: [ :max :each | max max: each ]) + 1 ] ].
	^ evalStack first
]

{ #category : #testing }
BPAVLTreeNode >> ifNull: aBlock [
	^ self
]

{ #category : #testing }
BPAVLTreeNode >> ifNull: firstBlock ifNotNull: secondBlock [ 
	^ secondBlock cull: self
]

{ #category : #initialization }
BPAVLTreeNode >> initialize [
	super initialize.
	children := {BPAVLNullNode new. BPAVLNullNode new}.
	balanceFactor := 0.
	direction := 1
]

{ #category : #initialization }
BPAVLTreeNode >> initializeModel: anObject [
	self initialize.
	model := anObject
]

{ #category : #testing }
BPAVLTreeNode >> isNullNode [
	^ false
]

{ #category : #accessing }
BPAVLTreeNode >> left [
	^ children first
]

{ #category : #accessing }
BPAVLTreeNode >> left: anAVLTreeNode [ 
	children at: 1 put: anAVLTreeNode
]

{ #category : #accessing }
BPAVLTreeNode >> model [
	^ model
]

{ #category : #printing }
BPAVLTreeNode >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	model printOn: aStream.
	aStream nextPut: $)
]

{ #category : #visiting }
BPAVLTreeNode >> reversedChildrenDo: aBlock [
	children reverseDo: aBlock
]

{ #category : #accessing }
BPAVLTreeNode >> right [
	^ children second
]

{ #category : #accessing }
BPAVLTreeNode >> right: anAVLTreeNode [
	children at: 2 put: anAVLTreeNode
]

{ #category : #private }
BPAVLTreeNode >> rotateLeft [
	"
3        
 \
 5  
/
4
=>
  5
 / 
3
 \
 4
"

	| pivot |
	pivot := self right.
	self right: pivot left.
	pivot left: self.
	^ pivot
]

{ #category : #private }
BPAVLTreeNode >> rotateLeftThenRight [
	self left: self left rotateLeft.
	^ self rotateRight
]

{ #category : #private }
BPAVLTreeNode >> rotateRight [
	"
  5        
 / 
3
 \
  4
=>
3
 \ 
  5
 / 
4
"
	| pivot |
	pivot := self left.
	self left: pivot right.
	pivot right: self.
	^ pivot
]

{ #category : #private }
BPAVLTreeNode >> rotateRightThenLeft [
	self right: self right rotateRight.
	^ self rotateLeft
]

{ #category : #accessing }
BPAVLTreeNode >> size [
	^ 1 + self left size + self right size
]

{ #category : #private }
BPAVLTreeNode >> updateBalanceFactor [
	balanceFactor := 
		direction == 1 
			ifTrue: [ balanceFactor - 1 ] 
			ifFalse: [ balanceFactor + 1 ]
]

{ #category : #private }
BPAVLTreeNode >> updateBalanceFactorsUpTo: newNode [
	| current |
	current := self.
	[ current isNullNode or: [ current == newNode ] ]
		whileFalse: [ 
			current updateBalanceFactor.
			current := current childAtDirection ]
]
