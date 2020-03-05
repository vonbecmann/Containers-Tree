Class {
	#name : #BPAVLTreeNode,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'BPfaff-Core'
}

{ #category : #'instance creation' }
BPAVLTreeNode class >> with: anObject [
	^ self basicNew initializeModel: anObject
]

{ #category : #initialization }
BPAVLTreeNode >> initializeModel: anObject [
	model := anObject
]

{ #category : #accessing }
BPAVLTreeNode >> size [
	^ 1
]
