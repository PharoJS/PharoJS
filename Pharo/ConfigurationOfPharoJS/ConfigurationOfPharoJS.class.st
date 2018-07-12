Class {
	#name : #ConfigurationOfPharoJS,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfPharoJS
}

{ #category : #'development support' }
ConfigurationOfPharoJS class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>
]

{ #category : #private }
ConfigurationOfPharoJS class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #'ConfigurationOf'
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #'ConfigurationOf' ifAbsent: aBlock ].
]

{ #category : #private }
ConfigurationOfPharoJS class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfPharoJS class >> ensureMetacelloBaseConfiguration [
  Smalltalk
    at: #'ConfigurationOf'
    ifAbsent: [ 
      | repository version |
      repository := MCHttpRepository
        location: 'http://smalltalkhub.com/mc/dkh/metacello/main'
        user: ''
        password: ''.
      repository
        versionReaderForFileNamed: 'Metacello-Base-dkh.107'
        do: [ :reader | 
          version := reader version.
          version load.
          version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfPharoJS class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfPharoJS class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfPharoJS class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfPharoJS class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfPharoJS class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfPharoJS class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfPharoJS >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/noury/PharoJS/main/'.
		spec 
			project: 'ReusableBricks' with: [
				spec
					className: #ConfigurationOfReusableBricks;
					versionString: #'stable';
					loads: #('Equals' );
					repository: 'http://smalltalkhub.com/mc/CAR/ReusableBricks/main/' ];
			project: 'WebBrowser' with: [
				spec
					className: #ConfigurationOfWebBrowser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/TorstenBergmann/WebBrowser/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					loads: #('Zinc-WebSocket-Core' );
					repository: 'http://mc.stfx.eu/ZincHTTPComponents' ].
		spec 
			package: 'PharoJsApp' with: [
				spec requires: #('PharoJsTranspiler' ). ];
			package: 'PharoJsBridge' with: [
				spec requires: #(#PharoJsCoreLibraries #PharoJsExporter 'PharoJsApp' 'WebBrowser' 'ZincHTTPComponents' ). ];
			package: #PharoJsCoreLibraries with: [
				spec requires: #('PharoJsTranspiler' ). ];
			package: 'PharoJsExamples' with: [
				spec requires: #('PharoJsApp' 'PharoJsTranspiler' 'PharoJsTestFramework' ). ];
			package: #PharoJsExporter with: [
				spec requires: #('PharoJsTranspiler' 'PharoJsApp' ). ];
			package: 'PharoJsTestFramework' with: [
				spec requires: #(#PharoJsExporter 'PharoJsBridge' 'PharoJsApp' ). ];
			package: #PharoJsTiming with: [
				spec requires: #(#PharoJsTranspilerOptimization 'PharoJsBridge' ). ];
			package: 'PharoJsTools' with: [
				spec requires: #('PharoJsBridge' ). ];
			package: 'PharoJsTranspiler' with: [
				spec requires: #('ReusableBricks' ). ];
			package: #PharoJsTranspilerOptimization with: [
				spec requires: #('PharoJsTranspiler' ). ]. ].

]

{ #category : #baselines }
ConfigurationOfPharoJS >> baseline02: spec [
	<version: '0.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/noury/PharoJS/main/'.
		spec 
			project: 'ReusableBricks' with: [
				spec
					className: #ConfigurationOfReusableBricks;
					versionString: #'stable';
					loads: #('Equals' );
					repository: 'http://smalltalkhub.com/mc/CAR/ReusableBricks/main/' ];
			project: 'WebBrowser' with: [
				spec
					className: #ConfigurationOfWebBrowser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/TorstenBergmann/WebBrowser/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					loads: #('Zinc-WebSocket-Core' );
					repository: 'http://mc.stfx.eu/ZincHTTPComponents' ].
		spec 
			package: 'PharoJsApp' with: [
				spec requires: #('PharoJsTranspiler' ). ];
			package: 'PharoJsBridge' with: [
				spec requires: #(#PharoJsCoreLibraries #PharoJsExporter 'PharoJsApp' 'WebBrowser' 'ZincHTTPComponents' ). ];
			package: #PharoJsCoreLibraries with: [
				spec requires: #('PharoJsTranspiler' ). ];
			package: #PharoJsCoreLibrariesTest with: [
				spec requires: #(#PharoJsCoreLibraries 'PharoJsBridge' ). ];
			package: 'PharoJsExamples' with: [
				spec requires: #('PharoJsApp' 'PharoJsTranspiler' 'PharoJsTestFramework' ). ];
			package: #PharoJsExporter with: [
				spec requires: #('PharoJsTranspiler' 'PharoJsApp' ). ];
			package: 'PharoJsTestFramework' with: [
				spec requires: #(#PharoJsExporter 'PharoJsBridge' 'PharoJsApp' ). ];
			package: #PharoJsTiming with: [
				spec requires: #(#PharoJsTranspilerOptimization 'PharoJsBridge' ). ];
			package: 'PharoJsTools' with: [
				spec requires: #('PharoJsBridge' ). ];
			package: 'PharoJsTranspiler' with: [
				spec requires: #('ReusableBricks' ). ];
			package: #PharoJsTranspilerOptimization with: [
				spec requires: #('PharoJsTranspiler' ). ]. ].

]

{ #category : #baselines }
ConfigurationOfPharoJS >> baseline03: spec [
	<version: '0.3-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/noury/PharoJS/main/'.
		spec 
			project: 'PharoExtra' with: [
				spec
					className: #ConfigurationOfPharoExtra;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/noury/Misc/main/' ];
			project: 'ReusableBricks' with: [
				spec
					className: #ConfigurationOfReusableBricks;
					versionString: #'stable';
					loads: #('Equals' );
					repository: 'http://smalltalkhub.com/mc/CAR/ReusableBricks/main/' ];
			project: 'WebBrowser' with: [
				spec
					className: #ConfigurationOfWebBrowser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/TorstenBergmann/WebBrowser/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					loads: #('Zinc-WebSocket-Core' );
					repository: 'http://mc.stfx.eu/ZincHTTPComponents' ].
		spec 
			package: 'PharoJsApp' with: [
				spec requires: #('PharoJsTranspiler' ). ];
			package: 'PharoJsBridge' with: [
				spec requires: #(#PharoJsCoreLibraries #PharoJsExporter 'PharoJsApp' 'WebBrowser' 'ZincHTTPComponents' ). ];
			package: #PharoJsCoreLibraries with: [
				spec requires: #('PharoJsTranspiler' ). ];
			package: #PharoJsCoreLibrariesTest with: [
				spec requires: #(#PharoJsCoreLibraries 'PharoJsBridge' ). ];
			package: 'PharoJsExamples' with: [
				spec requires: #('PharoJsApp' 'PharoJsTranspiler' 'PharoJsTestFramework' ). ];
			package: #PharoJsExporter with: [
				spec requires: #('PharoJsTranspiler' 'PharoJsApp' ). ];
			package: 'PharoJsTestFramework' with: [
				spec requires: #(#PharoJsExporter 'PharoJsBridge' 'PharoJsApp' ). ];
			package: #PharoJsTiming with: [
				spec requires: #(#PharoJsTranspilerOptimization 'PharoJsBridge' ). ];
			package: 'PharoJsTools' with: [
				spec requires: #('PharoJsBridge' ). ];
			package: 'PharoJsTranspiler' with: [
				spec requires: #('ReusableBricks' ). ];
			package: #PharoJsTranspilerOptimization with: [
				spec requires: #('PharoJsTranspiler' ). ]. ].

]

{ #category : #baselines }
ConfigurationOfPharoJS >> baseline04: spec [
	<version: '0.4-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/noury/PharoJS/main/'.
		spec 
			project: 'PharoExtra' with: [
				spec
					className: #ConfigurationOfPharoExtra;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/noury/Misc/main/' ];
			project: 'ReusableBricks' with: [
				spec
					className: #ConfigurationOfReusableBricks;
					versionString: #'stable';
					loads: #('Equals' );
					repository: 'http://smalltalkhub.com/mc/CAR/ReusableBricks/main/' ];
			project: 'WebBrowser' with: [
				spec
					className: #ConfigurationOfWebBrowser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/TorstenBergmann/WebBrowser/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					loads: #('Zinc-WebSocket-Core' );
					repository: 'http://mc.stfx.eu/ZincHTTPComponents' ].
		spec 
			package: 'PharoJsApp' with: [
				spec requires: #('PharoJsTranspiler' ). ];
			package: 'PharoJsBridge' with: [
				spec requires: #(#PharoJsCoreLibraries #PharoJsExporter 'PharoJsApp' 'WebBrowser' 'ZincHTTPComponents' ). ];
			package: #PharoJsBridgeTest with: [
				spec requires: #('PharoJsTestFramework' 'PharoJsBridge' ). ];
			package: #PharoJsCoreLibraries with: [
				spec requires: #('PharoJsTranspiler' 'PharoExtra' ). ];
			package: #PharoJsCoreLibrariesTest with: [
				spec requires: #(#PharoJsCoreLibraries 'PharoJsBridge' 'PharoJsTestFramework' #PharoJsBridgeTest ). ];
			package: 'PharoJsExamples' with: [
				spec requires: #('PharoJsApp' 'PharoJsTranspiler' 'PharoJsTestFramework' ). ];
			package: #PharoJsExporter with: [
				spec requires: #('PharoJsTranspiler' 'PharoJsApp' ). ];
			package: 'PharoJsTestFramework' with: [
				spec requires: #(#PharoJsExporter 'PharoJsBridge' 'PharoJsApp' ). ];
			package: #PharoJsTiming with: [
				spec requires: #(#PharoJsTranspilerOptimization 'PharoJsBridge' ). ];
			package: 'PharoJsTools' with: [
				spec requires: #('PharoJsBridge' ). ];
			package: 'PharoJsTranspiler' with: [
				spec requires: #('ReusableBricks' ). ];
			package: #PharoJsTranspilerOptimization with: [
				spec requires: #('PharoJsTranspiler' ). ]. ].

]

{ #category : #accessing }
ConfigurationOfPharoJS >> customProjectAttributes [
    "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes "

    ^ #()
]

{ #category : #'symbolic versions' }
ConfigurationOfPharoJS >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.4-baseline'.

]

{ #category : #accessing }
ConfigurationOfPharoJS >> project [ 
    ^ project 
        ifNil: [ 
            "Bootstrap Metacello if it is not already loaded"
            self class ensureMetacello.
            project := MetacelloMCProject new projectAttributes: self customProjectAttributes.	"Create the Metacello project"
            (Smalltalk at: #'MetacelloVersionConstructor') on: self project: project.	"Construct the project"
            project loadType: #'linear'.	"change to #atomic if desired"
            project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfPharoJS >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.10'.

]

{ #category : #versions }
ConfigurationOfPharoJS >> version10: spec [
	<version: '1.0' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0'.
		spec author: 'NouryBouraqadi'.
		spec timestamp: '12/7/2016 13:19'.
		spec 
			project: 'ReusableBricks' with: '1.2';
			project: 'WebBrowser' with: '0.2.0';
			project: 'ZincHTTPComponents' with: '2.8.0'.
		spec 
			package: 'PharoJsApp' with: 'PharoJsApp-DaveMason.23';
			package: 'PharoJsBridge' with: 'PharoJsBridge-NouryBouraqadi.86';
			package: #PharoJsCoreLibraries with: 'PharoJsCoreLibraries-NouryBouraqadi.67';
			package: 'PharoJsExamples' with: 'PharoJsExamples-NouryBouraqadi.17';
			package: #PharoJsExporter with: 'PharoJsExporter-DaveMason.54';
			package: 'PharoJsTestFramework' with: 'PharoJsTestFramework-NouryBouraqadi.35';
			package: #PharoJsTiming with: 'PharoJsTiming-DaveMason.16';
			package: 'PharoJsTools' with: 'PharoJsTools-DaveMason.22';
			package: 'PharoJsTranspiler' with: 'PharoJsTranspiler-NouryBouraqadi.237';
			package: #PharoJsTranspilerOptimization with: 'PharoJsTranspilerOptimization-DaveMason.35'. ].

]

{ #category : #versions }
ConfigurationOfPharoJS >> version110: spec [
	<version: '1.10' imports: #('0.4-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.10'.
		spec author: 'NouryBouraqadi'.
		spec timestamp: '7/12/2018 12:06'.
		spec 
			project: 'PharoExtra' with: '0.1-baseline';
			project: 'ReusableBricks' with: '1.3';
			project: 'WebBrowser' with: '0.3.0';
			project: 'ZincHTTPComponents' with: '2.9.3'.
		spec 
			package: 'PharoJsApp' with: 'PharoJsApp-NouryBouraqadi.34';
			package: 'PharoJsBridge' with: 'PharoJsBridge-NouryBouraqadi.144';
			package: #PharoJsBridgeTest with: 'PharoJsBridgeTest-NouryBouraqadi.6';
			package: #PharoJsCoreLibraries with: 'PharoJsCoreLibraries-NouryBouraqadi.133';
			package: #PharoJsCoreLibrariesTest with: 'PharoJsCoreLibrariesTest-NouryBouraqadi.34';
			package: 'PharoJsExamples' with: 'PharoJsExamples-NouryBouraqadi.31';
			package: #PharoJsExporter with: 'PharoJsExporter-NouryBouraqadi.76';
			package: 'PharoJsTestFramework' with: 'PharoJsTestFramework-NouryBouraqadi.66';
			package: #PharoJsTiming with: 'PharoJsTiming-NouryBouraqadi.25';
			package: 'PharoJsTools' with: 'PharoJsTools-NouryBouraqadi.36';
			package: 'PharoJsTranspiler' with: 'PharoJsTranspiler-NouryBouraqadi.265';
			package: #PharoJsTranspilerOptimization with: 'PharoJsTranspilerOptimization-DaveMason.42'. ].

]

{ #category : #versions }
ConfigurationOfPharoJS >> version11: spec [
	<version: '1.1' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.1'.
		spec author: 'NouryBouraqadi'.
		spec timestamp: '2/6/2017 17:53'.
		spec 
			project: 'ReusableBricks' with: '1.2';
			project: 'WebBrowser' with: '0.2.0';
			project: 'ZincHTTPComponents' with: '2.8.2'.
		spec 
			package: 'PharoJsApp' with: 'PharoJsApp-NouryBouraqadi.25';
			package: 'PharoJsBridge' with: 'PharoJsBridge-NouryBouraqadi.109';
			package: #PharoJsCoreLibraries with: 'PharoJsCoreLibraries-NouryBouraqadi.77';
			package: 'PharoJsExamples' with: 'PharoJsExamples-NouryBouraqadi.22';
			package: #PharoJsExporter with: 'PharoJsExporter-nouryBouraqadi.64';
			package: 'PharoJsTestFramework' with: 'PharoJsTestFramework-NouryBouraqadi.38';
			package: #PharoJsTiming with: 'PharoJsTiming-DaveMason.20';
			package: 'PharoJsTools' with: 'PharoJsTools-NouryBouraqadi.32';
			package: 'PharoJsTranspiler' with: 'PharoJsTranspiler-NouryBouraqadi.246';
			package: #PharoJsTranspilerOptimization with: 'PharoJsTranspilerOptimization-DaveMason.35'. ].

]

{ #category : #versions }
ConfigurationOfPharoJS >> version12: spec [
	<version: '1.2' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.2'.
		spec author: 'NouryBouraqadi'.
		spec timestamp: '2/18/2017 20:29'.
		spec 
			project: 'ReusableBricks' with: '1.2';
			project: 'WebBrowser' with: '0.2.0';
			project: 'ZincHTTPComponents' with: '2.8.3'.
		spec 
			package: 'PharoJsApp' with: 'PharoJsApp-NouryBouraqadi.25';
			package: 'PharoJsBridge' with: 'PharoJsBridge-DaveMason.111';
			package: #PharoJsCoreLibraries with: 'PharoJsCoreLibraries-DaveMason.79';
			package: 'PharoJsExamples' with: 'PharoJsExamples-NouryBouraqadi.22';
			package: #PharoJsExporter with: 'PharoJsExporter-DaveMason.65';
			package: 'PharoJsTestFramework' with: 'PharoJsTestFramework-NouryBouraqadi.38';
			package: #PharoJsTiming with: 'PharoJsTiming-DaveMason.20';
			package: 'PharoJsTools' with: 'PharoJsTools-DaveMason.33';
			package: 'PharoJsTranspiler' with: 'PharoJsTranspiler-DaveMason.248';
			package: #PharoJsTranspilerOptimization with: 'PharoJsTranspilerOptimization-DaveMason.36'. ].

]

{ #category : #versions }
ConfigurationOfPharoJS >> version13: spec [
	<version: '1.3' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.3'.
		spec author: 'NouryBouraqadi'.
		spec timestamp: '3/9/2017 17:03'.
		spec 
			project: 'ReusableBricks' with: '1.2';
			project: 'WebBrowser' with: '0.2.0';
			project: 'ZincHTTPComponents' with: '2.8.3'.
		spec 
			package: 'PharoJsApp' with: 'PharoJsApp-DaveMason.27';
			package: 'PharoJsBridge' with: 'PharoJsBridge-DaveMason.114';
			package: #PharoJsCoreLibraries with: 'PharoJsCoreLibraries-NouryBouraqadi.85';
			package: #PharoJsCoreLibrariesTest with: 'PharoJsCoreLibrariesTest-NouryBouraqadi.5';
			package: 'PharoJsExamples' with: 'PharoJsExamples-NouryBouraqadi.24';
			package: #PharoJsExporter with: 'PharoJsExporter-DaveMason.67';
			package: 'PharoJsTestFramework' with: 'PharoJsTestFramework-NouryBouraqadi.43';
			package: #PharoJsTiming with: 'PharoJsTiming-DaveMason.20';
			package: 'PharoJsTools' with: 'PharoJsTools-DaveMason.33';
			package: 'PharoJsTranspiler' with: 'PharoJsTranspiler-DaveMason.251';
			package: #PharoJsTranspilerOptimization with: 'PharoJsTranspilerOptimization-DaveMason.36'. ].

]

{ #category : #versions }
ConfigurationOfPharoJS >> version14: spec [
	<version: '1.4' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.4'.
		spec author: 'NouryBouraqadi'.
		spec timestamp: '5/4/2017 11:54'.
		spec 
			project: 'ReusableBricks' with: '1.2';
			project: 'WebBrowser' with: '0.2.0';
			project: 'ZincHTTPComponents' with: '2.8.3'.
		spec 
			package: 'PharoJsApp' with: 'PharoJsApp-NouryBouraqadi.28';
			package: 'PharoJsBridge' with: 'PharoJsBridge-NouryBouraqadi.120';
			package: #PharoJsCoreLibraries with: 'PharoJsCoreLibraries-NouryBouraqadi.91';
			package: #PharoJsCoreLibrariesTest with: 'PharoJsCoreLibrariesTest-NouryBouraqadi.7';
			package: 'PharoJsExamples' with: 'PharoJsExamples-NouryBouraqadi.25';
			package: #PharoJsExporter with: 'PharoJsExporter-NouryBouraqadi.68';
			package: 'PharoJsTestFramework' with: 'PharoJsTestFramework-NouryBouraqadi.48';
			package: #PharoJsTiming with: 'PharoJsTiming-DaveMason.20';
			package: 'PharoJsTools' with: 'PharoJsTools-DaveMason.33';
			package: 'PharoJsTranspiler' with: 'PharoJsTranspiler-NouryBouraqadi.252';
			package: #PharoJsTranspilerOptimization with: 'PharoJsTranspilerOptimization-NouryBouraqadi.37'. ].

]

{ #category : #versions }
ConfigurationOfPharoJS >> version15: spec [
	<version: '1.5' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.5'.
		spec author: 'NouryBouraqadi'.
		spec timestamp: '7/26/2017 10:21'.
		spec 
			project: 'ReusableBricks' with: '1.2';
			project: 'WebBrowser' with: '0.2.0';
			project: 'ZincHTTPComponents' with: '2.8.8'.
		spec 
			package: 'PharoJsApp' with: 'PharoJsApp-DaveMason.29';
			package: 'PharoJsBridge' with: 'PharoJsBridge-DaveMason.122';
			package: #PharoJsCoreLibraries with: 'PharoJsCoreLibraries-DaveMason.101';
			package: #PharoJsCoreLibrariesTest with: 'PharoJsCoreLibrariesTest-DaveMason.16';
			package: 'PharoJsExamples' with: 'PharoJsExamples-NouryBouraqadi.25';
			package: #PharoJsExporter with: 'PharoJsExporter-DaveMason.70';
			package: 'PharoJsTestFramework' with: 'PharoJsTestFramework-NouryBouraqadi.48';
			package: #PharoJsTiming with: 'PharoJsTiming-DaveMason.24';
			package: 'PharoJsTools' with: 'PharoJsTools-DaveMason.34';
			package: 'PharoJsTranspiler' with: 'PharoJsTranspiler-DaveMason.254';
			package: #PharoJsTranspilerOptimization with: 'PharoJsTranspilerOptimization-DaveMason.39'. ].

]

{ #category : #versions }
ConfigurationOfPharoJS >> version16: spec [
	<version: '1.6' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.6'.
		spec author: 'NouryBouraqadi'.
		spec timestamp: '8/24/2017 18:28'.
		spec 
			project: 'PharoExtra' with: '0.1-baseline';
			project: 'ReusableBricks' with: '1.2';
			project: 'WebBrowser' with: '0.2.0';
			project: 'ZincHTTPComponents' with: '2.8.8'.
		spec 
			package: 'PharoJsApp' with: 'PharoJsApp-DaveMason.29';
			package: 'PharoJsBridge' with: 'PharoJsBridge-DaveMason.123';
			package: #PharoJsCoreLibraries with: 'PharoJsCoreLibraries-DaveMason.116';
			package: #PharoJsCoreLibrariesTest with: 'PharoJsCoreLibrariesTest-DaveMason.23';
			package: 'PharoJsExamples' with: 'PharoJsExamples-DaveMason.26';
			package: #PharoJsExporter with: 'PharoJsExporter-DaveMason.70';
			package: 'PharoJsTestFramework' with: 'PharoJsTestFramework-NouryBouraqadi.48';
			package: #PharoJsTiming with: 'PharoJsTiming-DaveMason.24';
			package: 'PharoJsTools' with: 'PharoJsTools-DaveMason.34';
			package: 'PharoJsTranspiler' with: 'PharoJsTranspiler-DaveMason.259';
			package: #PharoJsTranspilerOptimization with: 'PharoJsTranspilerOptimization-DaveMason.41'. ].

]

{ #category : #versions }
ConfigurationOfPharoJS >> version17: spec [
	<version: '1.7' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.7'.
		spec author: 'NouryBouraqadi'.
		spec timestamp: '9/19/2017 16:09'.
		spec 
			project: 'PharoExtra' with: '0.1-baseline';
			project: 'ReusableBricks' with: '1.2';
			project: 'WebBrowser' with: '0.3.0';
			project: 'ZincHTTPComponents' with: '2.8.8'.
		spec 
			package: 'PharoJsApp' with: 'PharoJsApp-DaveMason.29';
			package: 'PharoJsBridge' with: 'PharoJsBridge-DaveMason.124';
			package: #PharoJsCoreLibraries with: 'PharoJsCoreLibraries-DaveMason.118';
			package: #PharoJsCoreLibrariesTest with: 'PharoJsCoreLibrariesTest-DaveMason.23';
			package: 'PharoJsExamples' with: 'PharoJsExamples-DaveMason.26';
			package: #PharoJsExporter with: 'PharoJsExporter-DaveMason.70';
			package: 'PharoJsTestFramework' with: 'PharoJsTestFramework-NouryBouraqadi.48';
			package: #PharoJsTiming with: 'PharoJsTiming-DaveMason.24';
			package: 'PharoJsTools' with: 'PharoJsTools-DaveMason.34';
			package: 'PharoJsTranspiler' with: 'PharoJsTranspiler-DaveMason.260';
			package: #PharoJsTranspilerOptimization with: 'PharoJsTranspilerOptimization-DaveMason.42'. ].

]

{ #category : #versions }
ConfigurationOfPharoJS >> version18: spec [
	<version: '1.8' imports: #('0.4-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.8'.
		spec author: 'NouryBouraqadi'.
		spec timestamp: '1/16/2018 09:55'.
		spec 
			project: 'PharoExtra' with: '0.1-baseline';
			project: 'ReusableBricks' with: '1.3';
			project: 'WebBrowser' with: '0.3.0';
			project: 'ZincHTTPComponents' with: '2.8.9'.
		spec 
			package: 'PharoJsApp' with: 'PharoJsApp-NouryBouraqadi.31';
			package: 'PharoJsBridge' with: 'PharoJsBridge-NouryBouraqadi.136';
			package: #PharoJsBridgeTest with: 'PharoJsBridgeTest-NouryBouraqadi.5';
			package: #PharoJsCoreLibraries with: 'PharoJsCoreLibraries-DaveMason.118';
			package: #PharoJsCoreLibrariesTest with: 'PharoJsCoreLibrariesTest-NouryBouraqadi.24';
			package: 'PharoJsExamples' with: 'PharoJsExamples-NouryBouraqadi.29';
			package: #PharoJsExporter with: 'PharoJsExporter-NouryBouraqadi.75';
			package: 'PharoJsTestFramework' with: 'PharoJsTestFramework-NouryBouraqadi.56';
			package: #PharoJsTiming with: 'PharoJsTiming-NouryBouraqadi.25';
			package: 'PharoJsTools' with: 'PharoJsTools-NouryBouraqadi.36';
			package: 'PharoJsTranspiler' with: 'PharoJsTranspiler-NouryBouraqadi.263';
			package: #PharoJsTranspilerOptimization with: 'PharoJsTranspilerOptimization-DaveMason.42'. ].

]

{ #category : #versions }
ConfigurationOfPharoJS >> version19: spec [
	<version: '1.9' imports: #('0.4-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.9'.
		spec author: 'NouryBouraqadi'.
		spec timestamp: '2/7/2018 09:49'.
		spec 
			project: 'PharoExtra' with: '0.1-baseline';
			project: 'ReusableBricks' with: '1.3';
			project: 'WebBrowser' with: '0.3.0';
			project: 'ZincHTTPComponents' with: '2.8.9'.
		spec 
			package: 'PharoJsApp' with: 'PharoJsApp-NouryBouraqadi.31';
			package: 'PharoJsBridge' with: 'PharoJsBridge-NouryBouraqadi.137';
			package: #PharoJsBridgeTest with: 'PharoJsBridgeTest-NouryBouraqadi.5';
			package: #PharoJsCoreLibraries with: 'PharoJsCoreLibraries-DaveMason.118';
			package: #PharoJsCoreLibrariesTest with: 'PharoJsCoreLibrariesTest-NouryBouraqadi.24';
			package: 'PharoJsExamples' with: 'PharoJsExamples-NouryBouraqadi.29';
			package: #PharoJsExporter with: 'PharoJsExporter-NouryBouraqadi.76';
			package: 'PharoJsTestFramework' with: 'PharoJsTestFramework-NouryBouraqadi.56';
			package: #PharoJsTiming with: 'PharoJsTiming-NouryBouraqadi.25';
			package: 'PharoJsTools' with: 'PharoJsTools-NouryBouraqadi.36';
			package: 'PharoJsTranspiler' with: 'PharoJsTranspiler-NouryBouraqadi.263';
			package: #PharoJsTranspilerOptimization with: 'PharoJsTranspilerOptimization-DaveMason.42'. ].

]
