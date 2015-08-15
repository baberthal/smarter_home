/* jslint node: true */
'use strict';

var browserSync = require('browser-sync').create();
var gulp = require('gulp');
var config = require('../config').browserSync;

gulp.task('browserSync', function() {
    browserSync.init(config);
});
