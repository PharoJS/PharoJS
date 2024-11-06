Class {
	#name : 'PjAnnouncementTest',
	#superclass : 'PjBridgeTestCase',
	#category : 'PharoJs-Base-JS-CoreLibraries-Tests-Objects',
	#package : 'PharoJs-Base-JS-CoreLibraries-Tests',
	#tag : 'Objects'
}

{ #category : 'tests' }
PjAnnouncementTest >> testBasicAnnouncement [

	self assertEquivalent: [
		| ann passed |
		ann := Announcer new.
		passed := false.
		ann when: Announcement do: [ passed := true ] for: 1.
		passed ].
	self assertEquivalent: [
		| ann passed |
		ann := Announcer new.
		passed := true.
		ann when: Announcement do: [ passed := false ] for: 1.
		ann unsubscribe: 1.
		passed ].
	
]
