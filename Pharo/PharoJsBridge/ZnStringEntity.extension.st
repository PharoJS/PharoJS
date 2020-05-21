Extension { #name : #ZnStringEntity }

{ #category : #'*PharoJsBridge-Exporter' }
ZnStringEntity class >> css: string [
	^ (self type: ZnMimeType textCss)
		string: string;
		yourself
]

{ #category : #'*PharoJsBridge-Exporter' }
ZnStringEntity class >> javascript: string [
	^ (self type: ZnMimeType textJavascript)
		string: string;
		yourself
]
