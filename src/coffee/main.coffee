'use strict'

# Initialize the Ace editor
initEditor = (someCode) ->
	editor = ace.edit "editor"
	editor.setTheme "ace/theme/solarized_dark"
	editor.getSession().setMode "ace/mode/javascript"

	# Put in a random code sample for now
	editor.setValue codeSample[someCode], 1

	# Return the editor
	editor

# DOM ready
$( document ).ready ->

	editor = initEditor("fizzbuzz")
	syntax = esprima.parse editor.getValue()
