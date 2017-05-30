Class {
	#name : #PjHtmlGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'generator'
	],
	#category : #'PharoJsBridge-Tests'
}

{ #category : #asserting }
PjHtmlGeneratorTest >> assert: aString equalsIgnoringLineEndings: aString2 [ 
	self assert: (aString withLineEndings: '') equals: (aString2 withLineEndings: '')
]

{ #category : #running }
PjHtmlGeneratorTest >> setUp [
	super setUp.
	generator := PjHtmlGenerator new.

]

{ #category : #testing }
PjHtmlGeneratorTest >> testAttributedLoadFrom [
	generator loadFrom: '<head>the head</head>blah<body att="foo">the body</body>'.
	self assert: generator html equalsIgnoringLineEndings: '<!DOCTYPE html>
<meta charset="utf-8" />
<head>
the head
</head>
<body att="foo">
the body

</body>
</html>'
]

{ #category : #testing }
PjHtmlGeneratorTest >> testAugmentedLoadFrom [
	generator loadFrom: '<head>the head</head>blah<body>the body</body>'.
	generator addCssLink: 'foo.css'.
	generator addScriptUrl: 'foo.js'.
	self assert: generator html equalsIgnoringLineEndings: '<!DOCTYPE html>
<meta charset="utf-8" />
<head>
the head
<link rel="stylesheet" type="text/css" href="foo.css">
</head>
<body>
the body
<script language="javascript" type="text/javascript" src="foo.js"></script>
</body>
</html>'
]

{ #category : #testing }
PjHtmlGeneratorTest >> testNoBodyLoadFrom [
	generator loadFrom: 'blah<head>the head</head>'.
	self assert: generator html equalsIgnoringLineEndings: '<!DOCTYPE html>
<meta charset="utf-8" />
<head>
the head
</head>
<body>
<!-- no body tag in file -->

</body>
</html>'
]

{ #category : #testing }
PjHtmlGeneratorTest >> testNoHeadLoadFrom [
	generator loadFrom: 'blah<body>the body</body>'.
	self assert: generator html equalsIgnoringLineEndings: '<!DOCTYPE html>
<meta charset="utf-8" />
<head>
<!-- no head tag in file -->
</head>
<body>
the body

</body>
</html>'
]

{ #category : #testing }
PjHtmlGeneratorTest >> testSimpleLoadFrom [
	generator loadFrom: '<head>the head</head>blah<body>the body</body>'.
	self assert: generator html equalsIgnoringLineEndings: '<!DOCTYPE html>
<meta charset="utf-8" />
<head>
the head
</head>
<body>
the body

</body>
</html>'
]
