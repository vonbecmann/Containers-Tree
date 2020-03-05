Class {
	#name : #BPAVLTree,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #'BPfaff-Core'
}

{ #category : #adding }
BPAVLTree >> add: anObject [
	root ifNull: [ root := BPAVLTreeNode with: anObject ].
	^ anObject
]

{ #category : #accessing }
BPAVLTree >> height [
	^ root height
]

{ #category : #initialization }
BPAVLTree >> initialize [
	root := BPAVLNullNode new
]

{ #category : #accessing }
BPAVLTree >> size [
	^ root size
]
