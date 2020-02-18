Class {
	#name : #BaselineOfPharoJsSeaside,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoJsSeaside
}

{ #category : #baselines }
BaselineOfPharoJsSeaside >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'PharoJS' with: [
				spec
					repository: 'github://PharoJS/PharoJS' ];
			baseline: 'Seaside3' with: [
				spec
					repository: 'github://SeasideSt/Seaside:master/repository' ].
		spec 
			package: 'PharoJsSeaside' with: [
				spec requires: #('PharoJS' 'Seaside3')].
	]
]
