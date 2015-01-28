gulp   = require 'gulp'
shell  = require 'gulp-shell'
coffee = require 'gulp-coffee'
sass   = require 'gulp-sass'
sourcemaps = require 'gulp-sourcemaps'

gulp.task 'default', ['build']
gulp.task 'build', [
  'build:ts'
  'build:coffee'
  'build:jade'
  'build:css'
]

# TypeScript
tscBuildOptions = "-d -m commonjs -t es5 --sourceMap"
tscWatchOptions = "-w #{tscBuildOptions}"

gulp.task 'build:ts', shell.task [
  './node_modules/.bin/tsc -d -m commonjs -t es5 --sourceMap --outDir lib src/entry.ts'
]

gulp.task 'build:coffee', ->
  gulp.src('src/**/*.coffee')
    .pipe(coffee())
    .pipe(gulp.dest('lib'))

gulp.task 'build:jade', ->
  gulp.src('src/**/*.jade')
    .pipe(gulp.dest('lib'))

gulp.task 'watch', ['build'], ->
  gulp.watch 'src/**/*.coffee', ['build:coffee']
  gulp.watch 'src/**/*.ts', ['build:ts']
  gulp.watch 'src/**/*.jade', ['build:jade']
  gulp.watch 'src/styles/**/*.scss', ['build:css']

gulp.task 'build:css', ->
  gulp
    .src('src/styles/style.scss')
    .pipe(sass())
    .pipe(gulp.dest('public'))
