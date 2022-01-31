Extension { #name : #PjDOMApplication }

{ #category : #'*PharoJs-Base-Bridge-App' }
PjDOMApplication class >> css [
	<pharoJsSkip>
	" might want to override with:
	^ self cssFromFile
	"
	^ nil
]

{ #category : #'*PharoJs-Base-Bridge-App' }
PjDOMApplication class >> cssFile: anObject [
	<pharoJsSkip>
	cssFile := anObject
]

{ #category : #'*PharoJs-Base-Bridge-App' }
PjDOMApplication class >> favicon [
	<pharoJsSkip>
	^ nil
]

{ #category : #'*PharoJs-Base-Bridge-App' }
PjDOMApplication class >> generateHtmlUsing: aPjHtmlGenerator [
	<pharoJsSkip>
	^ false
	" consider overriding with '^ self generateHtmlFromFileUsing: aPjHtmlGenerator' "
]

{ #category : #'*PharoJs-Base-Bridge-App' }
PjDOMApplication class >> htmlFile: anObject [
	<pharoJsSkip>
	htmlFile := anObject
]
