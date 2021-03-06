// Generated by CoffeeScript 1.10.0
(function() {
  var coffee, coffeeFiles, gulp, gutil, handleError, jade, jadeFiles, parallelize, path, sh, sourcemaps, stylus, stylusFiles, tap, threads, touch, useSourceMaps;

  gulp = require('gulp');

  gutil = require('gulp-util');

  coffee = require('gulp-coffee');

  sourcemaps = require('gulp-sourcemaps');

  touch = require('touch');

  path = require('path');

  tap = require('gulp-tap');

  sh = require('shelljs');

  jade = require('gulp-jade');

  stylus = require('gulp-stylus');

  parallelize = require("concurrent-transform");

  threads = 100;

  useSourceMaps = true;

  coffeeFiles = ['**/*.coffee'];

  jadeFiles = ['./views/**/*.jade'];

  stylusFiles = ['./public/stylesheets/**/*.styl'];

  handleError = function(err) {
    console.log(err.toString());
    return this.emit('end');
  };

  gulp.task('touch', function() {
    return gulp.src(coffeeFiles).pipe(tap(function(file, t) {
      return touch(file.path);
    }));
  });

  gulp.task('coffeescripts', function() {
    return gulp.src(coffeeFiles).pipe(parallelize(coffee({
      bare: true
    }).on('error', gutil.log), threads)).pipe(parallelize((useSourceMaps ? sourcemaps.init() : gutil.noop()), threads));
  });

  gulp.task('jadescripts', function() {
    return gulp.src(jadeFiles).pipe(parallelize(jade().on('error', gutil.log), threads));
  });

  gulp.task('stylusscripts', function() {
    return gulp.src(stylusFiles).pipe(parallelize(stylus().on('error', gutil.log), threads));
  });

  gulp.task('one', function() {
    return gulp.src('./css/one.styl').pipe(stylus()).pipe(gulp.dest('./css/build'));
  });

  gulp.task('watch', function() {
    gulp.watch(coffeeFiles, ['coffeescripts']);
    gulp.watch(jadeFiles, ['jadescripts']);
    return gulp.watch(stylusFiles, ['stylusscripts']);
  });

  gulp.task('default', ['watch', 'coffeescripts']);

  gulp.task('done', (function() {}));

}).call(this);

//# sourceMappingURL=gulpfile.js.map
