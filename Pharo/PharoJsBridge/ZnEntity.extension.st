Extension { #name : #ZnEntity }

{ #category : #'*PharoJsBridge-Exporter' }
ZnEntity class >> css: css [
	^ self stringEntityClass css: css
]

{ #category : #'*PharoJsBridge-Exporter' }
ZnEntity class >> favicon: favicon [
	^ ZnByteArrayEntity favicon: favicon
]

{ #category : #'*PharoJsBridge-Exporter' }
ZnEntity class >> javascript: javascript [
	^ self stringEntityClass javascript: javascript
]
