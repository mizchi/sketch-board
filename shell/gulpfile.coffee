gulp = require('gulp')
gulpAtom = require 'gulp-atom'

gulp.task 'build', ->
  gulpAtom
    srcPath: './app'
    releasePath: './release'
    cachePath: './.cache'
    version: 'v0.20.7'
    rebuild: false
    platforms: ['win32-ia32', 'darwin-x64']

gulp.task 'dev', ->
  gulpAtom
    srcPath: './dummyapp'
    releasePath: './dev'
    cachePath: './.cache'
    version: 'v0.20.7'
    rebuild: false
    platforms: ['darwin-x64']

gulp.task 'default', ['build']
