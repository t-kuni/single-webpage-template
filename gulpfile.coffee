gulp = require 'gulp'
gutil = require 'gulp-util'
jade = require 'gulp-jade'
sass = require 'gulp-sass'
coffee = require 'gulp-coffee'
mochaSelenium = require 'gulp-mocha'
require('coffee-script/register')
Server = require('karma').Server
webserver = require 'gulp-webserver'

gulp.task 'default', ['build', 'watch']

gulp.task 'build', ['jade', 'sass', 'coffee']

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
  gulp.src 'src/coffee/*.coffee'
    .pipe coffee({bare: true}).on 'error', gutil.log
    .pipe gulp.dest 'dist/js/'

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

gulp.task 'webserver', ->
  gulp.src 'dist'
    .pipe webserver
      livereload: true,
      directoryListing:
        path: 'dist'
      open: false

gulp.task 'watch', ['webserver'], ->
  gulp.watch 'src/jade/*.jade', ['jade', 'test']
  gulp.watch 'src/sass/*.sass', ['sass', 'test']
  gulp.watch 'src/coffee/*.coffee', ['coffee', 'test']
  gulp.watch 'test/*.coffee', ['test']
