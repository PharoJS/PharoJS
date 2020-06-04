"
Baseline managing the PharoJS project on Git
"
Class {
	#name : #BaselineOfPharoJS,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoJS
}

{ #category : #baseline }
BaselineOfPharoJS >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: 'PharoExtra' with: [
				spec
					repository: 'github://bouraqadi/PharoMisc' ];
			baseline: 'Equals' with: [
				spec
					repository: 'github://bouraqadi/PharoMisc' ];
			package: 'Zinc-WebSocket-Core' with: [
				spec
					repository: 'github://svenvc/zinc' ].
		spec
			package: 'PharoJsPharo7';
			package: 'PharoJsPharo8';
			package: 'PharoJsApp' with: [
				spec requires: #('PharoJsTranspiler' ). ];
			package: 'PharoJsBridge' with: [
				spec requires: #(#PharoJsCoreLibraries #PharoJsExporter 'PharoJsApp' 'Zinc-WebSocket-Core' 'PharoJsSerialization'). ];
			package: #PharoJsBridgeTest with: [
				spec requires: #('PharoJsTestFramework' 'PharoJsBridge' ). ];
			package: #PharoJsCoreLibraries with: [
				spec requires: #('PharoJsTranspiler' 'PharoExtra' ). ];
			package: #PharoJsCoreLibrariesTest with: [
				spec requires: #(#PharoJsCoreLibraries 'PharoJsBridge' 'PharoJsTestFramework' #PharoJsBridgeTest ). ];
			package: 'PharoJsExamples' with: [
				spec requires: #('PharoJsApp' 'PharoJsTranspiler' 'PharoJsTestFramework' 'PharoJsExporter'). ];
			package: #PharoJsExporter with: [
				spec requires: #('PharoJsTranspiler' 'PharoJsApp' ). ];
			package: 'PharoJsStatistics' with: [
				spec requires: #('PharoJsExporter' ). ];
			package: 'PharoJsTestFramework' with: [
				spec requires: #(#PharoJsExporter 'PharoJsBridge' 'PharoJsApp' ). ];
			package: #PharoJsTiming with: [
				spec requires: #(#PharoJsTranspilerOptimization 'PharoJsBridge' ). ];
			package: 'PharoJsTools' with: [
				spec requires: #('PharoJsBridge' ). ];
			package: 'PharoJsTranspiler' with: [|reqs|
				reqs := OrderedCollection with: 'Equals'.
				SystemVersion current major = 7 ifTrue: [ reqs add: 'PharoJsPharo7'  ].
				SystemVersion current major = 8 ifTrue: [ reqs add: 'PharoJsPharo8'  ].
				spec requires: reqs ];
			package: 'PharoJsTranspilerOptimization' with: [
				spec requires: #('PharoJsTranspiler' ). ];
			package: 'PharoJsSerialization' with: [
				spec requires: #('PharoJsCoreLibraries')]; 
			package: 'PharoJsSerializationTest' with: [
				spec requires: #('PharoJsSerialization' 'PharoJsBridgeTest')]; 
			package: 'PharoJsSerializationDeprecated' with: [
				spec requires: #('PharoJsApp' 'PharoJsTranspiler' 'PharoJsTestFramework' ). ]. ].

]
