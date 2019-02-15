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
PjDOMApplication class >> cssFile [
	<pharoJsSkip>
	self ifInvalidFile: cssFile do:[self setUpCssFile].
	^cssFile	
]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication class >> cssFile: anObject [
	<pharoJsSkip>
	cssFile := anObject
]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication class >> cssFromFile [
	<pharoJsSkip>
	^ (FileStream fileNamed: self cssFile) contentsOfEntireFile

]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication class >> favicon [
	<pharoJsSkip>
	^ nil
]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication class >> generateHtmlFromFileUsing: aHtmlGenerator [
	<pharoJsSkip>
	aHtmlGenerator loadFrom: (FileStream fileNamed: self htmlFile) contentsOfEntireFile.
	^ true

]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication class >> generateHtmlUsing: aPjHtmlGenerator [
	<pharoJsSkip>
	^ false
	" consider overriding with '^ self generateHtmlFromFileUsing: aPjHtmlGenerator' "
]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication class >> htmlFile [
	<pharoJsSkip>
	self ifInvalidFile: htmlFile do:[self setUpHtmlFile].
	^htmlFile
]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication class >> htmlFile: anObject [
	<pharoJsSkip>
	htmlFile := anObject
]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication class >> ifInvalidFile: file do: aBlock [
	<pharoJsSkip>
	(file isNil or: [(FileStream fileNamed: file) isNil]) ifTrue: aBlock
]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication class >> setUpCssFile [
	<pharoJsSkip>
	| fileName |
	fileName := UIManager default chooseFullFileNameMatching: #('*.css') label:  'PharoJS: CSS file for app ', self name, ' please?'.
	self ifInvalidFile: fileName do: [  
		^self error: 'PharoJS: Invalid CSS file for app ', self name].
	self cssFile: fileName.
]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication class >> setUpHtmlFile [
	<pharoJsSkip>
	| fileName |
	fileName := UIManager default chooseFullFileNameMatching: #('*.html') label:  'PharoJS: HTML file for app ', self name, ' please?'.
	self ifInvalidFile: fileName do: [  
		^self error: 'PharoJS: Invalid HTML file for app ', self name].
	self htmlFile: fileName.
]
