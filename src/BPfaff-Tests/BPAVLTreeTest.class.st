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
BPAVLTreeTest >> testHeight [
	self assert: tree height equals: 0
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
