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
			package: 'PharoJs-Base-Transpiler-Optimizations' with: [ spec requires: #('PharoJs-Base-Transpiler'). ];
			package: 'PharoJs-Base-Transpiler-Optimizations-Tests' with: [
				spec requires: #('PharoJs-Base-Transpiler-Optimizations' 'PharoJs-Base-Bridge-Tests' 'PharoJs-Base-Transpiler-Tests'). ].
		
		"Exporter"		
		spec	
			package: 'PharoJs-Base-Exporter' with: [ spec requires: #('PharoJs-Base-Transpiler' 'PharoJs-Base-App' ) ];
			package: 'PharoJs-Base-Exporter-Tests' with: [ spec requires: #('PharoJs-Base-Exporter' 'PharoJs-Base-Transpiler-Tests') ].					
				
		"JS - CoreLibraries"
		spec   
			package: 'PharoJs-Base-JS-CoreLibraries' with: [ spec requires: #('PharoJs-Base-Transpiler' 'PharoExtra') ];
			package: 'PharoJs-Base-JS-CoreLibraries-Tests' with: [ spec requires: #('PharoJs-Base-JS-CoreLibraries' 'PharoJsTestFramework' 'PharoJs-Base-Bridge-Tests' 'PharoJs-Base-Transpiler-Tests') ].					
				
		"Bridge"	  
		spec 	
			package: 'PharoJs-Base-Bridge' with: [ spec requires: #('PharoJs-Base-JS-CoreLibraries' 'PharoJs-Base-Exporter' 'PharoJs-Base-App' 'Zinc-WebSocket-Core' 'PharoJsSerialization') ];
			package: 'PharoJs-Base-Bridge-Tests' with: [ spec requires: #('PharoJsTestFramework' 'PharoJs-Base-Bridge') ].

		
		"App"
		spec 
			package: 'PharoJs-Base-App' with: [
				spec requires: #('PharoJs-Base-Transpiler' 'PharoJs-Base-JS-CoreLibraries') ].
		
		"Examples"	
		spec	
			package: 'PharoJs-Examples' with: [ spec requires: #('PharoJs-Base-App' 'PharoJs-Base-Transpiler' 'PharoJsTestFramework' 'PharoJs-Base-Exporter') ];
			package: 'PharoJs-Examples-Tests' with: [ spec requires: #('PharoJs-Examples' 'PharoJsTestFramework') ].						
		
		"Utilities - Statistics"					
		spec
			package: 'PharoJs-Utilities-Statistics' with: [ spec requires: #('PharoJs-Base-Exporter' ) ].
										
		"Other"   
		spec
			package: 'PharoJsTestFramework' with: [
				spec requires: #('PharoJs-Base-Exporter' 'PharoJs-Base-Bridge' 'PharoJs-Base-App' ) ];
			package: #PharoJsTiming with: [
				spec requires: #('PharoJs-Base-Transpiler-Optimizations' 'PharoJs-Base-Bridge' ) ];
			package: 'PharoJsTools' with: [
				spec requires: #('PharoJs-Base-Bridge' ). ];		
			package: 'PharoJsSerialization' with: [
				spec requires: #('PharoJs-Base-JS-CoreLibraries')]; 
			package: 'PharoJsSerializationTest' with: [
				spec requires: #('PharoJsSerialization' 'PharoJs-Base-Bridge-Tests')]; 
			package: 'PharoJsSerializationDeprecated' with: [
				spec requires: #('PharoJs-Base-App' 'PharoJs-Base-Transpiler' 'PharoJsTestFramework' ) ].
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
