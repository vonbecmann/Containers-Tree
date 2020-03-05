Class {
	#name : #BPAVLNullNode,
	#superclass : #Object,
	#category : #'BPfaff-Core'
}

{ #category : #accessing }
BPAVLNullNode >> height [
	^ 0
]

{ #category : #'as yet unclassified' }
BPAVLNullNode >> ifNull: aBlockClosure [
	^ aBlockClosure value
]

{ #category : #accessing }
BPAVLNullNode >> size [
	^ 0
]
