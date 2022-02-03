Class {
	#name : #NsUtility,
	#superclass : #Object,
	#category : #'PharoJs-Base-JS-Node-Utility'
}

{ #category : #'as yet unclassified' }
NsUtility class >> GUID [
	" https://gist.github.com/LeverOne/1308368 "
	<javascript:
	'var a="",b=a;for(;a++<36;b+=a*51&52?(a^15?8^Math.random()*(a^20?16:4):4).toString(16):"-");return b'>
]
