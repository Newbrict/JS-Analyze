module.exports = (grunt) ->
	gruntConfig =
		pkg:
			grunt.file.readJSON 'package.json'

		coffee:
			app:
				options:
					join: false
					sourceMap: true
				files: [
					'build/js/main.js': 'src/coffee/**/*.coffee',
					'build/test/test.js': [ 'src/test/*.coffee'
																, 'src/coffee/code_samples.coffee'
																, 'src/coffee/validator.coffee'
																, 'src/coffee/analyze.coffee'
																]
				]

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
		karma:
			unit:
				configFile: "karma.conf.js"
				singleRun: true

		watch:
			coffeelint:
				files: 'src/coffee/*.coffee'
				tasks: 'coffeelint'
			coffee:
				files: 'src/coffee/**/*.coffee'
				tasks: ['coffee', 'test']
			jade:
				files: 'src/templates/*.jade'
				tasks: 'jade'
			sass:
				files: 'src/sass/*.scss'
				tasks: 'sass'
			karma:
				files: 'src/test/*.coffee'
				tasks: ['coffee', 'test']

	# Default task
	grunt.registerTask 'default', ['coffeelint', 'coffee', 'jade', 'sass']
	grunt.registerTask 'test', 'karma'

	grunt.initConfig gruntConfig
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-jade'
	grunt.loadNpmTasks 'grunt-contrib-sass'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-coffeelint'
	grunt.loadNpmTasks 'grunt-karma'
