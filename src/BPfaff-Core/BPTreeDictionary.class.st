Class {
	#name : #BPTreeDictionary,
	#superclass : #BPAVLTree,
	#category : #'BPfaff-Core'
}

{ #category : #adding }
BPTreeDictionary >> add: anAssoc [
	| parent current direction nonZeroNode nonZeroParentNode nonZeroDirection |
	parent := nil.
	current := root.
	[ current isNullNode ]
		whileFalse: [ 
			(self is: current model lessThan: anAssoc)
				ifTrue: [ 
					direction := 2.
					current balanceFactor isZero
						ifFalse: [ 
							nonZeroNode := current.
							nonZeroParentNode := parent.
							nonZeroDirection := direction ].
					parent := current.
					current := current right ]
				ifFalse: [ 
					(self is: current model greaterThan: anAssoc)
						ifTrue: [ 
							direction := 1.
							current balanceFactor isZero
								ifFalse: [ 
									nonZeroNode := current.
									nonZeroParentNode := parent.
									nonZeroDirection := direction ].
							parent := current.
							current := current left ]
						ifFalse: [ 
							(self is: current model equalTo: anAssoc)
								ifTrue: [ ^ current model ]
								ifFalse: [ self error ] ] ] ].
	parent
		ifNil: [ root := self newTreeNodeWith: anAssoc ]
		ifNotNil: [ parent childrenAt: direction put: (self newTreeNodeWith: anAssoc) ].
	nonZeroNode isNil
		ifFalse: [ | nonZeroBalanceFactor pivot |
			nonZeroBalanceFactor := nonZeroNode balanceFactor.
			nonZeroBalanceFactor == -2
				ifTrue: [ | leftBalanceFactor |
					leftBalanceFactor := nonZeroNode left balanceFactor.
					leftBalanceFactor == -1
						ifTrue: [ pivot := nonZeroNode rotateRight ]
						ifFalse: [ 
							leftBalanceFactor == 1
								ifTrue: [ pivot := nonZeroNode rotateLeftThenRight ] ] ]
				ifFalse: [ 
					nonZeroBalanceFactor == 2
						ifTrue: [ | rightBalanceFactor |
							rightBalanceFactor := nonZeroNode right balanceFactor.
							rightBalanceFactor == 1
								ifTrue: [ pivot := nonZeroNode rotateLeft ]
								ifFalse: [ 
									rightBalanceFactor == -1
										ifTrue: [ pivot := nonZeroNode rotateRightThenLeft ] ] ] ].
			(nonZeroBalanceFactor == -2 or: [ nonZeroBalanceFactor == 2 ])
				ifTrue: [ 
					nonZeroParentNode
						ifNil: [ root := pivot ]
						ifNotNil: [ nonZeroParentNode childrenAt: nonZeroDirection put: pivot ] ] ].
	^ anAssoc
]

{ #category : #accessing }
BPTreeDictionary >> at: key [
	| current |
	current := root.
	[ current isNullNode ]
		whileFalse: [ 
			(self is: current model lessThanKey: key)
				ifTrue: [ current := current right ]
				ifFalse: [ 
					(self is: current model greaterThanKey: key)
						ifTrue: [ current := current left ]
						ifFalse: [ 
							(self is: current model equalToKey: key)
								ifTrue: [ ^ current model value ]
								ifFalse: [ self errorKeyNotFound: key ] ] ] ].
	self errorKeyNotFound: key
]

{ #category : #private }
BPTreeDictionary >> errorKeyNotFound: aKey [
	self
		error:
			(String
				streamContents: [ :stream | 
					stream << 'key '.
					stream print: aKey.
					stream << ' not found in '.
					stream print: self class ])
]

{ #category : #private }
BPTreeDictionary >> is: firstAssoc equalTo: secondAssoc [
	^ (firstAssoc key hash = secondAssoc key hash and: [ firstAssoc key = secondAssoc key ])
			ifTrue: [ 
				firstAssoc value: secondAssoc value.
				true ]
			ifFalse: [ false ]
]

{ #category : #private }
BPTreeDictionary >> is: assoc equalToKey: secondObject [
	^ assoc key hash = secondObject hash
		and: [ assoc key = secondObject ]
]

{ #category : #private }
BPTreeDictionary >> is: firstAssoc greaterThan: secondAssoc [
	^ firstAssoc key hash > secondAssoc key hash
]

{ #category : #private }
BPTreeDictionary >> is: assoc greaterThanKey: secondObject [
	^ assoc key hash > secondObject hash
]

{ #category : #private }
BPTreeDictionary >> is: firstAssoc lessThan: secondAssoc [
	^ firstAssoc key hash < secondAssoc key hash
]

{ #category : #private }
BPTreeDictionary >> is: assoc lessThanKey: secondObject [
	^ assoc key hash < secondObject hash
]

{ #category : #private }
BPTreeDictionary >> newTreeNodeWith: anAssociation [
	^ BPAVLTreeNode
		with: 	(Association key: anAssociation key value: anAssociation value)
]
