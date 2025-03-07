"
To be refactored as a peer instead of a subclass of PillarWebPage.
"
Class {
	#name : #MarkdownWebPage,
	#superclass : #AWebPage,
	#instVars : [
		'yaml'
	],
	#category : #'GToolkit-Demo-WebsiteExplorer-Model'
}

{ #category : #accessing }
MarkdownWebPage >> gtMarkdownFor: aView [
	<gtView>
	| snippet snippetViewModel |
	^ aView explicit
		title: 'Markdown';
		stencil: [ snippet := LeTextSnippet string: self contents.
			snippetViewModel := snippet asSnippetViewModel.
			snippetViewModel coderViewModel
				addShortcut: (BrEditorShortcut lineEnding
						combination: (LeSnippetElement keyboardShortcut: #NewLine)).
			((snippetViewModel snippetView needsEmbellishments: false) asElement
				snippetViewModel: snippetViewModel) vMatchParent ]
]

{ #category : #testing }
MarkdownWebPage >> isRoot [
"If the page's file has a YAML header, we can tell which page is the root."
	^ self permalink = '/'
]

{ #category : #view }
MarkdownWebPage >> overview [
	"For the gtOverviewFor: view. Subclasse may want to extend or replace this."

	^ {'Title' -> self title.
		'File path' -> self path.
		'Permalink' -> self permalink.
		'Url' -> self url.
		'# Links' -> self links size.
		'# Reachable pages' -> self reachable size}
]

{ #category : #accessing }
MarkdownWebPage >> permalink [
	^ (self yaml at: 'permalink' ifAbsent: [ self path removeSuffix: '.md' ])
		removeSuffix: '/'
]

{ #category : #accessing }
MarkdownWebPage >> rawLinks [
	"Returns a collection of TitleString -> LinkString Associations"

	^ rawLinks ifNil: [ rawLinks := self markdownLinks ]
]

{ #category : #links }
MarkdownWebPage >> reachable [
	^ self webPageGroupClass withAll: (self reachableFrom: {self})
]

{ #category : #accessing }
MarkdownWebPage >> title [
	^ title ifNil: [ self yaml at: 'title' ifAbsent: [ 'MISSING TITLE' ] ]
]

{ #category : #accessing }
MarkdownWebPage >> url [
	^ self website url , self permalink 
]

{ #category : #parsing }
MarkdownWebPage >> yaml [
	"I return the YAML header (if any) extended with a binding for the Markdown body."

	^ yaml ifNil: [ yaml := YamlHeaderParser parse: self contents ]
]
