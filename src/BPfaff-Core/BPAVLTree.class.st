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
	root
		ifNull: [ root := BPAVLTreeNode with: anObject ]
		ifNotNull: [ | parent current direction visited |
			parent := nil.
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
			direction
				ifTrue: [ parent right: (BPAVLTreeNode with: anObject) ]
				ifFalse: [ parent left: (BPAVLTreeNode with: anObject) ] ].
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
