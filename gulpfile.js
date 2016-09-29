var gulp = require('gulp');
var child_process = require('child_process');


var child = null;


function exitWithError() {
  console.log(arguments);
  process.exit(-1);
}


function stopChild() {
  if (child) {
    process.stdout.write(`stopping ${process.env.CMD}...`);
    var result = new Promise(function(resolve, reject){
      child.on('close', () => {
        process.stdout.write('done\n');
        resolve()
      });
      child.on('error', reject);
    });
    child.kill();
    return result;
  } else {
    return Promise.resolve();
  }
}


function startChild(cmd, args, options) {
  process.stdout.write(`starting ${process.env.CMD}...`);
  child = child_process.spawn(cmd, args, options);
  if (/^debug$/i.test(process.env.LOG_LEVEL)) {
    child.stdout.on('data', (data) => {
      process.stdout.write(data.toString());
    });
    child.stderr.on('data', (data) => {
      process.stderr.write(data.toString());
    });
  }
  child.on('error', exitWithError);
  process.stdout.write('done\n');
  return child;
}


gulp.task('start', function(){
  return stopChild()
    .then(() => {
      return startChild(process.env.CMD, (process.env.ARGS || '').split('|'), {
          cwd: '/workdir',
          env: process.env
        });
    });
});


gulp.task('watch', ['start'], function(){
  gulp.watch('/workdir/src/**/*', ['start']);
});
