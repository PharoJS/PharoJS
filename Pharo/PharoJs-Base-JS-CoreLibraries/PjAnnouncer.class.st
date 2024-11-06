Class {
	#name : 'PjAnnouncer',
	#superclass : 'Object',
	#category : 'PharoJs-Base-JS-CoreLibraries-Announcements',
	#package : 'PharoJs-Base-JS-CoreLibraries',
	#tag : 'Announcements'
}

{ #category : 'pharoJs support' }
PjAnnouncer class >> jsTranspilationImportMethods [

	<pharoJsSkip>
	^ { (Announcer -> #( initialize when:do:for: announce: isSuspended preventedAnnouncements unsubscribe:)) }
]

{ #category : 'pharoJs support' }
PjAnnouncer class >> phxJsonClassName [
	^ 'Announcer'
]
