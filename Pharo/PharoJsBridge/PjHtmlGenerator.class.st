"
A PjHtmlGenerator is a facility to build a html pages (strings).

Instance Variables
	bodyStream:		<WriteStream on String>
	headerStream:		<WriteStream on String>
	scriptsStream:		<WriteStream on String>

bodyStream
	- Dedicated to the content of the body

headerStream
	- Dedicated to the content of the header

scriptsStream
	- Dedicated to JavaScript scripts. They are typically inserted at the end of the resulting HTML page (a string)

"
Class {
	#name : #PjHtmlGenerator,
	#superclass : #Object,
	#instVars : [
		'headerStream',
		'bodyStream',
		'scriptsStream',
		'bodyAttributes'
	],
	#category : #'PharoJsBridge-Client-CodeGenerator'
}

{ #category : #public }
PjHtmlGenerator >> add: tag contents: aString [
	self 
		add: tag
		do: [ bodyStream nextPutAll: aString ]
]

{ #category : #public }
PjHtmlGenerator >> add: tag do: aBlock [
	bodyStream
		cr; 
		nextPut: $<;
		nextPutAll: tag;
		nextPut: $>.
	aBlock value.
	bodyStream
		nextPutAll: '</';
		nextPutAll: tag;
		nextPut: $>
]

{ #category : #public }
PjHtmlGenerator >> add: tag id: id class: class contents: aString [
	self 
		add: tag
		id: id
		class: class
		do: [ bodyStream nextPutAll: aString ]
]

{ #category : #public }
PjHtmlGenerator >> add: tag id: id class: class do: aBlock [
	bodyStream
		cr; 
		nextPut: $<;
		nextPutAll: tag.
	id ifNotNil: [ bodyStream nextPutAll: ' id="'; nextPutAll: id;nextPut:$"].
	class ifNotNil: [ bodyStream nextPutAll: ' class="'; nextPutAll: class;nextPut:$"].
	bodyStream
		nextPut: $>.
	aBlock value.
	bodyStream
		nextPutAll: '</';
		nextPutAll: tag;
		nextPut: $>
]

{ #category : #public }
PjHtmlGenerator >> add: tag id: id contents: aString [
	self 
		add: tag
		id: id
		do: [ bodyStream nextPutAll: aString ]
]

{ #category : #public }
PjHtmlGenerator >> add: tag id: id do: aBlock [
	self add: tag id: id class: nil do: aBlock
]

{ #category : #public }
PjHtmlGenerator >> addButton: buttonLabel onClickDo: javaScript [
	bodyStream 
		nextPutAll: '<input type="button" value="';
		nextPutAll: buttonLabel;
		nextPutAll: '" onclick="';
		nextPutAll: javaScript;
		nextPutAll: '" />'
]

{ #category : #public }
PjHtmlGenerator >> addCssLink: aString [
	headerStream 
		nextPutAll: '<link rel="stylesheet" type="text/css" href="',aString,'">'
]

{ #category : #public }
PjHtmlGenerator >> addDiv: id contents: aString [
	self add: 'div' id: id contents: aString
]

{ #category : #public }
PjHtmlGenerator >> addDiv: id do: aBlock [
	self add: 'div' id: id do: aBlock
]

{ #category : #public }
PjHtmlGenerator >> addHtmlToBody: htmlString [
	bodyStream nextPutAll: htmlString
]

{ #category : #public }
PjHtmlGenerator >> addImage: imageUrl [
	bodyStream
		cr; 
		nextPutAll: '<img src="';
		nextPutAll: imageUrl;
		nextPutAll: '" style="width:window.width%;"/>'
]

{ #category : #public }
PjHtmlGenerator >> addScriptString: aString [
	scriptsStream
		nextPutAll: '<script language="javascript" type="text/javascript">';
		nextPutAll: aString;
		nextPutAll: '</script>'
]

{ #category : #public }
PjHtmlGenerator >> addScriptUrl: aString [
	scriptsStream
		nextPutAll: '<script language="javascript" type="text/javascript" src="';
		nextPutAll: aString;
		nextPutAll: '"></script>'
]

{ #category : #public }
PjHtmlGenerator >> addSpan: id contents: aString [
	self add: 'span' id: id contents: aString
]

{ #category : #public }
PjHtmlGenerator >> addSpan: id do: aBlock [
	self add: 'span' id: id do: aBlock
]

{ #category : #public }
PjHtmlGenerator >> addStyle: aString [
	headerStream
		nextPutAll: '<style type="text/css">';
		nextPutAll: aString;
		nextPutAll: '</style>'
]

{ #category : #public }
PjHtmlGenerator >> addTextInput: id hint: hintString on: eventName do: javaScript [
	"eventName can take one of three values: keydown, keypress, keyup"
	"Not keypress event is sent for actual characters and not when keys such as CTL or ALT are pressed"
	bodyStream 
		nextPutAll: '<input type="text" id="';
		nextPutAll: id;
		nextPutAll: '" placeholder="';
		nextPutAll: hintString;
		nextPutAll: '" on';
		nextPutAll: eventName;
		nextPutAll: '="';
		nextPutAll: javaScript;
		nextPutAll: '" />'
]

{ #category : #public }
PjHtmlGenerator >> addTextInput: id hint: hintString onKeyDownDo: javaScript [
	self addTextInput: id hint: hintString on: 'keydown' do: javaScript
]

{ #category : #public }
PjHtmlGenerator >> addTextInput: id hint: hintString onKeyPressDo: javaScript [
	self addTextInput: id hint: hintString on: 'keypress' do: javaScript
]

{ #category : #public }
PjHtmlGenerator >> addTextInput: id hint: hintString onKeyUpDo: javaScript [
	self addTextInput: id hint: hintString on: 'keyup' do: javaScript
]

{ #category : #public }
PjHtmlGenerator >> cr [
	bodyStream nextPutAll: '<br/>'
]

{ #category : #public }
PjHtmlGenerator >> html [
	| htmlStream |
	htmlStream := String new writeStream.
	htmlStream
		nextPutAll: '<!DOCTYPE html>';
		cr;
		nextPutAll: '<meta charset="utf-8" />';
		cr;
		nextPutAll: '<head>';
		cr;
		nextPutAll: headerStream contents;
		cr;
		nextPutAll: '</head>';
		cr;
		nextPutAll: '<body';
		nextPutAll: bodyAttributes contents;
		nextPut: $>;
		cr;
		nextPutAll: bodyStream contents;
		cr;
		nextPutAll: scriptsStream contents;
		cr;
		nextPutAll: '</body>';
		cr;
		nextPutAll: '</html>'.
	^htmlStream contents
]

{ #category : #'initialize-release' }
PjHtmlGenerator >> initialize [
	super initialize.
	headerStream := String new writeStream.
	bodyStream := String new writeStream.
	bodyAttributes := String new writeStream.
	scriptsStream := String new writeStream.
]

{ #category : #public }
PjHtmlGenerator >> loadFrom: aString [
	| hStart hEnd bStart bAngle bEnd |
	hStart := aString indexOfSubCollection: '<head>'.
	hEnd := aString indexOfSubCollection: '</head>'.
	(hStart>0 and: [hEnd>hStart]) ifFalse: [
		headerStream nextPutAll: '<!-- no head tag in file -->'
	] ifTrue: [
		headerStream nextPutAll: (aString copyFrom: hStart+6 to: hEnd-1)].
	bStart := aString indexOfSubCollection: '<body'.
	bAngle := aString findString: '>' startingAt: bStart.
	bEnd := aString indexOfSubCollection: '</body>'.
	(bAngle>0 and: [(aString at: bStart+5)=$ ]) ifTrue: [ bodyAttributes nextPutAll: (aString copyFrom: bStart+5 to: bAngle-1)].
	(bAngle>0 and: [bEnd>bAngle]) ifFalse: [
		bodyStream nextPutAll: '<!-- no body tag in file -->'
	] ifTrue: [
		bodyStream nextPutAll: (aString copyFrom: bAngle+1 to: bEnd-1)].
]

{ #category : #public }
PjHtmlGenerator >> title: aString [
	headerStream 
		nextPutAll: '<title>';
		nextPutAll: aString;
		nextPutAll: '</title>'
]
