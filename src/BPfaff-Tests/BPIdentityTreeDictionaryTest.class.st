Class {
	#name : #BPIdentityTreeDictionaryTest,
	#superclass : #BPTreeDictionaryTest,
	#category : #'BPfaff-Tests'
}

{ #category : #running }
BPIdentityTreeDictionaryTest >> setUp [
	super setUp.
	dict := BPIdentityTreeDictionary new
]

{ #category : #tests }
BPIdentityTreeDictionaryTest >> testIdentity [
	| key |
	key := 'key'.
	dict at: key put: 2.5.
	self assert: (dict at: key) equals: 2.5.
	self should: [ dict at: key copy ] raise: Error
]
