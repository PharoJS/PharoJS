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

	spec for: #'pharo7.x' do: [ spec package: 'PharoJs-Compatibility-Pharo7' ].
	spec for: #('pharo8.x' 'pharo9.x') do: [ spec package: 'PharoJs-Compatibility-Pharo8' ].
		
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
				
		"TestFramework"	
		spec
			package: 'PharoJs-TestFramework' with: [ spec requires: #('PharoJs-Base-Exporter' 'PharoJs-Base-Bridge' 'PharoJs-Base-App' ) ].			

		"JS - CoreLibraries"
		spec   
			package: 'PharoJs-Base-JS-CoreLibraries' with: [ spec requires: #('PharoJs-Base-Transpiler' 'PharoExtra') ];
			package: 'PharoJs-Base-JS-CoreLibraries-Tests' with: [ spec requires: #('PharoJs-Base-JS-CoreLibraries' 'PharoJs-TestFramework' 'PharoJs-Base-Bridge-Tests' 'PharoJs-Base-Transpiler-Tests') ].					

		"Serialization"  
		spec package: 'PharoJs-Base-Serialization' with: [ spec requires: #('PharoJs-Base-JS-CoreLibraries')];
			  package: 'PharoJs-Base-Serialization-Tests' with: [ spec requires: #('PharoJs-Base-Serialization' 'PharoJs-Base-Bridge-Tests')];
			  package: 'PharoJs-Base-Serialization-Deprecated' with: [ spec requires: #('PharoJs-Base-App' 'PharoJs-Base-Transpiler' 'PharoJs-TestFramework' ) ].
							
		"Bridge"	  
		spec 	
			package: 'PharoJs-Base-Bridge' with: [ spec requires: #('PharoJs-Base-JS-CoreLibraries' 'PharoJs-Base-Exporter' 'PharoJs-Base-App' 'Zinc-WebSocket-Core' 'PharoJs-Base-Serialization') ];
			package: 'PharoJs-Base-Bridge-Tests' with: [ spec requires: #('PharoJs-TestFramework' 'PharoJs-Base-Bridge') ].
		
		"App"
		spec 
			package: 'PharoJs-Base-App' with: [
				spec requires: #('PharoJs-Base-Transpiler' 'PharoJs-Base-JS-CoreLibraries') ].
		
		"Examples"	
		spec	
			package: 'PharoJs-Examples' with: [ spec requires: #('PharoJs-Base-App' 'PharoJs-Base-Transpiler' 'PharoJs-TestFramework' 'PharoJs-Base-Exporter') ];
			package: 'PharoJs-Examples-Tests' with: [ spec requires: #('PharoJs-Examples' 'PharoJs-TestFramework') ].						
		
		"Benchmarking (Timing)"
		spec
			package: 'PharoJs-Benchmarking' with: [
				spec requires: #('PharoJs-Base-Transpiler-Optimizations' 'PharoJs-Base-Bridge' ) ].
		
		"Utilities - Statistics"					
		spec
			package: 'PharoJs-Utilities-Statistics' with: [ spec requires: #('PharoJs-Base-Exporter' ) ].
													
		"Other"   		
		spec
			package: 'PharoJsTools' with: [
				spec requires: #('PharoJs-Base-Bridge' ). ].		
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
