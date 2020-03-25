Class {
	#name : #BPTreeDictionaryTest,
	#superclass : #TestCase,
	#instVars : [
		'dict'
	],
	#category : #'BPfaff-Tests'
}

{ #category : #running }
BPTreeDictionaryTest >> setUp [
	super setUp.
	dict := BPTreeDictionary new
]

{ #category : #tests }
BPTreeDictionaryTest >> testAdd [
	dict add: #a -> 1.
	dict add: #a -> 2.
	self assert: dict size equals: 1
]

{ #category : #tests }
BPTreeDictionaryTest >> testAdd1 [
	dict add: #a -> 1.
	self assert: (dict at: #a) equals: 1.
	self assert: dict size equals: 1
]

{ #category : #tests }
BPTreeDictionaryTest >> testAdd2 [
	dict add: #a -> 1.
	dict add: #a -> 2.
	self assert: (dict at: #a) equals: 2.
	self assert: dict size equals: 1
]

{ #category : #tests }
BPTreeDictionaryTest >> testAt [
	self should: [ dict at: #notFound ] raise: Error
]

{ #category : #tests }
BPTreeDictionaryTest >> testAt1 [
	dict at: #a put: 1.
	self assert: (dict at: #a) equals: 1.
	self assert: dict size equals: 1
]

{ #category : #tests }
BPTreeDictionaryTest >> testAt2 [
	dict at: #a put: 1.
	dict at: #a put: 3.
	self assert: (dict at: #a) equals: 3.
	self assert: dict size equals: 1
]

{ #category : #'tests-nested dictionaries' }
BPTreeDictionaryTest >> testAtAt [
	self should: [ dict at: #a at: #b ] raise: Error
]

{ #category : #'tests-nested dictionaries' }
BPTreeDictionaryTest >> testAtAt1 [
	dict at: #a at: #b put: 1.
	self assert: (dict at: #a at: #b) equals: 1.
	self assert: dict size equals: 1
]

{ #category : #'tests-nested dictionaries' }
BPTreeDictionaryTest >> testAtAt2 [
	dict at: #a at: #b put: 1.
	dict at: #a at: #b put: 3.
	self assert: (dict at: #a at: #b) equals: 3.
	self assert: dict size equals: 1
]

{ #category : #'tests-nested dictionaries' }
BPTreeDictionaryTest >> testAtAtIfAbsent [
	dict at: #a at: #b put: 1.
	self assert: (dict at: #a at: #b ifAbsent: [ self error ]) equals: 1
]

{ #category : #'tests-nested dictionaries' }
BPTreeDictionaryTest >> testAtAtIfAbsent1 [
	self assert: (dict at: #a at: #b ifAbsent: [ 10 ]) equals: 10
]

{ #category : #'tests-nested dictionaries' }
BPTreeDictionaryTest >> testAtAtIfAbsent2 [
	dict at: #a at: #c put: 1.
	self assert: (dict at: #a at: #b ifAbsent: [ 10 ]) equals: 10
]

{ #category : #'tests-nested dictionaries' }
BPTreeDictionaryTest >> testAtAtIfAbsent3 [
	dict at: #a at: #b put: 3.
	self assert: (dict at: #a at: #b ifAbsent: [ 10 ]) equals: 3
]

{ #category : #tests }
BPTreeDictionaryTest >> testAtIfAbsent [
	dict at: #a put: 1.
	self assert: (dict at: #a ifAbsent: [ self error ]) equals: 1
]

{ #category : #tests }
BPTreeDictionaryTest >> testAtIfAbsent1 [
	self assert: (dict at: #a ifAbsent: [ 10 ]) equals: 10
]

{ #category : #tests }
BPTreeDictionaryTest >> testAtIfAbsentPut [
	self assert: (dict at: #a ifAbsentPut: [ 13 ]) equals: 13
]

{ #category : #tests }
BPTreeDictionaryTest >> testAtIfAbsentPut2 [
	dict at: #a put: 1.
	self assert: (dict at: #a ifAbsent: [ self error ]) equals: 1
]

{ #category : #tests }
BPTreeDictionaryTest >> testAtIfPresent [
	dict at: #a put: 2.
	self assert: (dict at: #a ifPresent: [ :v | v * 3 ]) equals: 6
]

{ #category : #tests }
BPTreeDictionaryTest >> testAtIfPresent2 [
	self assert: (dict at: #a ifPresent: [ :v | v * 3 ]) equals: nil
]

{ #category : #tests }
BPTreeDictionaryTest >> testAtIfPresentIfAbsent [
	dict at: #a put: 2.
	self
		assert: (dict at: #a ifPresent: [ :v | v * 3 ] ifAbsent: [ self error ])
		equals: 6
]

{ #category : #tests }
BPTreeDictionaryTest >> testAtIfPresentIfAbsent2 [
	self
		assert: (dict at: #a ifPresent: [ :v | self error ] ifAbsent: [ 42 ])
		equals: 42
]

{ #category : #tests }
BPTreeDictionaryTest >> testAtIfPresentIfAbsentPut [
	dict at: #a put: 2.
	self
		assert: (dict at: #a ifPresent: [ :v | v * 3 ] ifAbsentPut: [ self error ])
		equals: 6
]

{ #category : #tests }
BPTreeDictionaryTest >> testAtIfPresentIfAbsentPut2 [
	self
		assert: (dict at: #a ifPresent: [ :v | self error ] ifAbsentPut: [ 42 ])
		equals: 42
]
