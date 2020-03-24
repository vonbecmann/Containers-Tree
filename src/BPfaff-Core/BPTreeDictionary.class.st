Class {
	#name : #BPTreeDictionary,
	#superclass : #BPAVLTree,
	#category : #'BPfaff-Core'
}

{ #category : #accessing }
BPTreeDictionary >> at: key [
	^ self at: key ifAbsent: [ self errorKeyNotFound: key ]
]

{ #category : #accessing }
BPTreeDictionary >> at: key ifAbsent: aBlock [
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
								ifFalse: [ self error ] ] ] ].
	^ aBlock value
]

{ #category : #accessing }
BPTreeDictionary >> at: key ifAbsentPut: aBlock [
	"Return the value at the given key.
	If the key is not included in the receiver store and return the result 
	of evaluating aBlock as the new value."

	^ self at: key ifAbsent: [ self at: key put: aBlock value ]
]

{ #category : #accessing }
BPTreeDictionary >> at: key put: anObject [
	self add: (Association basicNew key: key value: anObject).
	^ anObject
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
		with:
			(Association basicNew
				key: anAssociation key
				value: anAssociation value)
]
