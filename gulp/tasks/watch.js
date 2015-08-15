/* jslint node: true */
'use strict';

var gulp = require('gulp');
var config = require('../config');

gulp.task('watch', ['sass', 'browserSync'], function(cb) {
    gulp.watch(config.sass.src, function() { gulp.start('sass'); });
    gulp.watch(config.images.src, function() { gulp.start('images'); });
    gulp.watch(config.iconFont.src, function() { gulp.start('iconFont'); });
});
