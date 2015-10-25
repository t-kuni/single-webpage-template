gulp          = require 'gulp'
gutil         = require 'gulp-util'
jade          = require 'gulp-jade'
sass          = require 'gulp-sass'
coffee        = require 'gulp-coffee'
mochaSelenium = require 'gulp-mocha'
webserver     = require 'gulp-webserver'
bower         = require 'main-bower-files'
browserify    = require 'gulp-browserify'
rename        = require 'gulp-rename'
Server        = require('karma').Server
require('coffee-script/register')

gulp.task 'default', ['build', 'watch']

gulp.task 'build', ['img', 'jade', 'sass', 'coffee', 'bower']

gulp.task 'img', ->
  gulp.src 'img/**/*'
    .pipe gulp.dest 'dist/img'

gulp.task 'jade', ->
  gulp.src 'src/jade/*.jade'
    .pipe jade
      locals: {}
    .pipe gulp.dest 'dist/'

gulp.task 'sass', ->
  gulp.src 'src/sass/*.sass'
    .pipe sass.sync().on 'error', sass.logError
    .pipe gulp.dest 'dist/css/'

gulp.task 'coffee', ->
  gulp.src 'src/coffee/*.coffee', {read: false}
    .pipe browserify
      transform: ['coffeeify', 'jadeify'],
      extensions: ['.coffee']
    .pipe rename
      extname: '.js'
    .pipe gulp.dest 'dist/js'

gulp.task 'karma', (done) ->
  new Server
    configFile: __dirname + '/karma.conf.js'
    singleRun: false,
    ->
      done() #issue: http://stackoverflow.com/questions/26614738/issue-running-karma-task-from-gulp
  .start()

gulp.task 'test', ->
  gulp.src 'test/test.coffee',
    read:false
  .pipe mochaSelenium
    # reporter: 'nyan'
    useSystemPhantom: true
    timeout: '30000'

gulp.task 'bower', ->
  gulp.src bower()
    .pipe gulp.dest 'dist/lib'

gulp.task 'webserver', ->
  gulp.src 'dist'
    .pipe webserver
      host: '0.0.0.0'
      livereload: true,
      directoryListing:
        path: 'dist'
      open: false

gulp.task 'watch', ['webserver'], ->
  gulp.watch 'img/*', ['img']
  gulp.watch 'src/jade/*.jade', ['jade', 'test']
  gulp.watch 'src/sass/*.sass', ['sass', 'test']
  gulp.watch ['src/coffee/*.coffee', 'src/jade/template/*.jade'], ['coffee', 'test']
  gulp.watch 'test/*.coffee', ['test']
