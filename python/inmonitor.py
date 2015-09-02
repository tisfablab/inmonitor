#!/usr/bin/python
# -*- coding: latin-1 -*-

# include libraries -----------------------------------------------------------

import time, datetime # time functions
import requests # library for sending data over http
import socket # to find out our local ip
import thread # loop is slow, needed for fast led pulse

import bme280, tsl2591 # libraries for our sensors
import gpio # led output
import httpservice # for rt service

# constants -------------------------------------------------------------------

INTERVAL = 10 					# secs
SERVER = "inmonitor.tis.bz.it"	# cloud server ip/dns name
DEVICE_ID = "x"					# my cloud user name
PASSWORD = "x"					# my cloud password
HTTP_TIMEOUT = 1				# secs

# find out private ip address -------------------------------------------------

ip = [(s.connect(('8.8.8.8', 80)), s.getsockname()[0], s.close()) for s in [socket.socket(socket.AF_INET, socket.SOCK_DGRAM)]][0][1]
print datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), "My private IP is:", ip

# init  -----------------------------------------------------------------------

httpd = httpservice.Service(2222)
led = gpio.GPIOout(26)
refreshTime = time.time() + INTERVAL;

# loop ------------------------------------------------------------------------

while True: 
	# read temperature, pressure, humidity
	(degC, hPa, hRel) = bme280.readData() 
	# read brightness data	
	(visible, ir, lux) = tsl2591.readData() 
	# provide data to potential direct connection to port 2222
	if httpd.provideData({'temperature':degC,'humidity':hRel, 'pressure':hPa, 'illuminance':lux, 'timestamp':'ALMOST REAL TIME!'}):
		thread.start_new_thread(led.pulse, (0.1, ) )
		print datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), "direct request from", httpd.addr[0]
	# every 10 seconds, try to send data to servers
	if time.time() > refreshTime:
		now = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
		refreshTime = time.time() + INTERVAL;
		print now, "T: %.1f degC, P: %.1f hPa, phi: %.1f %%rH, E: %.0f lux" % (degC, hPa, hRel, lux)
		payload = { 'device': DEVICE_ID, 'password': PASSWORD, 'temperature': degC, 'pressure': hPa, 'humidity': hRel, 'illuminance': lux, 'localaddr': ip }
		# send data to cloud server
		if SERVER:
			try: r=requests.get( "http://"+SERVER+"/store.php", params=payload, timeout=HTTP_TIMEOUT)
			except: 
				print now, "connection to cloud server failed"
			else: 
				if r.text=="OK": 
					thread.start_new_thread(led.pulse, (1, ) )
					print now, "data saved on cloud server"
				else: print now, "data rejected by cloud server" 
		# store data locally
		try: r=requests.get( "http://localhost/store.php", params=payload)
		except: 
			print now, "connection to local server failed"
		else: 
			if r.text=="OK": 
				thread.start_new_thread(led.pulse, (1, ) )
				print now, "data saved in local database"
			else: print now, "data rejected by local server" 
	# sleep 100ms
	time.sleep(0.1)
