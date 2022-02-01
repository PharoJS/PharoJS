Class {
	#name : #PjRbDeviceTaskDataRecord,
	#superclass : #PjRbObject,
	#instVars : [
		'pending'
	],
	#category : #'PharoJs-Benchmarking-Richards'
}

{ #category : #'instance creation' }
PjRbDeviceTaskDataRecord class >> create [
    ^super new create
]

{ #category : #initialization }
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
