"
Baseline managing the PharoJS project on Git
"
Class {
	#name : #BaselineOfPharoJS,
	#superclass : #BaselineOf,
	#category : #'BaselineOfPharoJS-Base'
}

{ #category : #baseline }
BaselineOfPharoJS >> baseline: spec [
	<baseline>

	spec for: #'pharo7.x' do: [ spec package: 'PharoJsPharo7' ].
	spec for: #(#'pharo8.x' 'pharo9.x') do: [ spec package: 'PharoJsPharo8' ].	
	spec for: #'common' do: [
		self prerequisites: spec.
				
		spec 
			package: 'PharoJsApp' with: [
				spec requires: #('PharoJsTranspiler' ). ];
			package: 'PharoJsBridge' with: [
				spec requires: #(#PharoJsCoreLibraries #PharoJsExporter 'PharoJsApp' 'Zinc-WebSocket-Core' 'PharoJsSerialization'). ];
			package: #PharoJsBridgeTest with: [
				spec requires: #('PharoJsTestFramework' 'PharoJsBridge' ). ];
			package: #PharoJsCoreLibraries with: [
				spec requires: #('PharoJsTranspiler' 'PharoExtra' ). ];
			package: #PharoJsCoreLibrariesTest with: [
				spec requires: #(#PharoJsCoreLibraries 'PharoJsBridge' 'PharoJsTestFramework' #PharoJsBridgeTest PharoJsTranspilerTests). ];
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
			package: 'PharoJsTranspiler' with: [
				spec requires: #('Equals' ). ];
			package: 'PharoJsTranspilerOptimization' with: [
				spec requires: #('PharoJsTranspiler' ). ];
			package: 'PharoJsSerialization' with: [
				spec requires: #('PharoJsCoreLibraries')]; 
			package: 'PharoJsSerializationTest' with: [
				spec requires: #('PharoJsSerialization' 'PharoJsBridgeTest')]; 
			package: 'PharoJsSerializationDeprecated' with: [
				spec requires: #('PharoJsApp' 'PharoJsTranspiler' 'PharoJsTestFramework' ). ]; 
			package: 'PharoJsTranspilerTests' with: [
				spec requires: #('PharoJsTranspiler'). ]; 
			package: 'PharoJsTranspilerOptimizationTests' with: [
				spec requires: #('PharoJsTranspilerOptimization' PharoJsBridgeTest PharoJsTranspilerTests). ];
			package: 'PharoJsExporterTests' with: [
				spec requires: #('PharoJsExporter' 'PharoJsTranspilerTests'). ]. 
	]
]

{ #category : #'private - accessing' }
BaselineOfPharoJS >> prerequisites: spec [
	"Add the projects prerequisite definitions to the given spec"	

	"Baselines"
	spec
		baseline: 'PharoExtra' with: [ spec repository: 'github://bouraqadi/PharoMisc' ];
		baseline: 'Equals' with: [ spec repository: 'github://bouraqadi/PharoMisc' ].
		
	"Packages"	
	spec
		package: 'Zinc-WebSocket-Core' with: [ spec repository: 'github://svenvc/zinc' ]
]
