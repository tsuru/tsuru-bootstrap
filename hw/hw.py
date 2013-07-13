#!/usr/bin/python
import os
from BaseHTTPServer import BaseHTTPRequestHandler,HTTPServer

PORT = int(8888)

class Handler(BaseHTTPRequestHandler):
        def do_GET(self):
                self.protocol_version = 'HTTP/1.1'
                body = "hello, world\n"
                self.send_response(200)
                self.send_header('Content-type','text/html')
                self.send_header('Content-length', str(len(body)))
                self.end_headers()
                self.wfile.write(body)
                return

server = HTTPServer(('', PORT), Handler)
print 'Started httpserver on port ' , PORT
server.serve_forever()
