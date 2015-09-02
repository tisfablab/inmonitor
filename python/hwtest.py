#!/usr/bin/python
# -*- coding: latin-1 -*-

import time
import gpio
import bme280
import tsl2591 

led = gpio.GPIOout(26)

while True:
	print "Testing LED..."
	led.pulse(0.5)
	time.sleep(1)
	print "Reading Temperature/Pressure/Humidity...", 
	(degC, hPa, hRel) = bme280.readData() # read temperature, pressure, humidity
	print degC, hPa, hRel
	if (hPa!=0): led.pulse(0.5)
	time.sleep(1)
	print "Reading visible/IR light...", 
	(visible, ir, lux) = tsl2591.readData() # read brightness data	
	print visible, ir
	if (lux!=0): led.pulse(0.5)
	time.sleep(5)
