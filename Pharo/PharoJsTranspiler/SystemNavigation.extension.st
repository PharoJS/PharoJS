Extension { #name : #SystemNavigation }

{ #category : #'*PharoJsTranspiler' }
SystemNavigation class >> globalRefsForPharoJS: aClassOrLiteral [
	^ (self default respondsTo: #allGlobalRefsOn:) ifTrue: [
			self default allGlobalRefsOn: aClassOrLiteral
		] ifFalse: [
			self default classRefsToClassName: aClassOrLiteral]

]
