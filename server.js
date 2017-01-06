var str = 'Hello World!';
var http = require('http');
var resCount = 0;
var id = Math.random();
var handleRequest = function(request, response) {
  console.log('Received request for URL: ' + request.url);
  resCount++;
  var resStr = '';
  for (var i = 0; i < 1000; i++) {
    var tmp = Math.random();
    resStr += str + tmp + resCount;
  }

  response.writeHead(200);
  response.end(id +', Hello World! 7, ' + resStr.length);
};
var www = http.createServer(handleRequest);
www.listen(8080);
