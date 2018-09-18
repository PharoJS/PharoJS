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
		spec blessing: #'baseline'.
		spec repository: 'github://bouraqadi/PharoJS'.
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
			package: 'PharoJsStatistics' with: [
				spec requires: #(#PharoJsExporter ). ];
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
