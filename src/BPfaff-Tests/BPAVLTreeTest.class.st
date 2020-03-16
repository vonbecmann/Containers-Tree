Class {
	#name : #BPAVLTreeTest,
	#superclass : #TestCase,
	#instVars : [
		'tree'
	],
	#category : #'BPfaff-Tests'
}

{ #category : #running }
BPAVLTreeTest >> setUp [
	super setUp.
	tree := BPAVLTree new
]

{ #category : #tests }
BPAVLTreeTest >> testAdd1 [
	self assert: tree size equals: 0.
	tree add: 3.
	self assert: tree size equals: 1
]

{ #category : #tests }
BPAVLTreeTest >> testAdd2 [
	tree add: 1.
	self assert: tree size equals: 1.
	tree add: 3.
	self assert: tree size equals: 2
]

{ #category : #tests }
BPAVLTreeTest >> testAdd3 [
	tree add: 2.
	self assert: tree size equals: 1.
	tree add: 1.
	self assert: tree size equals: 2
]

{ #category : #tests }
BPAVLTreeTest >> testAdd4 [
	tree add: 2.
	self assert: tree size equals: 1.
	tree add: 2.
	self assert: tree size equals: 1
]

{ #category : #tests }
BPAVLTreeTest >> testAdd5 [
	tree add: 6.
	tree add: 5.
	tree add: 4.
	self assert: tree size equals: 3.
	self assert: tree height equals: 2.
	self assert: tree balanceFactor equals: 0
	
]

{ #category : #tests }
BPAVLTreeTest >> testAdd6 [
	tree add: 6.
	tree add: 4.
	tree add: 5.
	self assert: tree size equals: 3.
	self assert: tree height equals: 2.
	self assert: tree balanceFactor equals: 0
	
]

{ #category : #tests }
BPAVLTreeTest >> testAdd7 [
	tree add: 4.
	tree add: 5.
	tree add: 6.
	self assert: tree size equals: 3.
	self assert: tree height equals: 2.
	self assert: tree balanceFactor equals: 0
]

{ #category : #tests }
BPAVLTreeTest >> testAdd8 [
	tree add: 4.
	tree add: 6.
	tree add: 5.
	self assert: tree size equals: 3.
	self assert: tree height equals: 2.
	self assert: tree balanceFactor equals: 0
]

{ #category : #tests }
BPAVLTreeTest >> testBalanceFactor [
	self assert: tree balanceFactor equals: 0
]

{ #category : #tests }
BPAVLTreeTest >> testBalanceFactor2 [
	tree add: 3.
	self assert: tree balanceFactor equals: 0
]

{ #category : #tests }
BPAVLTreeTest >> testBalanceFactor3 [
	tree add: 3.
	tree add: 2.
	self assert: tree balanceFactor equals: -1
]

{ #category : #tests }
BPAVLTreeTest >> testBalanceFactor4 [
	tree add: 2.
	tree add: 3.
	self assert: tree balanceFactor equals: 1
]

{ #category : #tests }
BPAVLTreeTest >> testHeight [
	self assert: tree height equals: 0
]

{ #category : #tests }
BPAVLTreeTest >> testHeight2 [
	tree add: 3.
	self assert: tree height equals: 1
]

{ #category : #tests }
BPAVLTreeTest >> testHeight3 [
	tree add: 3.
	tree add: 2.
	self assert: tree height equals: 2
]

{ #category : #tests }
BPAVLTreeTest >> testHeight4 [
	tree add: 3.
	tree add: 5.
	self assert: tree height equals: 2
]

{ #category : #tests }
BPAVLTreeTest >> testIsEmpty [
	self assert: tree isEmpty
]

{ #category : #tests }
BPAVLTreeTest >> testIsEmpty2 [
	tree add: 5.
	self deny: tree isEmpty
]

{ #category : #tests }
BPAVLTreeTest >> testSize [
	self assert: tree size equals: 0
]

{ #category : #tests }
BPAVLTreeTest >> testSize2 [
	tree add: 3.
	self assert: tree size equals: 1
]

{ #category : #tests }
BPAVLTreeTest >> testSize3 [
	tree add: 3.
	tree add: 2.
	self assert: tree size equals: 2
]
