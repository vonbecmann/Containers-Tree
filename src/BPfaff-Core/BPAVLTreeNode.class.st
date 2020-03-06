Class {
	#name : #BPAVLTreeNode,
	#superclass : #Object,
	#instVars : [
		'model',
		'left',
		'right'
	],
	#category : #'BPfaff-Core'
}

{ #category : #'instance creation' }
BPAVLTreeNode class >> with: anObject [
	^ self basicNew initializeModel: anObject
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
	left := right := BPAVLNullNode new
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
	^ left
]

{ #category : #accessing }
BPAVLTreeNode >> left: anAVLTreeNode [ 
	left := anAVLTreeNode
]

{ #category : #accessing }
BPAVLTreeNode >> model [
	^ model
]

{ #category : #accessing }
BPAVLTreeNode >> right [
	^ right
]

{ #category : #accessing }
BPAVLTreeNode >> right: anAVLTreeNode [ 
	right := anAVLTreeNode
]

{ #category : #accessing }
BPAVLTreeNode >> size [
	^ 1 + left size + right size
]
