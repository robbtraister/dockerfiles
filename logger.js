var winston = require('winston');
var dateformat = require('dateformat');

module.exports = function(source) {
  return new winston.Logger({
    transports: [
      new winston.transports.Console({
        level: 'info',
        json: false,
        colorize: true,
        timestamp: () => dateformat(new Date(), 'yyyy-mm-dd HH:MM:ss'),
        formatter: (options) => {
          var LEVEL = options.level.toUpperCase();
          var prefix = `[${ options.timestamp() }] ${ ' '.repeat(Math.max(7 - LEVEL.length, 0)) }${ LEVEL }:${ source }${ ' '.repeat(Math.max(15 - source.length, 0)) }`
          prefix = winston.config.colorize(options.level, prefix);
          return `${ prefix } ${ options.message }`;
        }
      })
    ]
  });
}
