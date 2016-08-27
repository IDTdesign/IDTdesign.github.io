# Grunt Configuration
# http://gruntjs.com/getting-started#an-example-gruntfile

module.exports = (grunt) ->

	# Initiate the Grunt configuration.
	grunt.initConfig

		# Allow use of the package.json data.
		pkg: grunt.file.readJSON('package.json')

		# docpad variables
		docpad:
			files: [ './src/**/*.*' ]
			out: ['out']

		# compile less and generate map files
		less:
			docs:
				options:
					strictMath: false
					sourceMap: true
					outputSourceFiles: true
					sourceMapURL: 'docs.css.map'
					sourceMapFilename: 'out/styles/docs.css.map'
				files:
					'out/styles/docs.css': 'src/raw/styles/docs.less'

		# add vendor prefixes
		autoprefixer:
			options:
				browsers: [
					'Android 2.3',
					'Android >= 4',
					'Chrome >= 20',
					'Firefox >= 24',
					'Explorer >= 8',
					'iOS >= 6',
					'Opera >= 12',
					'Safari >= 6'
				]
			bosssrc:
				options:
					map: true
				src: 'src/raw/styles/*.less'
			bossout:
				options:
					map: true
				src: 'out/styles/docs.css'

		# optimize images if possible
		imagemin:
			out:
				options:
					optimizationLevel: 3,
				files: [
					expand: true,
					cwd: 'out/images/',
					src: ['**/*.{png,jpg,gif}'],
					dest: 'out/images/'
				]
			src:
				options:
					optimizationLevel: 3,
				files: [
					expand: true,
					cwd: 'src/raw/img/',
					src: ['**/*.{png,jpg,jpeg,gif}'],
					dest: 'src/raw/img/'
				]
			logo:
				options:
					optimizationLevel: 3,
				files: [
					expand: true,
					cwd: 'src/documents/docs/logo/',
					src: ['**/*.{svg,png,jpg,jpeg,gif}'],
					dest: 'src/documents/docs/logo/'
				]

		# track changes in src dir and regenerate docpad
		watch:
			src:
				files: ['<%= docpad.files %>']
				tasks: [
					'shell:docpad',
					'postprocess'
				]
			out:
				files: ['<%= docpad.out %>/**/*']
				options:
					livereload: true
			less:
				files: [
					'./src/raw/styles/**/*.*'
				]
				tasks: [
					'postprocess'
				]

		# start server
		connect:
			server:
				options:
					port: 7777
					hostname: '*'
					base: '<%= docpad.out %>'
					livereload: true
					# open: true

		# clean out dir
		clean:
			options:
				force: true
			out: ['<%= docpad.out %>']


		# generate development
		shell:
			docpad:
				options:
					stdout: true
					async: false
				command: 'docpad generate --env static'
			docpadrun:
				options:
					stdout: true
					async: true
				command: 'docpad run'
			deploy:
				options:
					stdout: true
					async: false
				command: 'docpad deploy-ghpages --env static'
			custom:
				options:
					stdout: true
					async: false
				command: 'docpad render ./uicomponents/bettertext/demo.html.md > ./out/uicomponents/bettertext/index.html'

	# measures the time each task takes
	require('time-grunt')(grunt);

	# Build the available Grunt tasks.
	grunt.loadNpmTasks 'grunt-shell-spawn'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-connect'
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-less'
	grunt.loadNpmTasks 'grunt-contrib-imagemin'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-autoprefixer'
	grunt.loadNpmTasks 'grunt-newer'
	grunt.loadNpmTasks 'grunt-text-replace'

	# Register our Grunt tasks.
	grunt.registerTask 'optimizeimg',   ['svg2png:src', 'newer:imagemin:src']
	grunt.registerTask 'preprocess',    ['makesprites', 'optimizeimg']
	grunt.registerTask 'postprocess',   ['less', 'autoprefixer:bossout']
	grunt.registerTask 'generate',      ['clean:out', 'shell:docpad', 'postprocess']
	grunt.registerTask 'server',        ['connect', 'watch:src', 'watch:out', 'watch:uicomponents']
	grunt.registerTask 'run2',          ['generate', 'server']
	grunt.registerTask 'run',           ['shell:docpadrun', 'postprocess', 'watch:less']
	grunt.registerTask 'development',   ['postprocess', 'watch:less']
	grunt.registerTask 'production',    ['postprocess']
	grunt.registerTask 'deploy',    	['clean:out', 'postprocess', 'shell:deploy']
	grunt.registerTask 'default',       ['run']
