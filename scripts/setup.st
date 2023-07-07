|newRepository|
Smalltalk vm maxExternalSemaphoresSilently: 1000.
newRepository := IceRepositoryCreator new
				repository: nil;
				location: '/home/runner/work/PharoJS/PharoJS' asFileReference ;
				createRepository .
newRepository register.