/* jslint node: true */
'use strict';

var gulp = require('gulp');
var iconfont = require('gulp-iconfont');
var config = require('../../config').iconFont;
var generateIconSass = require('./generate_icon_sass');

gulp.task('iconFont', function() {
    return gulp.src(config.src)
        .pipe(iconfont(config.options))
        .on('glyphs', generateIconSass)
        .pipe(gulp.dest(config.dest));
});
