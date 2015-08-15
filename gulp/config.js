/* jslint node: true */
'use strict';

var sources = './gulp/assets',
    pubDest = './public/assets',
    bowerFiles = './vendor/assets/bower_components';

module.exports = {
    dest: pubDest,
    bowerFiles: bowerFiles,
    src: sources,
    browserSync: {
        proxy: 'localhost:3000',
        files: ['./app/views/**']
    },
    sass: {
        src: sources + '/stylesheets/**/*.scss',
        dest: pubDest + '/stylesheets',
        settings: {
            indentedSyntax: false,
            imagePath: '/assets/images',
            includePaths: [bowerFiles]
        }
    },
    images: {
        src: sources + "/images/**",
        dest: pubDest + "/images"
    },
    iconFont: {
        name: 'Smart Home Icons',
        src: sources + '/icons/*.svg',
        dest: pubDest + '/fonts',
        fontPath: '/assets/fonts',
        sass: {
            dest: sources + '/stylesheets/base',
            template: './gulp/tasks/iconFont/template.sass',
            outputName: '_iconFont.sass',
            className: 'icon'
        },
        options: {
            fontName: 'my-icon-font',
            appendCodepoints: true,
            normalize: false
        }
    }
};
