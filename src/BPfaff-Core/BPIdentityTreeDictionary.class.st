Class {
	#name : #BPIdentityTreeDictionary,
	#superclass : #BPTreeDictionary,
	#category : #'BPfaff-Core'
}

{ #category : #private }
BPIdentityTreeDictionary >> is: firstAssoc equalTo: secondAssoc [
	^ (firstAssoc key identityHash == secondAssoc key identityHash
		and: [ firstAssoc key == secondAssoc key ])
			ifTrue: [ 
				firstAssoc value: secondAssoc value.
				true ]
			ifFalse: [ false ]
]

{ #category : #private }
BPIdentityTreeDictionary >> is: assoc equalToKey: secondObject [
	^ assoc key identityHash == secondObject identityHash
		and: [ assoc key == secondObject ]
]

{ #category : #private }
BPIdentityTreeDictionary >> is: firstAssoc greaterThan: secondAssoc [
	^ firstAssoc key identityHash > secondAssoc key identityHash
]

{ #category : #private }
BPIdentityTreeDictionary >> is: assoc greaterThanKey: secondObject [
	^ assoc key identityHash > secondObject identityHash
]

{ #category : #private }
BPIdentityTreeDictionary >> is: firstAssoc lessThan: secondAssoc [
	^ firstAssoc key identityHash < secondAssoc key identityHash
]

{ #category : #private }
BPIdentityTreeDictionary >> is: assoc lessThanKey: secondObject [
	^ assoc key identityHash < secondObject identityHash
]
