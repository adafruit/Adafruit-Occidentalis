#!/usr/bin/env node

var gif = require('aio_gif'),
    dotenv = require('dotenv'),
    path = require('path')
    spawn = require('child_process').spawn;

var config = path.join(__dirname, '..', 'server.conf');

dotenv._getKeysAndValuesFromEnvFilePath(config);
dotenv._setEnvs();

var server = gif({
  key: process.env.AIO_KEY.trim(),
  feed: process.env.AIO_FEED.trim(),
  port: program.env.HTTP_PORT
});

console.log('Starting HTTP server on http://localhost:%d', process.env.HTTP_PORT);

server.on('error', console.error.bind(this, 'GIF Server Error'));

server.on('image', function() {
  spawn('/usr/bin/aio_gif_refresh');
});
