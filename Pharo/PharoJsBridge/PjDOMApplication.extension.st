Extension { #name : #PjDOMApplication }

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication class >> css [
	<pharoJsSkip>
	" might want to override with:
	^ self cssFromFile
	"
	^ nil
]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication class >> cssFile: anObject [
	<pharoJsSkip>
	cssFile := anObject
]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication class >> favicon [
	<pharoJsSkip>
	^ nil
]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication class >> generateHtmlUsing: aPjHtmlGenerator [
	<pharoJsSkip>
	^ false
	" consider overriding with '^ self generateHtmlFromFileUsing: aPjHtmlGenerator' "
]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication class >> htmlFile: anObject [
	<pharoJsSkip>
	htmlFile := anObject
]
