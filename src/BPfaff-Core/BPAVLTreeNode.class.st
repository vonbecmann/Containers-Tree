Class {
	#name : #BPAVLTreeNode,
	#superclass : #Object,
	#instVars : [
		'model',
		'children'
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

	^ self right height - self left height
]

{ #category : #accessing }
BPAVLTreeNode >> childrenAt: index put: anAVLTreeNode [
	children at: index put: anAVLTreeNode
]

{ #category : #accessing }
BPAVLTreeNode >> height [
	^ (self left height max: self right height) + 1
]

{ #category : #testing }
BPAVLTreeNode >> ifNull: firstBlock ifNotNull: secondBlock [ 
	^ secondBlock cull: self
]

{ #category : #initialization }
BPAVLTreeNode >> initialize [
	super initialize.
	children := {BPAVLNullNode new. BPAVLNullNode new}
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

{ #category : #accessing }
BPAVLTreeNode >> right [
	^ children second
]

{ #category : #accessing }
BPAVLTreeNode >> right: anAVLTreeNode [
	children at: 2 put: anAVLTreeNode
]

{ #category : #accessing }
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

{ #category : #accessing }
BPAVLTreeNode >> rotateLeftThenRight [
	self left: self left rotateLeft.
	^ self rotateRight
]

{ #category : #accessing }
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

{ #category : #accessing }
BPAVLTreeNode >> rotateRightThenLeft [
	self right: self right rotateRight.
	^ self rotateLeft
]

{ #category : #accessing }
BPAVLTreeNode >> size [
	^ 1 + self left size + self right size
]
