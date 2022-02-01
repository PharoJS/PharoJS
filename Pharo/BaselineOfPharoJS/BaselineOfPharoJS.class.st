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
		spec package: 'PharoJs-Base-Transpiler' with: [ spec requires: #('Equals' ). ];
			  package: 'PharoJs-Base-Transpiler-Tests' with: [ spec requires: #('PharoJs-Base-Transpiler'). ]. 
		
		"Transpiler optimizations"		 
		spec 
			package: 'PharoJs-Base-Transpiler-Optimizations' with: [ spec requires: #('PharoJs-Base-Transpiler' ). ];
			package: 'PharoJs-Base-Transpiler-Optimizations-Tests' with: [
				spec requires: #('PharoJs-Base-Transpiler-Optimizations' 'PharoJs-Base-Bridge-Tests' 'PharoJs-Base-Transpiler-Tests'). ].
				
		"Bridge"	  
		spec 	
			package: 'PharoJs-Base-Bridge' with: [ spec requires: #(#PharoJsCoreLibraries #PharoJsExporter 'PharoJs-Base-App' 'Zinc-WebSocket-Core' 'PharoJsSerialization') ];	
			package: 'PharoJs-Base-Bridge-Tests' with: [ spec requires: #('PharoJsTestFramework' 'PharoJs-Base-Bridge' ) ].

		
		"App"
		spec 
			package: 'PharoJs-Base-App' with: [
				spec requires: #('PharoJs-Base-Transpiler' 'PharoJsCoreLibraries' ) ].
		
		"Examples"	
		spec	
			package: 'PharoJs-Examples' with: [
				spec requires: #('PharoJs-Base-App' 'PharoJs-Base-Transpiler' 'PharoJsTestFramework' 'PharoJsExporter') ];
			package: 'PharoJs-Examples-Tests' with: [
				spec requires: #('PharoJs-Examples' 'PharoJsTestFramework') ].						
							
		"Other"   
		spec
			package: #PharoJsCoreLibraries with: [
				spec requires: #('PharoJs-Base-Transpiler' 'PharoExtra' ) ];
			package: #PharoJsCoreLibrariesTest with: [
				spec requires: #(#PharoJsCoreLibraries 'PharoJsTestFramework' 'PharoJs-Base-Bridge-Tests' 'PharoJs-Base-Transpiler-Tests') ].
			
		spec	
			package: #PharoJsExporter with: [
				spec requires: #('PharoJs-Base-Transpiler' 'PharoJs-Base-App' ). ];
			package: 'PharoJsStatistics' with: [
				spec requires: #('PharoJsExporter' ). ];
			package: 'PharoJsTestFramework' with: [
				spec requires: #(#PharoJsExporter 'PharoJs-Base-Bridge' 'PharoJs-Base-App' ) ];
			package: #PharoJsTiming with: [
				spec requires: #('PharoJs-Base-Transpiler-Optimizations' 'PharoJs-Base-Bridge' ) ];
			package: 'PharoJsTools' with: [
				spec requires: #('PharoJs-Base-Bridge' ). ];		
			package: 'PharoJsSerialization' with: [
				spec requires: #('PharoJsCoreLibraries')]; 
			package: 'PharoJsSerializationTest' with: [
				spec requires: #('PharoJsSerialization' 'PharoJs-Base-Bridge-Tests')]; 
			package: 'PharoJsSerializationDeprecated' with: [
				spec requires: #('PharoJs-Base-App' 'PharoJs-Base-Transpiler' 'PharoJsTestFramework' ) ]; 

			package: 'PharoJsExporterTests' with: [
				spec requires: #('PharoJsExporter' 'PharoJs-Base-Transpiler-Tests') ]. 
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
