'use strict'

# Need to add all tokens here....
slangToEsprima = (slang) ->
	switch slang
		when "if" then "IfStatement"
		when "while" then "WhileStatement"
		when "for" then "ForStatement"
		else "UNKNOWN"

class @ParseArray
	constructor: ->
		@parseElements = []

	# Add a member to the parse object
	add: (json) ->
		if json == ''
			return
		@parseElements.push JSON.parse json

	# To view the current parse object, just for debugging, really.
	get: ->
		JSON.stringify(@parseElements)

	getJsonList: ->
		@parseElements.slice()

class @Analyzer

	constructor: ->
		@whitelist = new ParseArray
		@blacklist = new ParseArray

	# Returns all the children of input root
	getSubObjects: (root) ->
		ret = []
		# Iterate over each key
		for key in Object.keys(root)
			if root.hasOwnProperty key
				child = root[key]
				# Make sure we have a valid child root
				if typeof child == 'object' and child != null
					ret.push child

		# return our children!!!
		ret

	# Recursively step through the AST and run our callback function on each root
	traverse: ( root, callback ) ->
		# Run our callback on the current root
		callback root

		# Iterate over each key
		for key in Object.keys(root)
			if root.hasOwnProperty key
				child = root[key]
				# Make sure we have a valid child root
				if typeof child == 'object' and child != null
					# Iterate over child root array if it exists
					if Array.isArray child
						child.forEach (root) =>
							# Recurse
							@traverse(root, callback)
					else
						# Recurse
						@traverse(child, callback)

	# Checks to see if a single item exists in the syntaxlist ,
	# returns a list of objects which matched
	# item: should me a variable within either whitelist or blacklist
	# syntax: should be a list of objects
	# Should not be called explicitly
	find: ( item, syntax ) ->
		ret = []

		cb = (root) =>
			if 'type' in Object.keys(root) and root['type'] == item
				for child in @getSubObjects root
					ret.push child
				
		@traverse syntax, cb
		return ret

	# Checks to see if the pseudo AST is contained within the actual AST
	# pseudo: The pseudo ast you want to verify exists in syntax
	# leads: list of the full or sub AST(s) from Esprima
	contains: (pseudo, leads) ->
		root = pseudo

		# If no new leads have arisen, that means we did not find our slang in
		# any of the previous leads, I.E, this is a failed verification
		# TINY HACK to see if the array has anything at any depth
		if leads.join().replace(/,/g,'').length == 0
			return false

		# We successfully found this pseudo ast
		if $.isEmptyObject(root)
			return true

		# Iterate over all our keys in the current root
		# This might be 'if' or 'while', etc
		for curKey in Object.keys(root)
			# Convert this to the Esprima token identifier
			slang = slangToEsprima(curKey)

			# Iterate over all of our "leads" ( AST sub roots ) and check if our
			# slang is contained
			allLeads = []
			for curLead in leads
				allLeads.push @find slang, curLead
				
			# Recurse further into the object
			return @contains( root[curKey], allLeads  )

	# Verify the Whitelist and Blacklist on some AST
	# This should be called explicitly
	verify: (syntax) ->
		# Check the Whitelist
		for obj in @whitelist.getJsonList()
			# We set our root to the top of the current object
			root = obj
			leads = [syntax]
			if not (@contains root, leads)
				return false

		# Check the blacklist
		for obj in @blacklist.getJsonList()
			# We set our root to the top of the current object
			root = obj
			leads = [syntax]
			if (@contains root, leads)
				return false

		# Nothing returned false, therefore we must return true!
		return true
