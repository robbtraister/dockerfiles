var child_process = require('child_process');
var gulp = require('gulp');

var logger = require('./logger')('watcher');


var child = null;


function stopChild() {
  if (child) {
    logger.info(`Stopping ${process.env.PROCESS}`);
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


function initChild(cmd, args, options) {
  if (cmd) {
    logger.info(`Initializing ${process.env.PROCESS}`);
    return new Promise((resolve, reject) => {
      var cp = child_process.spawn(cmd, args, Object.assign(options || {}, {stdio: 'inherit'}));
      cp.on('close', (code) => {
        if (code) {
          return reject(code);
        }
        resolve();
      });
    });
  }
}


function startChild(cmd, args, options) {
  logger.info(`Starting ${process.env.PROCESS}`);
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
    .then(() => initChild(process.env.INIT_PROCESS, (process.env.INIT_ARGUMENTS || '').split('|'), {
      cwd: '/workdir/src',
      env: process.env
    }))
    .then(() => startChild(process.env.PROCESS, (process.env.ARGUMENTS || '').split('|'), {
      cwd: '/workdir/src',
      env: process.env
    }));
});


gulp.task('watch', ['start'], () => {
  gulp.watch('/workdir/src/**/*', ['start']);
});
