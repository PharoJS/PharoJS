Class {
	#name : #PjNodeAppExportTest,
	#superclass : #PjAppTestCase,
	#category : #'PharoJs-Base-Exporter-Tests-Tests'
}

{ #category : #'suite parameters' }
PjNodeAppExportTest class >> appClass [

	^ PjMinimalNodeApplication
]

{ #category : #tests }
PjNodeAppExportTest >> testRequiredJsModulesInstalled [

	self appClass modulesFolder ensureDeleteAll.
	self deny: self appClass modulesFolder exists.
	self appClass exportApp.
	self assert: self appClass modulesFolder exists
]
