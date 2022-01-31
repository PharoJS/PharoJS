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
		
		"Transpiler"
		spec package: 'PharoJsTranspiler' with: [ spec requires: #('Equals' ). ];
			  package: 'PharoJsTranspilerTests' with: [ spec requires: #('PharoJsTranspiler'). ]. 
		
		"Transpiler optimizations"		
		spec 
			package: 'PharoJsTranspilerOptimization' with: [ spec requires: #('PharoJsTranspiler' ). ];
			package: 'PharoJsTranspilerOptimizationTests' with: [
				spec requires: #('PharoJsTranspilerOptimization' PharoJsBridgeTest PharoJsTranspilerTests). ].
		
		"Other"
		spec 
			package: 'PharoJs-Base-App' with: [
				spec requires: #('PharoJsTranspiler' ) ];
			package: 'PharoJsBridge' with: [
				spec requires: #(#PharoJsCoreLibraries #PharoJsExporter 'PharoJs-Base-App' 'Zinc-WebSocket-Core' 'PharoJsSerialization') ];
			package: #PharoJsBridgeTest with: [
				spec requires: #('PharoJsTestFramework' 'PharoJsBridge' ) ];
			package: #PharoJsCoreLibraries with: [
				spec requires: #('PharoJsTranspiler' 'PharoExtra' ) ];
			package: #PharoJsCoreLibrariesTest with: [
				spec requires: #(#PharoJsCoreLibraries 'PharoJsBridge' 'PharoJsTestFramework' #PharoJsBridgeTest PharoJsTranspilerTests) ];
			package: 'PharoJsExamples' with: [
				spec requires: #('PharoJs-Base-App' 'PharoJsTranspiler' 'PharoJsTestFramework' 'PharoJsExporter') ];
			package: #PharoJsExporter with: [
				spec requires: #('PharoJsTranspiler' 'PharoJs-Base-App' ). ];
			package: 'PharoJsStatistics' with: [
				spec requires: #('PharoJsExporter' ). ];
			package: 'PharoJsTestFramework' with: [
				spec requires: #(#PharoJsExporter 'PharoJsBridge' 'PharoJs-Base-App' ) ];
			package: #PharoJsTiming with: [
				spec requires: #(#PharoJsTranspilerOptimization 'PharoJsBridge' ) ];
			package: 'PharoJsTools' with: [
				spec requires: #('PharoJsBridge' ). ];
		
			package: 'PharoJsSerialization' with: [
				spec requires: #('PharoJsCoreLibraries')]; 
			package: 'PharoJsSerializationTest' with: [
				spec requires: #('PharoJsSerialization' 'PharoJsBridgeTest')]; 
			package: 'PharoJsSerializationDeprecated' with: [
				spec requires: #('PharoJs-Base-App' 'PharoJsTranspiler' 'PharoJsTestFramework' ) ]; 

			package: 'PharoJsExporterTests' with: [
				spec requires: #('PharoJsExporter' 'PharoJsTranspilerTests') ]. 
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
