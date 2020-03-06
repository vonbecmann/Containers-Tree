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

{ #category : #accessing }
BPAVLTreeNode >> right [
	^ children second
]

{ #category : #accessing }
BPAVLTreeNode >> right: anAVLTreeNode [
	children at: 2 put: anAVLTreeNode
]

{ #category : #accessing }
BPAVLTreeNode >> size [
	^ 1 + self left size + self right size
]
