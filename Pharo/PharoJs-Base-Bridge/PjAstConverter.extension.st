Extension { #name : #PjAstConverter }

{ #category : #'*PharoJs-Base-Bridge' }
PjAstConverter >> convertJavascriptMessage: aJavascriptMessage [

	| args |
	args := aJavascriptMessage arguments collect: [ :each | 
		        each asJsAstUsing: self ].
	self discoveredMessage: aJavascriptMessage selector.
	^ PjApplyNode
		  func: (PjFieldNode
				   target:
				   (PjGlobalNode identifier: aJavascriptMessage receiverId)
				   selectorNode:
				   (PjMessageSelectorNode identifier: aJavascriptMessage selector)
				   isNonNil: true)
		  args: args
]
