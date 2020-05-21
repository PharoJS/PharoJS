Extension { #name : #PjTranspiler }

{ #category : #'*PharoJsBridge' }
PjTranspiler >> convertJavascriptMessage: aJavascriptMessage [
	| jsAst |
	jsAst := converter convertJavascriptMessage: aJavascriptMessage.
	self generateCodeStringFrom: jsAst.

]
