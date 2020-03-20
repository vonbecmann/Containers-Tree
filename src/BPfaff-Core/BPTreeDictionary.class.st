Class {
	#name : #BPTreeDictionary,
	#superclass : #BPAVLTree,
	#category : #'BPfaff-Core'
}

{ #category : #private }
BPTreeDictionary >> is: firstObject equalTo: secondObject [
	^ firstObject key hash = secondObject key hash
		and: [ firstObject key = secondObject key ]
]

{ #category : #private }
BPTreeDictionary >> is: firstObject greaterThan: secondObject [
	^ firstObject key hash > secondObject key hash
]

{ #category : #private }
BPTreeDictionary >> is: firstObject lessThan: secondObject [
	^ firstObject key hash < secondObject key hash
]

{ #category : #private }
BPTreeDictionary >> newTreeNodeWith: anAssociation [
	^ BPAVLTreeNode
		with: 	(Association key: anAssociation key value: anAssociation value)
]
