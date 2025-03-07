"
I am the slideshow for the PetitParser lecture of the [compiler construction course](https://seg.inf.unibe.ch/teaching/current/cc/) at UniBE.
"
Class {
	#name : #SPLPetitParserSlideshow,
	#superclass : #PrioritySlideshow,
	#category : #'GToolkit-Demo-SPL-Slideshows'
}

{ #category : #utility }
SPLPetitParserSlideshow class >> show [
	"Implement this here just so we can run it directly from the Coder."
	super show
]

{ #category : #accessing }
SPLPetitParserSlideshow >> asSmallCode: aString [
	^ aString asRopedText
		glamorousMonospace;
		fontSize: 20
]

{ #category : #slides }
SPLPetitParserSlideshow >> buildingTheAST: aSlide [
	<gtSlide>
	^ aSlide lepiterPage
		setPriority;
		startPage: (self db pageNamed: 'Building the AST with parser actions')
]

{ #category : #page }
SPLPetitParserSlideshow >> buildingTheASTPage [
	<gtExample>
	<noTest>
	^ (LePage named: 'Building the AST with parser actions')
		addSnippet: (LeTextSnippet new
				string: 'The current parser, {{gtClass:name=SPLGrammar}}, just recognizes the grammar, but does nothing with it.';
				yourself);
		addSnippet: (LeTextSnippet new
				string: 'We define a subclass, {{gtClass:name=SPLParser}}, that builds AST nodes.';
				yourself);
		addSnippet: (LeTextSnippet new
				string: 'Actions are specified with the `==>` operation, like this, where we build a {{gtClass:name=SPLPrintStatement}} node for a `print` statement in {{gtMethod:name=SPLParser>>#printStmt|expanded}}';
				yourself);
		addSnippet: (LeTextSnippet new
				string: 'Note that we only want the second part ofthe node that has been parsed by the inherited production, namely the expression.';
				yourself);
		addSnippet: (LeTextSnippet new
				string: 'All the rules look like this.';
				yourself);
		addSnippet: (LePharoSnippet new
				code: 'SPLParser new printStmt parse: ''print "hello";''.';
				yourself);
		yourself
]

{ #category : #slides }
SPLPetitParserSlideshow >> classExtraction: aSlide [
	<gtSlide>
	^ aSlide lepiterPage
		setPriority;
		startPage: (self db pageNamed: 'Extracting a parser class')
]

{ #category : #page }
SPLPetitParserSlideshow >> classExtractionPage [
	<gtExample>
	<noTest>
	^ (LePage named: 'Extracting a parser class')
		addSnippet: (LeTextSnippet new
				string: 'At some point to continue developing the parser, it should be turned into a class, so we can write tests and deploy the parser.';
				yourself);
		addSnippet: (LeTextSnippet new
				string: 'The class can be extracted automatically. First we initailiuze any recursive productions.';
				yourself);
		addSnippet: (LePharoSnippet new
				code: 'expression := PP2UnresolvedNode new.';
				yourself);
		addSnippet: (LeTextSnippet new
				string: 'We create a snippet that contains *only* definitions of rules, with no reference to outside classes or variables.';
				yourself);
		addSnippet: (LePharoSnippet new
				code: 'boolean := ''true'' asPParser trim / ''false'' asPParser trim.
integer := #digit asPParser plus , $. asPParser not trim.
float := $- asPParser optional , #digit asPParser plus , $. asPParser
		, #digit asPParser plus trim.
number := integer / float.
parenthesizedExpression := $( asPParser trim , expression , $) asPParser trim.
primary := parenthesizedExpression / boolean / number.
factor := primary , ($/ asPParser trim / $* asPParser trim , primary) star.
term := factor , (''-'' asPParser trim / ''+'' asPParser trim , factor) star.
expression := term.
exprStmt := expression , $; asPParser trim.
program := exprStmt star end.';
				yourself);
		addSnippet: (LeTextSnippet new
				string: 'We extract the class and test it.';
				yourself);
		addSnippet: (LePharoSnippet new
				code: 'program parse: ''3+4*6;''';
				yourself);
		addSnippet: (LeTextSnippet new
				string: 'Note that the resulting parser class is a subclass of {{gtClass:name=PP2CompositeNode}}, it has both a method and a slot for each production, and a `start` method is automatically generated.';
				yourself);
		yourself
]

{ #category : #slides }
SPLPetitParserSlideshow >> coda: aSlide [
	<gtSlide>
	^ aSlide textAndElement
		elementWeight: 0.5;
		setPriority;
		newTextWithFormat: (self asHeader: 'Explore on your own ...') bold , self cr
				, (self
						asText: 'You can find the details by downloading GT from gtoolkit.com and visiting the “PetitParser SPL case study” page.');
		element: [ | aLepiterBaseName aPageName database startPage |
			aLepiterBaseName := 'Glamorous Toolkit Book'.
			aPageName := 'PetitParser SPL case study'.
			database := LeDatabasesRegistry default currentLoadedDefaultLogicalDatabase
					databaseNamed: aLepiterBaseName.
			startPage := database pageNamed: aPageName.
			startPage asPreviewElement ]
]

{ #category : #slides }
SPLPetitParserSlideshow >> debuggingParsers: aSlide [
	<gtSlide>
	^ aSlide lepiterPage
		setPriority;
		startPage: (self db pageNamed: 'Debugging parsers')
]

{ #category : #page }
SPLPetitParserSlideshow >> debuggingParsersPage [
	<gtExample>
	<noTest>
	^ (LePage named: 'Debugging parsers')
		addSnippet: (LeTextSnippet new
				string: 'The following parser fails to parse the print statement.';
				yourself);
		addSnippet: (LeTextSnippet new
				string: 'We can debug it by inspecting the error, and stepping through the execution trace.';
				yourself);
		addSnippet: (LePharoSnippet new
				code: 'string := $" asPParser , $" asPParser negate plus , $" asPParser.

printStmt := ''print'' asPParser , string , $; asPParser trim.

printStmt end parse: ''print "hello";''.';
				yourself);
		addSnippet: (LeTextSnippet new
				string: 'After debugging, we see that there is a whitespace `trim` missing ...';
				yourself);
		yourself
]

{ #category : #slides }
SPLPetitParserSlideshow >> fibonacci: aSlide [
	<gtSlide>
	^ aSlide lepiterPage
		setPriority;
		startPage: (self db pageNamed: 'Fibonacci in SPL')
]

{ #category : #page }
SPLPetitParserSlideshow >> fibonacciPage [
	<gtExample>
	<noTest>
	^ (LePage named: 'Fibonacci in SPL')
		addSnippet: (LeTextSnippet new
				string: 'Here is a more complex example. Note especially how the `while` statement is reduced.';
				yourself);
		addSnippet: (LePharoSnippet new
				code: 'SPL fibonacci.';
				yourself);
		addSnippet: (LeTextSnippet new
				string: 'Look at the history view to explore the reductions in detail.';
				yourself);
		yourself
]

{ #category : #initialization }
SPLPetitParserSlideshow >> initializeDb [
	self db addPage: self buildingTheASTPage.
	self db addPage: self classExtractionPage.
	self db addPage: self debuggingParsersPage.
	self db addPage: self fibonacciPage.
	self db addPage: self partialGrammarScriptPage.
	self db addPage: self runningAnSPLProgramPage.
	self db addPage: self theASThierarchyPage.
	self db addPage: self writingTestsPage
]

{ #category : #slides }
SPLPetitParserSlideshow >> parsingBooleans: aSlide [
	<gtSlide>
	^ aSlide headingAndCode
		setPriority;
		heading: 'Parsing Booleans';
		snippetPadding: 5;
		addTextSnippet: 'To create a parser for a string, just send it `asParser`.';
		addCodeSnippet: '''true'' asPParser.
''false'' asPParser.';
		addTextSnippet: 'We can compose parsers with the `/` ordered choice operator.';
		addCodeSnippet: 'boolean := ''true'' asPParser 
		/ ''false'' asPParser.
boolean parse: ''true''.'
]

{ #category : #slides }
SPLPetitParserSlideshow >> parsingGrammarRules: aSlide [
	<gtSlide>
	^ aSlide headingAndCode
		setPriority;
		heading: 'Parsing grammar rules';
		elementWeight: 0.3;
		snippetPadding: 5;
		addTextSnippet: 'We continue to implement parsers for declarations and statements.';
		addTextSnippet: 'The `trim` operator is used to trim away whitespace.
The `end` operator ensure that all the input is consumed.';
		addCodeSnippet: 'string := $" asPParser , $" asPParser negate plus , $" asPParser.

printStmt := ''print'' asPParser trim , string , $; asPParser trim.

printStmt end parse: ''print "hello";'''
]

{ #category : #slides }
SPLPetitParserSlideshow >> parsingIntegersAndFloats: aSlide [
	<gtSlide>
	^ aSlide headingAndCode
		setPriority;
		heading: 'Parsing Integers and Floats';
		snippetPadding: 5;
		addTextSnippet: 'Note the use of the `optional`  and `plus` operators.';
		addTextSnippet: 'The `not` operator ensures no period follows an integer,
but no input will be consumed.';
		addCodeSnippet: 'integer := $- asPParser optional ,
		#digit asPParser plus , 
		$. asPParser not.
integer parse: ''42''.';
		addTextSnippet: 'Floats are similar, but with a period.';
		addCodeSnippet: 'float := $- asPParser optional , 
		#digit asPParser plus , 
		$. asPParser, #digit asPParser plus.
float parse: ''3.14''.'
]

{ #category : #slides }
SPLPetitParserSlideshow >> parsingKeywords: aSlide [
	<gtSlide>
	^ aSlide headingAndCode
		setPriority;
		heading: 'Parsing Keywords and Identifiers';
		snippetPadding: 5;
		elementWeight: 0.4;
		addTextSnippet: 'We want to distinguish keywords and identifiers, so we use the `not` operator to ensure that a keyword is not followed by another letter.';
		addCodeSnippet: 'keyword := (''var'' asPParser , #letter asPParser not)
		/ (''if'' asPParser , #letter asPParser not)
		/ (''else'' asPParser , #letter asPParser not)
		/ (''while'' asPParser , #letter asPParser not)
		/ (''true'' asPParser , #letter asPParser not)
		/ (''false'' asPParser , #letter asPParser not)
		/ (''and'' asPParser , #letter asPParser not)
		/ (''or'' asPParser , #letter asPParser not).

identifier := keyword not, #letter asPParser, #word asPParser star.

identifier end parse: ''andy''.'
]

{ #category : #slides }
SPLPetitParserSlideshow >> parsingNumbers: aSlide [
	<gtSlide>
	^ aSlide headingAndCode
		setPriority;
		heading: 'Parsing Numbers';
		snippetPadding: 5;
		addTextSnippet: 'Numbers are an ordered choice of integers and floats.';
		addCodeSnippet: 'integer := $- asPParser optional , 
	#digit asPParser plus , $. asPParser not.
	
float := $- asPParser optional , 
	#digit asPParser plus , $. asPParser,
	#digit asPParser plus.
		
number := integer / float.

number parse: ''-3.14''.'
]

{ #category : #slides }
SPLPetitParserSlideshow >> parsingTokens: aSlide [
	<gtSlide>
	^ aSlide text
		setPriority;
		textMargin: 10;
		newTextWithFormat: (self asHeader: 'Parsing tokens');
		newTextWithFormat: (self
				asText: 'PetitParser is a scannerless parser, so we introduce parsing expressions also for tokens.')
]

{ #category : #slides }
SPLPetitParserSlideshow >> partialGrammarScript: aSlide [
	<gtSlide>
	^ aSlide lepiterPage
		setPriority;
		startPage: (self db pageNamed: 'Prototyping the SPL grammar parser as a script')
]

{ #category : #page }
SPLPetitParserSlideshow >> partialGrammarScriptPage [
	<gtExample>
	<noTest>
	^ (LePage named: 'Prototyping the SPL grammar parser as a script')
		addSnippet: (LeTextSnippet new
				string: 'We iteratively prototype our parser as a script.';
				yourself);
		addSnippet: (LeTextSnippet new
				string: 'Note that recursive productions, like `expression`, have to be initialized and then redefined.';
				yourself);
		addSnippet: (LePharoSnippet new
				code: 'boolean := ''true'' asPParser trim / ''false'' asPParser trim.
integer := #digit asPParser plus , $. asPParser not trim.
float := $- asPParser optional , #digit asPParser plus , $. asPParser
		, #digit asPParser plus trim.
number := integer / float.

"A recursive production must be initialized."
expression := PP2UnresolvedNode new.

parenthesizedExpression := $( asPParser trim , expression , $) asPParser trim.
primary := parenthesizedExpression / boolean / number.
factor := primary , ($/ asPParser trim / $* asPParser trim , primary) star.
term := factor , (''-'' asPParser trim / ''+'' asPParser trim , factor) star.

"Redefine the recursive production."
expression def: term.

exprStmt := expression , $; asPParser trim.
program := exprStmt star end.

"A simple test case."
program parse: ''6 * (3 + 4);''.';
				yourself);
		yourself
]

{ #category : #slides }
SPLPetitParserSlideshow >> runningAnSPLProgram: aSlide [
	<gtSlide>
	^ aSlide lepiterPage
		setPriority;
		startPage: (self db pageNamed: 'Running an SPL program')
]

{ #category : #page }
SPLPetitParserSlideshow >> runningAnSPLProgramPage [
	<gtExample>
	<noTest>
	^ (LePage named: 'Running an SPL program')
		addSnippet: (LeTextSnippet new
				string: 'To run a program, we parse it, and then run it in a *context* that tracks (1) the executing code, (2) the environment, and (3) the output.';
				yourself);
		addSnippet: (LePharoSnippet new
				code: 'SPLContext for: ''var x = 3; print x + 4;''.';
				yourself);
		addSnippet: (LeTextSnippet new
				string: 'As we step through the execution, we see the code being *reduced* step by step, while the environment and output are updated.';
				yourself);
		addSnippet: (LeTextSnippet new
				string: 'We can also see the history of all the states.';
				yourself);
		yourself
]

{ #category : #slides }
SPLPetitParserSlideshow >> semanticsOfSPL: aSlide [
	<gtSlide>
	^ aSlide text
		horizontalWeight: 0.6;
		textMargin: 5;
		setPriority;
		newTextWithFormat: (self asHeader: 'SPL Semantics');
		newTextWithFormat: (self asText: 'We use “small-step” ')
				, (self asText: 'Structural Operational Semantics') italic
				, (self
						asText: ' to model the execution of an SPL program as a sequence of steps from one program state to the next.');
		newTextWithFormat: (self asText: 'Every program state consists of three parts:');
		newTextWithFormat: (self asText: '1.  The rest of the code') bold;
		newTextWithFormat: (self asText: 'The list of statements left to be executed.');
		newTextWithFormat: (self asText: '2. The environment') bold;
		newTextWithFormat: (self asText: 'A dictionary of variables and values.');
		newTextWithFormat: (self asText: '3. The output') bold;
		newTextWithFormat: (self asText: 'The collection of printed output strings.')
]

{ #category : #accessing }
SPLPetitParserSlideshow >> slidePriorities [
	"Instead of manually setting priorities, just list the slides in order here."
	<gtExample>
	^ #( 
		titleSlideFor:

		whatIsPP:
			splGrammar:
			splExample:

		parsingTokens:
			parsingBooleans:
			parsingIntegersAndFloats:
			parsingNumbers:
			parsingKeywords:
	
		parsingGrammarRules:
			debuggingParsers:
		
		partialGrammarScript:
			classExtraction:
			writingTests:
		
		buildingTheAST:
			theASThierarchy:
		
		semanticsOfSPL:
			runningAnSPLProgram:
			fibonacci:
		
		coda:
			
	)
]

{ #category : #slides }
SPLPetitParserSlideshow >> splExample: aSlide [
	<gtSlide>
	^ aSlide text
		horizontalWeight: 0.75;
		textMargin: 10;
		setPriority;
		newTextWithFormat: (self asHeader: 'An SPL example');
		newTextWithFormat: (self asText: 'SPL is a minimal language with variables, expressions, ')
				, (self asCode: 'if') , (self asText: ', ') , (self asCode: 'while')
				, (self asText: ' and ') , (self asCode: 'print')
				, (self asText: ' statements, but no procedures or classes.');
		newTextWithFormat: (self
				asCode: '// Factorial in SPL -- computes the factorial of arg
var arg=5;
var x=arg;
var fact=1;
while (x>0) {
	fact = fact * x;
	x = x - 1;
}
print fact;
')
]

{ #category : #slides }
SPLPetitParserSlideshow >> splGrammar: aSlide [
	<gtSlide>
	^ aSlide text
		horizontalWeight: 1;
		textMargin: 10;
		setPriority;
		newTextWithFormat: (self asHeader: 'SPL Grammar');
		newTextWithFormat: (self
				asSmallCode: 'program        := declaration* EOF ;
declaration    := varDecl
               | statement ;
varDecl        := "var" IDENTIFIER ( "=" expression )? ";" ;
statement      := exprStmt
               | ifStmt
               | printStmt
               | whileStmt
               | block ;
exprStmt       := expression ";" ;
ifStmt         := "if" "(" expression ")" statement ( "else" statement )? ;
printStmt      := "print" expression ";" ;
whileStmt      := "while" "(" expression ")" statement ;
block          := "{" declaration* "}" ;
expression     := assignment ;
assignment     := IDENTIFIER "=" assignment
               | logic_or ;
logic_or       := logic_and ( "or" logic_and )* ;
logic_and      := equality ( "and" equality )* ;
equality       := comparison ( ( "!=" | "==" ) comparison )* ;
comparison     := term ( ( ">" | ">=" | "<" | "<=" ) term )* ;
term           := factor ( ( "-" | "+" ) factor )* ;
factor         := unary ( ( "/" | "*" ) unary )* ;
unary          := ( "!" | "-" ) unary
               | primary ;
primary        := "true" | "false" | NUMBER | STRING
               | "(" expression ")"
               | IDENTIFIER ;
')
]

{ #category : #slides }
SPLPetitParserSlideshow >> theASThierarchy: aSlide [
	<gtSlide>
	^ aSlide lepiterPage
		setPriority;
		startPage: (self db pageNamed: 'The SPL AST hierarchy')
]

{ #category : #page }
SPLPetitParserSlideshow >> theASThierarchyPage [
	<gtExample>
	<noTest>
	^ (LePage named: 'The SPL AST hierarchy')
		addSnippet: (LeTextSnippet new
				string: 'Each node can handle pretty printing, and supports step-by-step interpretation.';
				yourself);
		addSnippet: (LeExampleSnippet new
				exampleBehaviorName: #SPLCaseStudyExamples;
				exampleSelector: #splNodeHierarchy;
				noCode: true;
				previewShowSelector: #gtLiveFor:;
				previewHeight: 700);
		addSnippet: (LeTextSnippet new
				string: 'Each node can handle pretty printing, and supports step-by-step interpretation.';
				yourself);
		yourself
]

{ #category : #slides }
SPLPetitParserSlideshow >> titleSlideFor: aSlide [
	<gtSlide>
	^ aSlide title
		setPriority;
		titleBottomPadding: 30;
		titleWithFormat: (self asTitle: 'Building composable parsers');
		subtitleWithFormat: (self asTitle: 'with PetitParser')
]

{ #category : #slides }
SPLPetitParserSlideshow >> whatIsPP: aSlide [
	<gtSlide>
	^ aSlide headingAndCode
		setPriority;
		heading: 'What is PetitParser?';
		addTextSnippet: 'PetitParser models parsers as *composable* objects.';
		addCodeSnippet: 'number := #digit asPParser plus  token
	==> [ :token | token  value asNumber ].

addition := (number , $+ asPParser  , number)
	==> [ :nodes | nodes first + nodes last ].

addition parse: ''3+4'''
]

{ #category : #slides }
SPLPetitParserSlideshow >> writingTests: aSlide [
	<gtSlide>
	^ aSlide lepiterPage
		setPriority;
		startPage: (self db pageNamed: 'Writing parser tests')
]

{ #category : #page }
SPLPetitParserSlideshow >> writingTestsPage [
	<gtExample>
	<noTest>
	^ (LePage named: 'Writing parser tests')
		addSnippet: (LeTextSnippet new
				string: 'We write tests to verify that code snippets are correctly parsed by certain production rules and not others. ';
				yourself);
		addSnippet: (LeExampleSnippet new
				exampleBehaviorName: #SPLGrammarExamples;
				exampleSelector: #whileProgram);
		addSnippet: (LeTextSnippet new
				string: 'We check that this sample code is parsed as a `program`, and not as a `statement` or a `declaration`.';
				yourself);
		addSnippet: (LeTextSnippet new
				string: 'After completing and testing all the parser rules, we end up with {{gtClass:name=SPLGrammar}} and {{gtClass:name=SPLGrammarExamples}}.';
				yourself);
		yourself
]
