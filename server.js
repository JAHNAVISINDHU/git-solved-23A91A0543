// server.js - Simple placeholder to satisfy 'npm run dev'
const http = require('http');
const port = process.env.APP_PORT || 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('DevOps Simulator is running successfully after Git Merge!\n');
});

server.listen(port, () => {
  console.log(`Server running at http://localhost:${port}/`);
});