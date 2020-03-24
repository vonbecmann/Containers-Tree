Class {
	#name : #BPDepthFirstVisitor,
	#superclass : #Object,
	#instVars : [
		'preOrderBlock',
		'postOrderBlock'
	],
	#category : #'BPfaff-Core'
}

{ #category : #initialization }
BPDepthFirstVisitor >> postOrderBlock: aBlockWithOneArgument [
	postOrderBlock := aBlockWithOneArgument
]

{ #category : #initialization }
BPDepthFirstVisitor >> preOrderBlock: aBlockWithOneArgument [
	preOrderBlock := aBlockWithOneArgument
]

{ #category : #visiting }
BPDepthFirstVisitor >> visit: aGivenTree [
	aGivenTree acceptVisitor: self
]

{ #category : #visiting }
BPDepthFirstVisitor >> visitNode: aGivenTreeNode [
	| visitStack |
	visitStack := OrderedCollection
		with: (Association key: aGivenTreeNode value: false).
	[ visitStack isEmpty ]
		whileFalse: [ | element node visited |
			element := visitStack first.
			node := element key.
			visited := element value.
			visited
				ifTrue: [ visitStack removeFirst.
					postOrderBlock ifNotNil: [ postOrderBlock cull: node ] ]
				ifFalse: [ element value: true.
					preOrderBlock ifNotNil: [ preOrderBlock cull: node ].
					node
						reversedChildrenDo:
							[ :child | visitStack addFirst: (Association key: child value: false) ] ] ]
]
