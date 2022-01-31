"
A PjLoggingClientCodeGenerator is a generator for HTML/Javascript client code that logs websocket activity on the HTML page.

"
Class {
	#name : #PjLoggingClientCodeGenerator,
	#superclass : #PjClientCodeGenerator,
	#category : #'PharoJs-Base-Bridge-Client-CodeGenerator'
}

{ #category : #accessing }
PjLoggingClientCodeGenerator class >> bridgeAppClassDecoratorClass [
	^ PjLoggingClientBridgeAppClassDecorator
]

{ #category : #generating }
PjLoggingClientCodeGenerator >> generateHtmlUsing: aHtmlGenerator [
	super generateHtmlUsing: aHtmlGenerator.
	aHtmlGenerator addHtmlToBody: self logoHtmlString.
	aHtmlGenerator cr
]

{ #category : #generating }
PjLoggingClientCodeGenerator >> htmlLogElementId [
	^ PjLoggingEvaluatorWebsocketDelegate logElementId
]

{ #category : #generating }
PjLoggingClientCodeGenerator >> logoHtmlString [
	^ '<div style="position:relative;width:100%;max-width:471px;">
<img src="', self logoUrlString,'" alt="JavaScript Pharo Bridge" style="width:100%;"/><br/>
</div>'
]

{ #category : #generating }
PjLoggingClientCodeGenerator >> logoUrlString [
	^'http://car.mines-douai.fr/wp-content/uploads/2015/07/pharoJsLogo2015-07-14.png'
]

{ #category : #generating }
PjLoggingClientCodeGenerator >> printClientSmalltalkLaunchStringOn: smalltalkWriteStream [
	smalltalkWriteStream
		nextPutAll: self websocketDelegateClass name;
		nextPutAll: ' logElementId: ';
		print: self htmlLogElementId;
		nextPutAll: ' . '.
	super printClientSmalltalkLaunchStringOn: smalltalkWriteStream
]
