Class {
	#name : #BPAVLNullNode,
	#superclass : #Object,
	#category : #'BPfaff-Core'
}

{ #category : #accessing }
BPAVLNullNode >> balanceFactor [
	^ 0
]

{ #category : #accessing }
BPAVLNullNode >> height [
	^ 0
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
