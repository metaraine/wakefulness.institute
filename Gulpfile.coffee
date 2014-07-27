gulp =       require 'gulp'
livereload = require 'gulp-livereload'

gulp.task 'watch', ()->
	livereload.listen()
	gulp.watch(['public/**', 'views/**'])
		.on('change', livereload.changed)
