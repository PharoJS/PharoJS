"
I am a ProcessLocalVariable that contains the PjBridge in use by this process.

This allows us to simultaneously debug multiple applications (for example a client and a server.)

This is used by PjProxy.
"
Class {
	#name : #PjProxyLocalBridge,
	#superclass : #ProcessLocalVariable,
	#category : #'PharoJs-Base-Bridge-Proxy'
}
