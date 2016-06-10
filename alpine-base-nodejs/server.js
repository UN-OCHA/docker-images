var http = require('http');

var server = http.createServer(function(req, res) {
  res.end('Yep. It\'s working.\n');
  // console.log('Test successful!');
})

server.listen(3000, '0.0.0.0');
console.log("NodeJS web server running on 0.0.0.0:3000");
