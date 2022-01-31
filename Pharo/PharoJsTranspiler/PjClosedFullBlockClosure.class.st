"
I represent a closed full block closure
"
Class {
	#name : #PjClosedFullBlockClosure,
	#superclass : #FullBlockClosure,
	#type : #variable,
	#traits : 'PjTClosedBlockClosure @ {#basicOriginalBlock:->#originalBlock:}',
	#classTraits : 'PjTClosedBlockClosure classTrait',
	#category : #'PharoJsTranspiler-Kernel'
}

{ #category : #accessing }
PjClosedFullBlockClosure >> originalBlock: aBlock [
	receiver := aBlock receiver.
	self basicOriginalBlock: aBlock.
]
