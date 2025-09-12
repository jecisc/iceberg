"
I am a browser to display multiple `IceTipWorkingCopyBrowser` in tabs instead of having too many windows.
"
Class {
	#name : 'IceTipWorkingCopiesBrowser',
	#superclass : 'IceTipPresenter',
	#instVars : [
		'notebook'
	],
	#category : 'Iceberg-TipUI-View-WorkingCopy',
	#package : 'Iceberg-TipUI',
	#tag : 'View-WorkingCopy'
}

{ #category : 'accessing' }
IceTipWorkingCopiesBrowser class >> defaultPreferredExtent [

	^ 900 @ 600
]

{ #category : 'specs' }
IceTipWorkingCopiesBrowser class >> title [

	^ 'Iceberg Repositories'
]

{ #category : 'adding' }
IceTipWorkingCopiesBrowser >> addProjectNamed: aString provider: aBlock [

	| page |
	page := SpNotebookPage title: aString icon: (self iconNamed: #open) provider: aBlock.
	notebook addPage: page.
	notebook selectPage: page
]

{ #category : 'initialization' }
IceTipWorkingCopiesBrowser >> connectPresenters [

	super connectPresenters.

	notebook whenSelectedPageChangedDo: [ :page | self updateWindowWith: page ]
]

{ #category : 'layout' }
IceTipWorkingCopiesBrowser >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: notebook;
		  yourself
]

{ #category : 'initialization' }
IceTipWorkingCopiesBrowser >> initializePresenters [

	super initializePresenters.

	notebook := self newNotebook
]

{ #category : 'initialization' }
IceTipWorkingCopiesBrowser >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.

	self updateWindowWith: notebook selectedPage
]

{ #category : 'initialization' }
IceTipWorkingCopiesBrowser >> updateWindowWith: page [

	self withWindowDo: [ :window |
			window statusBar: page retrievePresenter statusBar.
			window toolbar: (page activePresenter initializeToolbarWith: page activePresenter cleanRootsCommandGroup).
			page activePresenter takeKeyboardFocus ]
]

{ #category : 'accessing' }
IceTipWorkingCopiesBrowser >> windowTitle [

	^ self class title
]
