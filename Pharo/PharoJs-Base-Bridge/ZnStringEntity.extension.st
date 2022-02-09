Extension { #name : #ZnStringEntity }

{ #category : #'*PharoJs-Base-Bridge-Exporter' }
ZnStringEntity class >> css: string [

	^ (self type: ZnMimeType textCss)
		  string: string;
		  yourself
]

{ #category : #'*PharoJs-Base-Bridge-Exporter' }
ZnStringEntity class >> javascript: string [

	^ (self type: ZnMimeType textJavascript)
		  string: string;
		  yourself
]
