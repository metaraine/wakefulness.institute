gulp =        require 'gulp'
stylus =      require 'gulp-stylus'
livereload =  require 'gulp-livereload'
nib = 			  require 'nib'
spritesmith = require 'gulp.spritesmith'

paths =
	views: 			'views/**'
	js: 				'public/**/.js'
	stylus: 		'public/styles/**/*.styl'
	css: 				'public/styles/**/*.css'
	cssMain: 		'public/styles/main.css'
	cssOutput:	'public/styles'
	images: 		'public/images'
	wwwImages:  'public/images/www'
	wwwSpriteUrl:  '/images/www/sprite.png'
	wwwSprites: 'public/images/www/sprites/*.png'

gulp.task 'sprites', ()->
	spriteData = gulp.src(paths.wwwSprites)
		.pipe spritesmith
			imgName: 'sprite.png'
			imgPath: paths.wwwSpriteUrl
			cssName: 'wwwSprite.css'
			cssOpts:
				cssClass: (item)->
					'.sprite-' + item.name

	spriteData.img.pipe gulp.dest paths.wwwImages
	spriteData.css.pipe gulp.dest paths.cssOutput

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
	gulp.watch(paths.wwwSprites, ['sprites'])

	# coffee
	# gulp.watch(path.js, ['coffee'])
	# 	.on('change', livereload.changed)
