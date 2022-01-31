Extension { #name : #PjTranspiler }

{ #category : #'*PharoJs-Base-Bridge' }
PjTranspiler >> convertJavascriptMessage: aJavascriptMessage [
	| jsAst |
	jsAst := converter convertJavascriptMessage: aJavascriptMessage.
	self generateCodeStringFrom: jsAst.
]
