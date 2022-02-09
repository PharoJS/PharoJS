"
I am dedicated to shared dictionaries with JS globals that are defined outside PharoJS  i.e. subclasses of PjJavascriptGlobals of PharoJS users. I provide them with the class side initialize method to ensure the JS globals are initialized to JS proxies in Pharo.
"
Trait {
	#name : #PjTJavascriptGlobalsInitializer,
	#category : #'PharoJs-Base-Transpiler-Globals'
}

{ #category : #'class initialization' }
PjTJavascriptGlobalsInitializer classSide >> initialize [
	"self initialize"
	| proxy |
	self classVarNames do: [ : varName |
		proxy := PjProxyForGlobal newProxyNamed: varName.
		self classVarNamed: varName put: proxy.
	]
]
