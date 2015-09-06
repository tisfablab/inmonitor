import RPi.GPIO as GPIO
import time

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

class GPIOout:

  def __init__(self, pin):
    self.PIN=pin
    GPIO.setup(pin, GPIO.OUT)
    self.off()

  def on(self):
    GPIO.output(self.PIN, GPIO.HIGH)

  def off(self):
    GPIO.output(self.PIN, GPIO.LOW)

class GPIOin:
  def __init__(self, pin):
    self.PIN=pin
    GPIO.setup(pin,GPIO.IN, pull_up_down=GPIO.PUD_UP)
  def isOn(self):
    return GPIO.input(self.PIN)

btn = GPIOin(21)

while True:
	if btn.isOn():
		print "ON"
	else:
		print "OFF"
	time.sleep(0.1)




