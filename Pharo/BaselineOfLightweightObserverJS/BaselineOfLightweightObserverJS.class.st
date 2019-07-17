Class {
	#name : #BaselineOfLightweightObserverJS,
	#superclass : #BaselineOf,
	#category : #BaselineOfLightweightObserverJS
}

{ #category : #baselines }
BaselineOfLightweightObserverJS >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: 'PharoJS' with: [
				spec
					repository: 'github://bouraqadi/PharoJS' ];
			baseline: 'LightweightObserver' with: [
				spec
					repository: 'github://bouraqadi/PharoMisc' ].
		spec 
			package: 'LightweightObserverJS' with: [
				spec requires: #('PharoJS' 'LightweightObserver' ). ]
	]

]
