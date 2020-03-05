Class {
	#name : #AVLTreeTest,
	#superclass : #TestCase,
	#instVars : [
		'tree'
	],
	#category : #'BPfaff-Tests'
}

{ #category : #running }
AVLTreeTest >> setUp [
	super setUp.
	tree := AVLTree new
]

{ #category : #tests }
AVLTreeTest >> testAdd3 [
  tree add: 3.

]
