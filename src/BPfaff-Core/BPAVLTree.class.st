Class {
	#name : #BPAVLTree,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #'BPfaff-Core'
}

{ #category : #'as yet unclassified' }
BPAVLTree class >> with: anInteger [
	^ self new
		add: anInteger;
		yourself
]

{ #category : #adding }
BPAVLTree >> add: anObject [
	| parent current visited direction newNode |
	parent := nil.
	current := root.
	visited := OrderedCollection new.
	[ current isNullNode ]
		whileFalse: [ 
			(self is: current model lessThan: anObject)
				ifTrue: [ direction := 2.
					visited addFirst: current.
					parent := current.
					current := current right ]
				ifFalse: [ 
					(self is: current model greaterThan: anObject)
						ifTrue: [ direction := 1.
							visited addFirst: current.
							parent := current.
							current := current left ]
						ifFalse: [ 
							(self is: current model equalTo: anObject)
								ifTrue: [ ^ current model ]
								ifFalse: [ self error ] ] ] ].
	newNode := BPAVLTreeNode with: anObject.
	parent
		ifNil: [ root := newNode ]
		ifNotNil: [ parent childrenAt: direction put: newNode ].
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

{ #category : #private }
BPAVLTree >> is: firstObject equalTo: secondObject [
	^ firstObject hash = secondObject hash
		and: [ firstObject = secondObject ]
]

{ #category : #private }
BPAVLTree >> is: firstObject greaterThan: secondObject [
	^ firstObject hash > secondObject hash
]

{ #category : #private }
BPAVLTree >> is: firstObject lessThan: secondObject [
	^ firstObject hash < secondObject hash
]

{ #category : #testing }
BPAVLTree >> isEmpty [
	^ root isNullNode
]

{ #category : #accessing }
BPAVLTree >> size [
	^ root size
]
