"
Baseline managing the PharoJS project on Git
"
Class {
	#name : 'BaselineOfPharoJS',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfPharoJS-Base',
	#package : 'BaselineOfPharoJS',
	#tag : 'Base'
}

{ #category : 'baselines' }
BaselineOfPharoJS >> baseline: spec [
	<baseline>

	self compatibility: spec.
		
	spec for: #'common' do: [
		self 
			prerequisites: spec;		
			packages: spec;
			groups: spec	
	]
]

{ #category : 'private - accessing' }
BaselineOfPharoJS >> compatibility: spec [
	"Define a 'Compatibility' group that can be used as a dependency later to overcome differences in Pharo releases"

	spec for: #common do: [ spec group: 'Compatibility' with: #(  ) ]. "no compatibility by default"

]

{ #category : 'private - accessing' }
BaselineOfPharoJS >> groups: spec [
		"Define groups for loading"
		
		"Transpiler"
		spec 
			group: 'Transpiler' with: #('PharoJs-Base-Transpiler');			
			group: 'OptimizedTranspiler' with: #('PharoJs-Base-Transpiler' 'PharoJs-Base-Transpiler-Optimizations').		
		
		"Other"	
		spec 
			group: 'App' with: #('PharoJs-Base-App');
			group: 'Exporter' with: #('PharoJs-Base-Exporter');
			group: 'Bridge' with: #('PharoJs-Base-Bridge')	;
			group: 'Examples' with: #('PharoJs-Examples');
			group: 'Benchmarks' with: #('PharoJs-Benchmarking');
			group: 'Statistics' with: #('PharoJs-Utilities-Statistics');
			group: 'Tools' with: #('PharoJs-Tools').
			
		spec
			group: 'Electron' with: #('PharoJs-Base-JS-Electron');
			group: 'Express' with: #('PharoJs-Base-JS-Express');
			group: 'Node' with: #('PharoJs-Base-JS-Node');
			group: 'Seaside' with: #('PharoJs-Base-JS-Seaside').
			
		spec 	
			group: 'Tests' with: #(
				'PharoJs-Base-Transpiler-Tests'
				'PharoJs-Base-Transpiler-Optimizations-Tests'
				'PharoJs-Base-Exporter-Tests'
				'PharoJs-Base-JS-CoreLibraries-Tests'
				'PharoJs-Base-Serialization-Tests'
				'PharoJs-Base-Bridge-Tests'
				'PharoJs-Examples-Tests'
				'PharoJs-Tools-Tests' 
			).	
				
		spec group: 'Deprecated' with: #('PharoJs-Base-Serialization-Deprecated').		
	   "Virtual groups (lowercase) from Metacello"
		spec group: 'default' with: #('Compatibility' 'Transpiler' 'OptimizedTranspiler' 'App' 'Exporter' 'Bridge' 'Examples' 'Benchmarks' 'Statistics' 'Tools' 'Deprecated' 'Tests').
		spec group: 'all' with: #('default' 'Express' 'Electron' 'Node' 'Seaside' 'LightweightObserverJS')
]

{ #category : 'private - accessing' }
BaselineOfPharoJS >> packages: spec [
		"Define and list all packages and their dependencies"
		
		"Transpiler"
		spec package: 'PharoJs-Base-Transpiler' with: [ spec requires: #('Compatibility') ];
			  package: 'PharoJs-Base-Transpiler-Tests' with: [ spec requires: #('PharoJs-Base-Transpiler') ]; 
           package: 'PharoJs-Base-Transpiler-Optimizations' with: [ spec requires: #('PharoJs-Base-Transpiler') ];
			  package: 'PharoJs-Base-Transpiler-Optimizations-Tests' with: [ spec requires: #('PharoJs-Base-Transpiler-Optimizations' 'PharoJs-Base-Bridge-Tests' 'PharoJs-Base-Transpiler-Tests') ].
		
		"Exporter"		
		spec package: 'PharoJs-Base-Exporter' with: [ spec requires: #('PharoJs-Base-Transpiler' 'PharoJs-Base-App' ) ];
			  package: 'PharoJs-Base-Exporter-Tests' with: [ spec requires: #('PharoJs-Base-Exporter' 'PharoJs-Base-Transpiler-Tests') ].					
				
		"TestFramework"	
		spec package: 'PharoJs-TestFramework' with: [ spec requires: #('PharoJs-Base-Exporter' 'PharoJs-Base-Bridge' 'PharoJs-Base-App') ].			

		"JS - CoreLibraries"
		spec package: 'PharoJs-Base-JS-CoreLibraries' with: [ spec requires: #('PharoJs-Base-Transpiler' 'PharoExtra') ];
			  package: 'PharoJs-Base-JS-CoreLibraries-Tests' with: [ spec requires: #('PharoJs-Base-JS-CoreLibraries' 'PharoJs-TestFramework' 'PharoJs-Base-Bridge-Tests' 'PharoJs-Base-Transpiler-Tests') ].					

		"Serialization"  
		spec package: 'PharoJs-Base-Serialization' with: [ spec requires: #('PharoJs-Base-JS-CoreLibraries')];
			  package: 'PharoJs-Base-Serialization-Tests' with: [ spec requires: #('PharoJs-Base-Serialization' 'PharoJs-Base-Bridge-Tests')];
			  package: 'PharoJs-Base-Serialization-Deprecated' with: [ spec requires: #('PharoJs-Base-App' 'PharoJs-Base-Transpiler' 'PharoJs-TestFramework') ].
							
		"Bridge"	  
		spec package: 'PharoJs-Base-Bridge' with: [ spec requires: #('PharoJs-Base-JS-CoreLibraries' 'PharoJs-Base-Exporter' 'PharoJs-Base-App' 'Zinc-WebSocket-Core' 'PharoJs-Base-Serialization')];
			  package: 'PharoJs-Base-Bridge-Tests' with: [ spec requires: #('PharoJs-TestFramework' 'PharoJs-Base-Bridge') ].
		
		"App"
		spec package: 'PharoJs-Base-App' with: [ spec requires: #('PharoJs-Base-Transpiler' 'PharoJs-Base-JS-CoreLibraries') ].
		
		"Examples"	
		spec package: 'PharoJs-Examples' with: [ spec requires: #('PharoJs-Base-App' 'PharoJs-Base-Transpiler' 'PharoJs-TestFramework' 'PharoJs-Base-Exporter') ];
			  package: 'PharoJs-Examples-Tests' with: [ spec requires: #('PharoJs-Examples' 'PharoJs-TestFramework') ].						
		
		"Benchmarking (Timing)"
		spec package: 'PharoJs-Benchmarking' with: [ spec requires: #('PharoJs-Base-Transpiler-Optimizations' 'PharoJs-Base-Bridge') ].
		
		"Utilities - Statistics"					
		spec package: 'PharoJs-Utilities-Statistics' with: [ spec requires: #('PharoJs-Base-Exporter') ].
													
		"Tools"   		
		spec package: 'PharoJs-Tools' with: [ spec requires: #('PharoJs-Base-Bridge') ];
			  package: 'PharoJs-Tools-Tests' with: [ spec requires: #('PharoJs-Tools' 'PharoJs-TestFramework') ].
		
		"Apps and Frameworks (Electron, Express, Node, ...)"
		spec package: 'PharoJs-Base-JS-Electron' with: [ spec requires: #('PharoJs-Base-App') ];
			  package: 'PharoJs-Base-JS-Express' with: [ spec requires: #('PharoJs-Base-App') ];
			  package: 'PharoJs-Base-JS-Node' with: [ spec requires: #('PharoJs-Base-App') ];
			  package: 'PharoJs-Base-JS-Seaside' with: [ spec requires: #('PharoJs-Base-App' 'Seaside3') ];
			  package: 'LightweightObserverJS' with: [ spec requires: #('PharoJs-Base-App' 'LightweightObserver') ] 
		 
]

{ #category : 'private - accessing' }
BaselineOfPharoJS >> prerequisites: spec [
	"Add the projects prerequisite definitions to the given spec"

	"Prerequisite Baselines"

	spec
		baseline: 'PharoExtra'
		with: [ spec repository: 'github://bouraqadi/PharoMisc:pharo12/Pharo' ];
		baseline: 'LightweightObserver'
		with: [ spec repository: 'github://bouraqadi/PharoMisc:pharo12/Pharo' ];
		baseline: 'Seaside3'
		with: [
			spec repository: 'github://SeasideSt/Seaside:master/repository' ].

	"Prerequisite Packages"
	spec
		package: 'Zinc-WebSocket-Core'
		with: [ spec repository: 'github://svenvc/zinc/repository' ]
]
