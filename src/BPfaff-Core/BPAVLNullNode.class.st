Class {
	#name : #BPAVLNullNode,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'BPfaff-Core'
}

{ #category : #'initialization-release' }
BPAVLNullNode class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #'instance creation' }
BPAVLNullNode class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
BPAVLNullNode >> balanceFactor [
	^ 0
]

{ #category : #testing }
BPAVLNullNode >> calculateBalanceFactor [
	^ self balanceFactor
]

{ #category : #accessing }
BPAVLNullNode >> height [
	^ 0
]

{ #category : #testing }
BPAVLNullNode >> ifNull: aBlock [
	^ aBlock cull: self
]

{ #category : #testing }
BPAVLNullNode >> ifNull: firstBlock ifNotNull: secondBlock [
	^ firstBlock value
]

{ #category : #testing }
BPAVLNullNode >> isNullNode [
	^ true
]

{ #category : #visiting }
BPAVLNullNode >> reversedChildrenDo: aBlock [
	"nothing to do"

	
]

{ #category : #accessing }
BPAVLNullNode >> size [
	^ 0
]
