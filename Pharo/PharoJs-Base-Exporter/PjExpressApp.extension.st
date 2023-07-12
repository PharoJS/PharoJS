Extension { #name : #PjExpressApp }

{ #category : #'*PharoJs-Base-Exporter' }
PjExpressApp classSide >> afterExportApp [

	<pharoJsSkip>
	super afterExportApp.
	self clientAppClasses do: #exportApp
]

{ #category : #'*PharoJs-Base-Exporter' }
PjExpressApp classSide >> clientAppClasses [

	<pharoJsSkip>
	^ #(  ) 
]
