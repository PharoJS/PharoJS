Extension { #name : #PjExpressApp }

{ #category : #'*PharoJs-Base-Exporter' }
PjExpressApp class >> afterExportApp [

	<pharoJsSkip>
	super afterExportApp.
	self clientAppClasses do: #exportApp
]

{ #category : #'*PharoJs-Base-Exporter' }
PjExpressApp class >> clientAppClasses [

	<pharoJsSkip>
	^ #(  ) 
]
