JS-Analyze
=========

Javascript code analyzer project

Install
--
```
npm install
bower install
grunt
```
after running those you can open up build/index.html and try it out.

Why Esprima?
---
So when I first read the problem I looked at both Acorn, and Esprima. I thought
Acorn was a much better choice: It's faster, and smaller. I did not like Acorn's
documentation however, and considering how short the parse strings will be the
performance increase will hardly make a difference. Esprima has a wider contributor
base than Acorn so I expect it to get faster over time anyway ( among more features
and less bugs ).
