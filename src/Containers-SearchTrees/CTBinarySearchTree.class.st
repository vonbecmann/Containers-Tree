Class {
	#name : #CTBinarySearchTree,
	#superclass : #CTAbstractBinarySearchTree,
	#instVars : [
		'leftChild',
		'rightChild',
		'data'
	],
	#category : #'Containers-SearchTrees'
}

{ #category : #examples }
CTBinarySearchTree class >> binarySearchTree [
	<sampleInstance>
	| aTree |
	aTree := CTBinarySearchTree with: 8.
	aTree add: 3.
	aTree add: 10.
	aTree add: 1.
	aTree add: 6.
	^ aTree
]

{ #category : #'instance creation' }
CTBinarySearchTree class >> with: anObject [

	^ self new
	  data: anObject
]

{ #category : #'adding/removing' }
CTBinarySearchTree >> add: aData [

	data isNil 
		ifTrue: [ data := aData ].

	aData < data  
		ifTrue: [  leftChild := leftChild add: aData ].
	aData > data
		ifTrue: [ rightChild := rightChild add: aData ].
]

{ #category : #accessing }
CTBinarySearchTree >> data [
	^ data
]

{ #category : #accessing }
CTBinarySearchTree >> data: newData [
	data := newData 
]

{ #category : #operations }
CTBinarySearchTree >> depth [
	"Answer depth of a tree"

	^ self leftChild depth max: self rightChild  depth + 1
]

{ #category : #traversing }
CTBinarySearchTree >> findBreadthFirst: aBlock [
	"Answer a node that matches condition from passed block. The lookup is done in level order manner"
	
	| queue |	
	queue := OrderedCollection new.
	
	queue addLast: self.
	
	[ queue isNotEmpty ] whileTrue: [ 
		| node |
		node := queue removeFirst.
		
		node isNullNode
			ifTrue: [ ^ node ].
			
		(aBlock value: node )
			ifTrue: [^ node ].
			
		queue addLast: node leftChild.
		queue addLast: node rightChild ].
	

]

{ #category : #traversing }
CTBinarySearchTree >> findDeepFirst: aBlock [
	"Answer a node that matches condition specified in a block. The lookup is done in depth first search manner."
	
	| node |
	(aBlock value: self)
		ifTrue: [ ^ self ].

	node := self leftChild findDeepFirst: aBlock.

	(node isNullNode)
		ifTrue: [ node := self rightChild findDeepFirst: aBlock ].
		
	^ node

]

{ #category : #lookup }
CTBinarySearchTree >> findNode: aData [

	aData == data   
		ifTrue: [ ^ self ].
	aData < data  
		ifTrue: [ ^ (leftChild findNode: aData) ].
	aData > data   
		ifTrue: [ ^ (rightChild findNode: aData) ].

]

{ #category : #testing }
CTBinarySearchTree >> hasBothChildren [
	
	^ self isLeaf not
]

{ #category : #testing }
CTBinarySearchTree >> hasOnlyLeftChild [

	^ self rightChild isNullNode & self leftChild isNullNode not 
]

{ #category : #testing }
CTBinarySearchTree >> hasOnlyRightChild [

	^ leftChild isNullNode & rightChild isNullNode not
]

{ #category : #traversing }
CTBinarySearchTree >> inOrderDo: aBlock [
	"In-order traversing  executing a block on each node"

	self leftChild inOrderDo: aBlock.
	aBlock value: self.
	self rightChild inOrderDo: aBlock.
	
]

{ #category : #initialize }
CTBinarySearchTree >> initialize [

	super initialize.
	leftChild := CTNullBinaryTree uniqueInstance.
	rightChild := CTNullBinaryTree uniqueInstance.
]

{ #category : #testing }
CTBinarySearchTree >> isLeaf [

	^ leftChild isNullNode & rightChild isNullNode
]

{ #category : #testing }
CTBinarySearchTree >> isNullNode [

	^ false
]

{ #category : #accessing }
CTBinarySearchTree >> leftChild [

	^ leftChild
]

{ #category : #accessing }
CTBinarySearchTree >> leftmostNode: aNode [
	^ leftChild leftmostNode: self
]

{ #category : #operations }
CTBinarySearchTree >> maximumValue [

	^ (self rightmostNode: self) data
]

{ #category : #operations }
CTBinarySearchTree >> minimumValue [

	^ (self leftmostNode: self) data
]

{ #category : #traversing }
CTBinarySearchTree >> postOrderDo: aBlock [
	"Post-order traversing  executing a block on each node"

	self leftChild postOrderDo: aBlock.
	self rightChild postOrderDo: aBlock.
	aBlock value: self.
]

{ #category : #traversing }
CTBinarySearchTree >> preOrderDo: aBlock [
	"Pre-order traversing  executing a block on each node"

	aBlock value: self.
	self leftChild preOrderDo: aBlock.
	self rightChild preOrderDo: aBlock.
	
]

{ #category : #'adding/removing' }
CTBinarySearchTree >> remove: aData [
	| smallestNodeInRightSubtree |
	
	aData < data
		ifTrue: [ leftChild := leftChild remove: aData ].
	aData > data
		ifTrue: [ rightChild := rightChild remove: aData ].
		
	aData == data
		ifFalse: [ ^ self ].
		
	self isLeaf
		ifTrue: [ ^ CTNullBinaryTree uniqueInstance ].
		
	 "leftChild isNullNode not & rightChild isNullNode"
	self hasOnlyLeftChild 
		ifTrue: [ ^ leftChild ].
	self hasOnlyLeftChild
		ifTrue: [ ^ rightChild ].
		
	self hasBothChildren
		ifFalse: [ ^ self ].
		
	smallestNodeInRightSubtree := rightChild leftmostNode: self.
	data := smallestNodeInRightSubtree data.
	rightChild := rightChild remove: smallestNodeInRightSubtree data
]

{ #category : #accessing }
CTBinarySearchTree >> rightChild [

	^rightChild
]

{ #category : #accessing }
CTBinarySearchTree >> rightmostNode: aNode [
	^ rightChild rightmostNode: self
]

{ #category : #operations }
CTBinarySearchTree >> sizeOfTree [
	"Answer number of nodes in a tree"

	^ 1 + leftChild sizeOfTree + rightChild sizeOfTree 
]