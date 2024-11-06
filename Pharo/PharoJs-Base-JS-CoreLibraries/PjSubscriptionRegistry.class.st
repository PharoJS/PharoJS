Class {
	#name : 'PjSubscriptionRegistry',
	#superclass : 'Object',
	#instVars : [
		'action',
		'announcer'
	],
	#category : 'PharoJs-Base-JS-CoreLibraries-Announcements',
	#package : 'PharoJs-Base-JS-CoreLibraries',
	#tag : 'Announcements'
}

{ #category : 'pharoJs support' }
PjSubscriptionRegistry class >> jsTranspilationImportMethods [

	<pharoJsSkip>
	^ { (SubscriptionRegistry
	   ->
		   #( reset add: remove: removeSubscriber: replace:with:
		      subscriptions subscriptionsForClass: subscriptionsOf:do:
		      deliver: subscriptionsHandling: deliver:to: deliver:to:startingAt:)) }
]

{ #category : 'pharoJs support' }
PjSubscriptionRegistry class >> phxJsonClassName [
	^ 'SubscriptionRegistry'
]

{ #category : 'private' }
PjSubscriptionRegistry >> initialize [

	super initialize.
	self reset
]

{ #category : 'private' }
PjSubscriptionRegistry >> protected: aBlock [
	^ aBlock value
]
