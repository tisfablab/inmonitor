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

led = GPIOout(26)

while True:
	led.on()
	time.sleep(0.5)
	led.off()
	time.sleep(1)



