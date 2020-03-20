Class {
	#name : #BPTreeDictionaryTest,
	#superclass : #TestCase,
	#instVars : [
		'dict'
	],
	#category : #'BPfaff-Tests'
}

{ #category : #tests }
BPTreeDictionaryTest >> testAdd [
	dict := BPTreeDictionary new.
	dict add: #a -> 1.
	dict add: #a -> 2.
	self assert: dict size equals: 1
]

{ #category : #tests }
BPTreeDictionaryTest >> testAdd1 [
	dict := BPTreeDictionary new.
	dict add: #a -> 1.
	self assert: (dict at: #a) equals: 1
]

{ #category : #tests }
BPTreeDictionaryTest >> testAdd2 [
	dict := BPTreeDictionary new.
	dict add: #a -> 1.
	dict add: #a -> 2.
	self assert: (dict at: #a) equals: 2
]
