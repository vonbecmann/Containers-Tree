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
	| parent current direction visited newNode |
	parent := BPAVLNullNode new.
	current := root.
	visited := OrderedCollection new.
	[ current isNullNode ]
		whileFalse: [ current model < anObject
				ifTrue: [ direction := true.
					visited addFirst: current.
					parent := current.
					current := current right ]
				ifFalse: [ current model > anObject
						ifTrue: [ direction := false.
							visited addFirst: current.
							parent := current.
							current := current left ]
						ifFalse: [ current model = anObject
								ifTrue: [ ^ current model ] ] ] ].
	newNode := BPAVLTreeNode with: anObject.
	parent
		ifNull: [ root := newNode ]
		ifNotNull: [ direction
				ifTrue: [ parent right: newNode ]
				ifFalse: [ parent left: newNode ] ].
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
