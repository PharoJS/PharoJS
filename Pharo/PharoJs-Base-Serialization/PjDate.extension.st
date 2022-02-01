Extension { #name : #PjDate }

{ #category : #'*PharoJs-Base-Serialization' }
PjDate class >> instantiateWithPhxJsonReader: reader instanceJsonObject: str [
	"<javascript:
		'  var y = str.substr(0,4),
        m = str.substr(5,2) - 1,
        d = str.substr(8,2);
    return new Date(y,m,d);'>"

	<javascript: 'return new Date(str);'>
]

{ #category : #'*PharoJs-Base-Serialization' }
PjDate class >> phxJsonClassName [
	^ 'DateAndTime'
]

{ #category : #'*PharoJs-Base-Serialization' }
PjDate >> writePhxJsonRepresentationOn: w [
	w writeQuoted: "self yyyymmdd" self toISOString "toString"
]

{ #category : #'*PharoJs-Base-Serialization' }
PjDate >> yyyymmdd [
	<javascript: ' var d = new Date(this),
        month = "" + (d.getMonth() + 1),
        day = "" + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) 
        month = "0" + month;
    if (day.length < 2) 
        day = "0" + day;

    return [year, month, day].join("-");'>
]
