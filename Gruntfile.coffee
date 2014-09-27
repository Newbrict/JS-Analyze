module.exports = (grunt) ->
	gruntConfig =
		pkg:
			grunt.file.readJSON 'package.json'
		coffee:
			app:
				options:
					join: true
					sourceMap: true
				files:
					'build/js/app.js': 'src/coffee/*.coffee'
		jade:
			compile:
				options:
					data:
						debug: false
				files:
					'build/index.html': 'src/templates/index.jade'
		sass:
			dist:
				files:
					'build/css/main.css': 'src/sass/main.scss'

		coffeelint:
			app:
				src: "src/coffee/*.coffee"
			options:
				'no_tabs':
					'level': 'ignore'
				'indentation':
					'value': 1
					'level': 'warn'
				'no_plusplus':
					'value': 'warn'
				'max_line_length':
					'level': 'ignore'

		watch:
			coffeelint:
				files: 'src/coffee/*.coffee'
				tasks: 'coffeelint'
			coffee:
				files: 'src/coffee/*.coffee'
				tasks: 'coffee'
			jade:
				files: 'src/templates/*.jade'
				tasks: 'jade'
			sass:
				files: 'src/sass/*.scss'
				tasks: 'sass'

	# Default task
	grunt.registerTask 'default', ['coffeelint', 'coffee', 'jade', 'sass']

	grunt.initConfig gruntConfig
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-jade'
	grunt.loadNpmTasks 'grunt-contrib-sass'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-coffeelint'
