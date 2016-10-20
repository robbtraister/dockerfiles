var gulp = require('gulp');
var child_process = require('child_process');


var child = null;


function exitWithError() {
  console.log(arguments);
  process.exit(-1);
}


function stopChild() {
  if (child) {
    process.stdout.write(`stopping ${process.env.PROCESS}...`);
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
  process.stdout.write(`starting ${process.env.PROCESS}...`);
  options = options || {};
  options.stdio = 'inherit';
  child = child_process.spawn(cmd, args, options);
  child.on('error', exitWithError);
  child.on('close', () => {
    child = null;
  });
  process.stdout.write('done\n');
  return child;
}


gulp.task('start', function(){
  return stopChild()
    .then(() => startChild(process.env.PROCESS, process.env.ARGUMENTS.split('|'), {
      cwd: process.env.CWD,
      env: process.env
    }));
});


gulp.task('watch', ['start'], function(){
  gulp.watch('/workdir/src/**/*', ['start']);
});
