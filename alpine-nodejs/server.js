require('newrelic');

var http = require('http');

var server = http.createServer(function(req, res) {
  res.end('Yep. It\'s working.\n');
})

var port = process.env.PORT || 3000;

server.listen(port, "0.0.0.0", function() {
  console.log('Example NodeJS web server running on %s', port);
});
