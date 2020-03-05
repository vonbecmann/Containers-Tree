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
BPAVLTreeTest >> testAdd3 [
	self assert: tree size equals: 0.
	tree add: 3.
	self assert: tree size equals: 1
]

{ #category : #tests }
BPAVLTreeTest >> testHeight [
	self assert: tree height equals: 0
]

{ #category : #tests }
BPAVLTreeTest >> testSize [
	self assert: tree size equals: 0
]
