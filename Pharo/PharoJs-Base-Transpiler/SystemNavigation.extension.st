Extension { #name : #SystemNavigation }

{ #category : #'*PharoJs-Base-Transpiler' }
SystemNavigation class >> globalRefsForPharoJS: aClassOrLiteral [
	^ (self default respondsTo: #allGlobalRefsOn:) ifTrue: [
			self default allGlobalRefsOn: aClassOrLiteral
		] ifFalse: [
			self default classRefsToClassName: aClassOrLiteral]
]
