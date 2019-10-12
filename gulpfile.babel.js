import fs from 'fs';
import path from 'path';

import gulp from 'gulp';

// Load all gulp plugins automatically
// and attach them to the `plugins` object
import plugins from 'gulp-load-plugins';

import archiver from 'archiver';
import glob from 'glob';
import del from 'del';

import pkg from './package.json';

const dirs = pkg['orchestrator-configs'].directories;

// ---------------------------------------------------------------------
// | Helper tasks                                                      |
// ---------------------------------------------------------------------

gulp.task('archive:create_archive_dir', (done) => {
  fs.mkdirSync(path.resolve(dirs.archive), '0755');
  done();
});

gulp.task('archive:zip', (done) => {
  const archiveName = path.resolve(dirs.archive, `${pkg.name}_v${pkg.version}.zip`);
  const zip = archiver('zip');
  const files = glob.sync('**/*.*', {
    'cwd': dirs.dist,
    'dot': true // include hidden files
  });
  const output = fs.createWriteStream(archiveName);

  zip.on('error', (error) => {
    done();
    throw error;
  });

  output.on('close', done);

  files.forEach((file) => {
    const filePath = path.resolve(dirs.dist, file);

    // `zip.bulk` does not maintain the file
    // permissions, so we need to add files individually
    zip.append(fs.createReadStream(filePath), {
      'name': file,
      'mode': fs.statSync(filePath).mode
    });
  });

  zip.pipe(output);
  zip.finalize();
  done();
});

gulp.task('clean', (done) => {
  del([
    dirs.archive,
    dirs.dist
  ]).then(() => {
    done();
  });
});

gulp.task('copy:.htaccess', () =>
  gulp.src('node_modules/apache-server-configs/dist/.htaccess')
    .pipe(plugins().replace(/# ErrorDocument/g, 'ErrorDocument'))
    .pipe(gulp.dest(dirs.dist))
);

gulp.task('copy:license', () =>
  gulp.src('LICENSE')
    .pipe(gulp.dest(dirs.dist))
);

gulp.task('copy:misc', () =>
  gulp.src([
    // Copy all files
    `${dirs.src}/**/*`,

    // Exclude the following files
    // (other tasks will handle the copying of these files)
    `!${dirs.src}/css/main.css`,
    `!${dirs.src}/index.html`
  ], {
    // Include hidden files by default
    dot: true
  }).pipe(gulp.dest(dirs.dist))
);

// ---------------------------------------------------------------------
// | Main tasks                                                        |
// ---------------------------------------------------------------------
gulp.task(
  'copy',
  gulp.series(
    'copy:.htaccess',
    'copy:index.html',
    'copy:license',
    'copy:misc',
  )
);

gulp.task(
  'build',
  gulp.series(
    gulp.parallel('clean', 'lint:js'),
    'copy',
    'modernizr'
  )
);

gulp.task(
  'archive',
  gulp.series(
    'build',
    'archive:create_archive_dir',
    'archive:zip'
  )
);

gulp.task('default', gulp.series('build'));
