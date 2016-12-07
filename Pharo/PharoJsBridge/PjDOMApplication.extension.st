Extension { #name : #PjDOMApplication }

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication classSide >> css [
	<pharoJsSkip>
	" might want to override with:
	^ self cssFromFile
	"
	^ nil
]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication classSide >> cssFile [
	<pharoJsSkip>
	self ifInvalidFile: cssFile do:[self setUpCssFile].
	^cssFile	
]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication classSide >> cssFile: anObject [
	<pharoJsSkip>
	cssFile := anObject
]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication classSide >> cssFromFile [
	<pharoJsSkip>
	^ (FileStream fileNamed: self cssFile) contentsOfEntireFile

]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication classSide >> favicon [
	<pharoJsSkip>
	^ nil
]

{ #category : #'*PharoJsBridge-App' }
PjDOMApplication classSide >> setUpCssFile [
	<pharoJsSkip>
	| fileName |
	fileName := UIManager default chooseFullFileNameMatching: #('*.css') label:  'PharoJS: CSS file for app ', self name, ' please?'.
	self ifInvalidFile: fileName do: [  
		^self error: 'PharoJS: Invalid CSS file for app ', self name].
	self cssFile: fileName.
]
