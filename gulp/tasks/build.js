/* jslint node: true */
'use strict';

var gulp = require('gulp');
var gulpSequence = require('gulp-sequence');

gulp.task('build', function(cb) {
    var tasks = ['clean', ['iconFont', 'images'], ['sass']];
    if (process.env.RAILS_ENV === 'production') tasks.push('rev');
    tasks.push(cb);
    gulpSequence.apply(this, tasks);
});
