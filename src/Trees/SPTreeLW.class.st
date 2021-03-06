"
This concrete class adds the 'superTree' variable to its superclass as explained in TreeLW. The 'SP' in the name comes from the 's' in subTrees and the 'p' in superTree.
"
Class {
	#name : #SPTreeLW,
	#superclass : #STreeLW,
	#instVars : [
		'superTree'
	],
	#category : #'Trees-Main'
}

{ #category : #examples }
SPTreeLW class >> readMe [
	
	"TreeLW contains examples for this class."
]

{ #category : #'private accessing' }
SPTreeLW >> basicSuperTree [
	"Return the contents of the superTree variable. Do not redefine in subclasses."


	^superTree
]

{ #category : #'private accessing' }
SPTreeLW >> basicSuperTree: aTree [
	"Set the superTree variable to aTree and return the receiver. If the argument is a
	tree, it becomes the superTree of the receiver. If the argument is something
	else (except nil, which is not allowed), the receiver becomes a root node. Do not
	redefine in subclasses."

	superTree := aTree
]
