'use strict'

# Initialize the Ace editor
initEditor = (someCode) ->
	editor = ace.edit "editor"
	editor.setTheme "ace/theme/solarized_dark"
	editor.getSession().setMode "ace/mode/javascript"

	# Put in a random code sample for now
	editor.setValue someCode, 1

	# Return the editor
	editor

alertStateModifier = (e) ->
	$('#codeInfo').removeClass('alert-info')
	$('#codeInfo').removeClass('alert-danger')
	$('#codeInfo').removeClass('alert-warning')
	$('#codeInfo').removeClass('alert-success')
	switch e
		when "ERROR"
			$('#codeInfo').addClass('alert-danger')
			$('#codeInfo').html("Your code is erroneous")
		when "SUCCESS"
			$('#codeInfo').addClass('alert-success')
			$('#codeInfo').html("Good job!")
		when "FAIL"
			$('#codeInfo').addClass('alert-warning')
			$('#codeInfo').html("Not all rules are met")

# DOM ready
$( document ).ready ->

	trial = userTrial[Math.floor(Math.random() * userTrial.length)]
	editor = initEditor(trial.code)
	analyzer = new Analyzer
	analyzer.whitelist.add trial.whitelist
	analyzer.blacklist.add trial.blacklist

	# Watches the text editor, <threshold>ms after you stop typing we will
	# reanalyze the AST
	(watchAST = ->
		# 1 second threshold
		threshold = 1000
		reAnalyze = null

		# Called everytime the user changes the editor text state
		editor.on "change", (e) ->
			clearTimeout( reAnalyze )
			reAnalyze = setTimeout (->
				# Reanalyze the AST, if it's valid
				syntax = null

				# Make sure we have a valid AST
				try
					syntax = esprima.parse editor.getValue()
				catch error
					alertStateModifier("ERROR")
					return

				# Since we have a valid AST, let's analyze it
				if analyzer.verify syntax
					alertStateModifier("SUCCESS")
				else
					alertStateModifier("FAIL")

			), threshold
	)(@)

	return null

