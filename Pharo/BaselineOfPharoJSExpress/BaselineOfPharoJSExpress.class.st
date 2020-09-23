"
Baseline managing of PharoJSExpress
"
Class {
	#name : #BaselineOfPharoJSExpress,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoJSExpress
}

{ #category : #baseline }
BaselineOfPharoJSExpress >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'PharoJS' with: [
				spec
					repository: 'github://PharoJS/PharoJS' ].
		spec 
			"Packages"
			package: 'PharoJsExpress' with: [ spec requires: #('PharoJS') ].
	].
]
