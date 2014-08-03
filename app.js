var express =    require('express')
var bodyParser = require('body-parser')
var favicon =    require('serve-favicon')
var routeMirror = require('route-mirror')
require('newrelic')

var app = express()
app.set('view engine', 'jade')
app.set('views', __dirname + '/views')
app.use(express.static(__dirname + '/public'))
app.use(favicon(__dirname + '/public/favicon.ico'))
app.use(bodyParser.urlencoded({ extended: false }));

var mirror = routeMirror(app, function(url) {
	return url.replace(/-/g, '')
})

app.get('/', function(req, res) {
	res.render('index');
})

mirror.get('/what-went-well', function(req, res) {
	res.render('www/index');
})

var server = app.listen(process.env.PORT || 8419, function() {
	console.log('Express server listening on port ' + server.address().port);
})
