|newRepository|
Smalltalk vm maxExternalSemaphoresSilently: 1000.
newRepository := IceRepositoryCreator new
				repository: nil;
				location: '.' asFileReference ;
				createRepository .
newRepository register.
TestCase defaultTimeLimit: 2 minutes.
PjAppTestCase 
	waitTimeoutDuration: 1 minute;
	waitStepDuration: 100 milliSeconds