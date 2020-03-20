Class {
	#name : #BPTreeDictionary,
	#superclass : #BPAVLTree,
	#category : #'BPfaff-Core'
}

{ #category : #adding }
BPTreeDictionary >> add: anAssoc [
	| parent current visited direction |
	parent := nil.
	current := root.
	visited := OrderedCollection new.
	[ current isNullNode ]
		whileFalse: [ 
			(self is: current model lessThan: anAssoc)
				ifTrue: [ 
					direction := 2.
					current balanceFactor isZero
						ifFalse: [ visited addFirst: (Array with: parent with: direction with:	current) ].
					parent := current.
					current := current right ]
				ifFalse: [ 
					(self is: current model greaterThan: anAssoc)
						ifTrue: [ 
							direction := 1.
							current balanceFactor isZero
								ifFalse: [ visited addFirst: (Array with: parent with: direction with:	current) ].
							parent := current.
							current := current left ]
						ifFalse: [ 
							(self is: current model equalTo: anAssoc)
								ifTrue: [ 
									current model value: anAssoc value.
									^ current model ]
								ifFalse: [ self error ] ] ] ].
	parent
		ifNil: [ root := self newTreeNodeWith: anAssoc ]
		ifNotNil: [ parent childrenAt: direction put: (self newTreeNodeWith: anAssoc) ].
	[ visited isEmpty ]
		whileFalse: [ | currentBalanceFactor pivot |
			parent := visited first first.
			direction := visited first second.
			current := visited removeFirst third.
			currentBalanceFactor := current balanceFactor.
			currentBalanceFactor == -2
				ifTrue: [ | leftBalanceFactor |
					leftBalanceFactor := current left balanceFactor.
					leftBalanceFactor == -1
						ifTrue: [ pivot := current rotateRight ]
						ifFalse: [ 
							leftBalanceFactor == 1
								ifTrue: [ pivot := current rotateLeftThenRight ] ] ]
				ifFalse: [ 
					currentBalanceFactor == 2
						ifTrue: [ | rightBalanceFactor |
							rightBalanceFactor := current right balanceFactor.
							rightBalanceFactor == 1
								ifTrue: [ pivot := current rotateLeft ]
								ifFalse: [ 
									rightBalanceFactor == -1
										ifTrue: [ pivot := current rotateRightThenLeft ] ] ] ].
			(currentBalanceFactor == -2 or: [currentBalanceFactor == 2]) 
				ifTrue: [ 
					parent
						ifNil: [ root := pivot ]
						ifNotNil: [ parent childrenAt: direction put: pivot ] ]
			] .
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
						ifTrue: [	current := current left ]
						ifFalse: [ 
							(self is: current model equalToKey: key)
								ifTrue: [ ^ current model value ]
								ifFalse: [ self error ] ] ] ].
	self error
]

{ #category : #private }
BPTreeDictionary >> is: firstObject equalTo: secondObject [
	^ firstObject key hash = secondObject key hash
		and: [ firstObject key = secondObject key ]
]

{ #category : #private }
BPTreeDictionary >> is: assoc equalToKey: secondObject [
	^ assoc key hash = secondObject hash
		and: [ assoc key = secondObject ]
]

{ #category : #private }
BPTreeDictionary >> is: firstObject greaterThan: secondObject [
	^ firstObject key hash > secondObject key hash
]

{ #category : #private }
BPTreeDictionary >> is: assoc greaterThanKey: secondObject [
	^ assoc key hash > secondObject hash
]

{ #category : #private }
BPTreeDictionary >> is: firstObject lessThan: secondObject [
	^ firstObject key hash < secondObject key hash
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
