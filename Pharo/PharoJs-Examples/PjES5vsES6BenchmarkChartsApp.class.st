"
I provide charts of benchmarks conducted to compare the evolution of the transpiler to generated EcmaScript 6 (ES6) style JS instead of EcmaScript 5 (ES5).
These benchmarks were conducted as part of a paper presented at International Workshop on Smalltalk Technology (IWST) colocated with [ESUG 2023 conference](https://esug.github.io/2023-Conference/conf2023.html) in Lyon, France.

Charts are built using [ChartJS](https://www.chartjs.org) a Simple and flexible JavaScript charting framework.
Just like PharoJS, ChartJS open-source and distributed via GitHub under a MIT License.
"
Class {
	#name : #PjES5vsES6BenchmarkChartsApp,
	#superclass : #PjWebApplication,
	#category : #'PharoJs-Examples-ChartJS'
}

{ #category : #accessing }
PjES5vsES6BenchmarkChartsApp class >> bridgeClientClass [
	<pharoJsSkip>
	^ PjBridgeServedFileBasedBrowserBridgeClient
]
