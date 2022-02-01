"
Obviously one of the most rudimentary needs is the ability to transfer instances between pharo an js world in a transparent and reciprocal way.
I concidered using STON or NeoJson, but neither are useable in js world (I think? By the way, I really miss String streamContents in js )
Eventhough it feels like I'm trying to reïnvent the wheel, I just started working on r/w classes: PhxJsonWriter and PhxJsonReader.

The serialized form is pure JSON. It includes meta info, needed for deserialization.
example:
	(Date newDay: 1 month: 2 year: 2003) asPhxJsonString  evaluates as: '{""class"":""Date"",""instance"":""2003-02-01""}'.
	
It's a bit like STON except:
-it's pure JSON (not a superset)
-The  r/w classes can be used in js world.

It also uses references to instances (for efficiency an cyclic problems)

So far following tests are green in Pharo.
	self isEqualAfterWriteReadCycle: {}.
	self isEqualAfterWriteReadCycle: OrderedCollection new.
	self isEqualAfterWriteReadCycle: Date today.	
	self isEqualAfterWriteReadCycle: DateAndTime now.	
	self isEqualAfterWriteReadCycle: 'Hi there, I''m just a ""String"", and I cost only 2€. Olé!'.
	self isEqualAfterWriteReadCycle: Object new.
	self isEqualAfterWriteReadCycle: 123456789.
	self isEqualAfterWriteReadCycle: 12345.6789.
	self isEqualAfterWriteReadCycle: PhxJsonWriter testObject1
	
Now I stumble upon the fact that OrderedCollection in js world becomes an Array.
Also DateAndTime becomes a Date in js.
Suggestions or ideas anyone?
"
Class {
	#name : #ManifestPharoJsBaseSerialization,
	#superclass : #PackageManifest,
	#category : #'PharoJs-Base-Serialization-Manifest'
}
