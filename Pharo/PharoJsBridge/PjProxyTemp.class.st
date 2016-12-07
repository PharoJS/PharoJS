"
I am a proxy for a temporary (unnamed) value created as the result of some expression evaluated in the Javascript engine.
"
Class {
	#name : #PjProxyTemp,
	#superclass : #PjProxy,
	#category : #'PharoJsBridge-Proxy'
}

{ #category : #printing }
PjProxyTemp >> printOn: aStream [
	aStream nextPutAll: 'anon proxy'
]
