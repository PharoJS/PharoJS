|newRepository|
Smalltalk vm maxExternalSemaphoresSilently: 1000.
newRepository := IceRepositoryCreator new
				repository: nil;
				location: '.' asFileReference ;
				createRepository .
newRepository register.
TestCase defaultTimeLimit: 3 minutes.
PjAppTestCase 
	waitTimeoutDuration: 2 minutes;
	waitStepDuration: 300 milliSeconds