/* jslint node: true */
'use strict';

var requireDir = require('require-dir');

requireDir('./gulp/tasks', { recurse: true });


// var config = {
//     sass: {
//         src: "app/assets/stylesheets/**/*.scss",
//         dest: "public/stylesheets",
//         options: {
//             includePaths: ["vendor/assets/bower_components"],
//             indentedSyntax: false
//         }
//     },
//     bs: {
//         watchFiles: ["public/stylesheets.**", "app/assets/stylesheets/**/*.scss"]
//     }
// };

// var gulp = require('gulp');
// var bs = require('browser-sync').create();
// var sass = require('gulp-sass');
// var maps = require('gulp-sourcemaps');

// gulp.task('browser-sync', ['sass'], function() {
//     bs.init({
//         proxy: 'localhost:3000',
//         port: 9000
//     });

//     gulp.watch(config.sass.src, ['sass']);
//     gulp.watch(config.bs.watchFiles).on('change', bs.reload);
// });

// gulp.task('sass', function() {
//     return gulp.src(config.sass.src)
//         .pipe(maps.init())
//         .pipe(sass(config.sass.options))
//         .pipe(maps.write())
//         .pipe(gulp.dest(config.sass.dest))
//         .pipe(bs.stream());
// });




// vim: set ts=8 sw=4 tw=78 ft=javascript et :
