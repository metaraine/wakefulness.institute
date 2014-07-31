gulp =       require 'gulp'
stylus =     require 'gulp-stylus'
livereload = require 'gulp-livereload'
nib = 			 require 'nib'

paths =
	views: 			'views/**'
	js: 				'publi/**/.js'
	stylus: 		'public/styles/**/*.styl'
	css: 				'public/styles/**/*.css'
	cssOutput:	'public/styles'
	images: 		'public/images'


gulp.task 'styles', ()->
	gulp.src(paths.stylus)
		.pipe(stylus({use: [nib()]}))
		.pipe(gulp.dest(paths.cssOutput))
		.pipe(livereload())

# gulp.task 'scripts', ()->
# 	gulp.src(config.src_coffee)
# 		.pipe(coffee().on('error', gutil.log))
# 		.pipe(gulp.dest(config.dest_app))
# 		.pipe livereload()

gulp.task 'watch', ()->

	livereload.listen()

	# static files and views
	gulp.watch([
		paths.images
		paths.views
		paths.css
	]).on('change', livereload.changed)

	# styles
	gulp.watch(paths.stylus, ['styles'])

	# coffee
	# gulp.watch(path.js, ['coffee'])
	# 	.on('change', livereload.changed)
