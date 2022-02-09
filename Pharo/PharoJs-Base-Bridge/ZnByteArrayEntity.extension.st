Extension { #name : #ZnByteArrayEntity }

{ #category : #'*PharoJs-Base-Bridge-Exporter' }
ZnByteArrayEntity class >> favicon: byteArray [

	^ (self type: (ZnMimeType main: 'image' sub: 'vnd.microsoft.icon'))
		  bytes: byteArray;
		  yourself
]
