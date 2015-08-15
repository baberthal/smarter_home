/* jslint node: true */
'use strict';

var gulp = require('gulp');
var bs = require('./browser_sync');
var sass = require('gulp-sass');
// var sourcemaps = require('gulp-sourcemaps');
var handleErrors = require('../util/handleErrors');
var config = require('../config').sass;
var autoprefixer = require('gulp-autoprefixer');

gulp.task('sass', function() {
    return gulp.src(config.src)
        // .pipe(sourcemaps.init())
        .pipe(sass(config.settings))
        .on('error', handleErrors)
        // .pipe(sourcemaps.write())
        .pipe(autoprefixer({ browsers: ['last 2 versions'] }))
        .pipe(gulp.dest(config.dest))
        .pipe(bs.stream());
});
