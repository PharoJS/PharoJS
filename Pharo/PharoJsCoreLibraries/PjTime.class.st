"
Time in the Javascript world
"
Class {
	#name : #PjTime,
	#superclass : #PjObject,
	#category : #'PharoJsCoreLibraries-Kernel'
}

{ #category : #clock }
PjTime class >> millisecondClockValue [
	<javascript: 'if(typeof performance=="object") return performance.now();
if(typeof process=="object"){var hr=process.hrtime();return hr[0]*1000+hr[1]/1000000}
return Date.now()'>

]
