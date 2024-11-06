Extension { #name : 'SubscriptionRegistry' }

{ #category : '*PharoJs-Base-JS-CoreLibraries' }
SubscriptionRegistry >> allPhxJsonInstvarNames [
	^ super allPhxJsonInstvarNames copyWithout: #monitor
]

{ #category : '*PharoJs-Base-JS-CoreLibraries' }
SubscriptionRegistry class >> javascriptPlaceholder [

	^PjSubscriptionRegistry
]
