Trait {
	#name : #PjTWebClientApp,
	#category : #'PharoJs-Base-App'
}

{ #category : #exporting }
PjTWebClientApp classSide >> defaultAppFolderName [

	<pharoJsSkip>
	^ self serverAppClass staticFilesFolderName
]

{ #category : #exporting }
PjTWebClientApp classSide >> defaultAppFolderParent [

	<pharoJsSkip>
	^ self serverAppClass appFolder
]

{ #category : #exporting }
PjTWebClientApp classSide >> serverAppClass [

	<pharoJsSkip>
	^ self explicitRequirement 
]

{ #category : #'http support' }
PjTWebClientApp >> fetch: path [
	<javascript: 'return window.fetch(path)'>
]

{ #category : #'http support' }
PjTWebClientApp >> fetch: path with: data [

	<javascript: 'return window.fetch(path, data)'>
	
]

{ #category : #'http operations' }
PjTWebClientApp >> get: path withTextDo: thenBlock [

	self
		get: path
		withTextDo: thenBlock
		onErrorDo: [ :error | self logError: error onGet: path ]
]

{ #category : #'http operations' }
PjTWebClientApp >> get: path withTextDo: thenBlock onErrorDo: errorBlock [

	(self fetch: path)
		then: [ :response |
			response text
				then: thenBlock;
				catch: errorBlock ];
		catch: errorBlock
]

{ #category : #logging }
PjTWebClientApp >> log: aString [

	<javascript: 'console.log(aString)'>
	
]

{ #category : #logging }
PjTWebClientApp >> logError: aString [

	<javascript: 'console.error(aString)'>
	
]

{ #category : #logging }
PjTWebClientApp >> logError: error on: httpOperationName path: path [

	| notification |
	notification := String streamContents: [ :str |
		                str
		<< httpOperationName;
			                space;
			                << path;
			                << ' error. ';
			                cr;
			                << error message ].
	^ self logError: notification
]

{ #category : #logging }
PjTWebClientApp >> logError: error onGet: path [

	self logError: error on: 'GET' path: path
]

{ #category : #logging }
PjTWebClientApp >> logError: error onPost: path [

	self logError: error on: 'POST' path: path
]

{ #category : #'http operations' }
PjTWebClientApp >> post: path text: aString [ 
self post: path text: aString then: [ self log: 'Done POST to ', path ]
]

{ #category : #'http operations' }
PjTWebClientApp >> post: path text: aString then: thenBlock [
self post: path text: aString then: thenBlock catch: 

	 [ :error | self logError: error onGet: path ]
]

{ #category : #'http operations' }
PjTWebClientApp >> post: path text: aString then: thenBlock catch: errorBlock [

	(self fetch: path with: {
				 (#method -> 'POST').
				 (#body -> aString) } asJsObject)
		then: thenBlock;
		catch: errorBlock
]
