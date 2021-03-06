Class {
	#name : #PjRbDeviceTaskDataRecord,
	#superclass : #PjRbObject,
	#instVars : [
		'pending'
	],
	#category : #'PharoJsTiming-Richards'
}

{ #category : #'instance creation' }
PjRbDeviceTaskDataRecord class >> create [
    ^super new create
]

{ #category : #initialize }
PjRbDeviceTaskDataRecord >> create [
    pending := nil
]

{ #category : #accessing }
PjRbDeviceTaskDataRecord >> pending [
    ^pending
]

{ #category : #accessing }
PjRbDeviceTaskDataRecord >> pending: packet [ 
    pending := packet
]
