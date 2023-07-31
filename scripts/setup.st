|newRepository|
Smalltalk vm maxExternalSemaphoresSilently: 1000.
newRepository := IceRepositoryCreator new
				repository: nil;
				location: '.' asFileReference ;
				createRepository .
newRepository register.
TestCase defaultTimeLimit: 5 minutes.