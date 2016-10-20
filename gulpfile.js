var child_process = require('child_process');
var gulp = require('gulp');

var logger = require('./logger')('watcher');


var child = null;


function stopChild() {
  if (child) {
    logger.info(`stopping ${process.env.PROCESS}`);
    var result = new Promise((resolve, reject) => {
      child.on('close', resolve);
      child.on('error', reject);
    });
    child.kill();
    return result;
  } else {
    return Promise.resolve();
  }
}


function startChild(cmd, args, options) {
  logger.info(`starting ${process.env.PROCESS}`);
  child = child_process.spawn(cmd, args, Object.assign(options || {}, {stdio: 'inherit'}));
  child.on('close', (code) => {
    if (code) {
      logger.error('Server error');
    }
    child = null;
  });
  return child;
}


gulp.task('start', function(){
  return stopChild()
    .then(() => startChild(process.env.PROCESS, process.env.ARGUMENTS.split('|'), {
      cwd: '/workdir/src',
      env: process.env
    }));
});


gulp.task('watch', ['start'], () => {
  gulp.watch('/workdir/src/**/*', ['start']);
});
