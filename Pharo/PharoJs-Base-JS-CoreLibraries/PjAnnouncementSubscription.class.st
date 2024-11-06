Class {
	#name : 'PjAnnouncementSubscription',
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
PjAnnouncementSubscription class >> jsTranspilationImportMethods [

	<pharoJsSkip>
	^ {
		  (AnnouncementSubscription -> #( subscriber subscriber: unregister )).
		  (AbstractAnnouncementSubscription -> #( announcer: announcementClass: action: handlesAnnouncement:)) }
]

{ #category : 'pharoJs support' }
PjAnnouncementSubscription class >> phxJsonClassName [
	^ 'AnnouncementSubscription'
]

{ #category : 'announcing' }
PjAnnouncementSubscription >> deliver: anAnnouncement [

	(self handlesAnnouncement: anAnnouncement) ifTrue: [
		action cull: anAnnouncement cull: announcer ]
]
