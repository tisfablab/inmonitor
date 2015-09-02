#!/usr/bin/python

import socket 	# Networking support
import json		# data formatting

DEBUG=1

HTTP_REPLY = """HTTP/1.0 200 OK
Server: INMONITOR HTTP Service
Connection: close
Access-Control-Allow-Origin: *
Content-Type: application/json; charset=UTF-8

%s
"""

class Service:

  def __init__(self, port = 80):
	self.host = ''   # <-- works on all avaivable network interfaces
	self.port = port
	self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	self.socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
	self.socket.bind((self.host, self.port))
	self.socket.setblocking(0);
	self.socket.settimeout(0.2);

  def provideData(self, data):
	self.socket.listen(1);
	try:
		conn, self.addr = self.socket.accept()
	except:
		return False
	else:
		req = conn.recv(1024) # get the request, 1kB max
		data = HTTP_REPLY % json.dumps(data)
		conn.send(data)
		conn.close()	
		return True
