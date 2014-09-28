JS-Analyze
=========

Javascript code analyzer project for Khan Academy

Install
--
```
npm install
bower install
grunt
```
after running those you can open up build/index.html and try it out. REFRESH the
page for different trials!!

Why Esprima?
---
So when I first read the problem I looked at both Acorn, and Esprima. I thought
Acorn was a much better choice: It's faster, and smaller. I did not like Acorn's
documentation however, and considering how short the parse strings will be the
performance increase will hardly make a difference. Esprima has a wider contributor
base than Acorn so I expect it to get faster over time anyway ( among more features
and less bugs ). Also Esprima has good browser support.

How it works
--
Create an analyzer object ( Coffee Script )
```coffeescript
analyzer = new Analyzer
```

Add whatever you would like to the whitelist or blacklist. Here are some examples:

```coffeescript
# Must have an if statement
analyzer.whitelist.add '{ "if":{} }'
```

```coffeescript
# Must have an if statement, and must NOT have a while loop
analyzer.whitelist.add '{ "if":{} }'
analyzer.blacklist.add '{ "while":{} }'
```

```coffeescript
# Must have triple nested if statements, and a while loop containing a for loop
# Also must NOT have any if statements containing while loops
analyzer.whitelist.add '{ "if":{"if":{"if":{}}} }'
analyzer.whitelist.add '{ "while":{"for":{}} }'
analyzer.blacklist.add '{ "if":{"while":{}} }'
```
Once you have your lists set up, check them against an esprima AST
```coffeescript
editor = ace.edit "editor"
ast = esprima.parse editor.getValue()
# Make sure the AST is valid...
analyzer.verify ast
```

Please see the unit tests for more examples.

Limitations
---
Currently you cannot look for statements like "two if statements one after another",
this is because I don't prune them from the AST leads


