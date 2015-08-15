/* jslint node: true */
'use strict';

var gulp = require('gulp');
var config = require('../../config').iconFont;
var template = require('gulp-swig');
var rename = require('gulp-rename');

module.exports = function(glyphs, options) {
    var iconSass = template({
        data: {
            icons: glyphs.map(function(glyph) {
                return {
                    name: glyph.name,
                    code: glyph.unicode[0].charCodeAt(0).toString(16).toUpperCase(),
                };
            }),
            fontName: config.options.fontName,
            fontPath: config.fontPath,
            className: config.sass.className,
            comment: 'DO NOT EDIT DIRECTLY!\n Generated from ' + config.template
        }
    });

    gulp.src(config.sass.template)
        .pipe(iconSass)
        .pipe(rename(config.sass.outputName))
        .pipe(gulp.dest(config.sass.dest));
};
