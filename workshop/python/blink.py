import RPi.GPIO as GPIO
import time

PIN=26

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)
GPIO.setup(PIN, GPIO.OUT)

while True:
	GPIO.output(PIN, GPIO.HIGH)
	time.sleep(0.5)
	GPIO.output(PIN, GPIO.LOW)
	time.sleep(1)



