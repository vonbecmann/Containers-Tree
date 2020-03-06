Class {
	#name : #BPAVLNullNode,
	#superclass : #Object,
	#category : #'BPfaff-Core'
}

{ #category : #accessing }
BPAVLNullNode >> height [
	^ 0
]

{ #category : #testing }
BPAVLNullNode >> ifNull: aBlock [
	^ aBlock value
]

{ #category : #testing }
BPAVLNullNode >> ifNull: firstBlock ifNotNull: secondBlock [
	^ firstBlock value
]

{ #category : #testing }
BPAVLNullNode >> isNullNode [
	^ true
]

{ #category : #accessing }
BPAVLNullNode >> size [
	^ 0
]
