import time
x = "Hello World!"
y = "Huhuuuu"
i = 10
# this is a comment
while i>0: # (this is another comment)
  if i%2==0:
    print x
    time.sleep(1)
  elif i%3==0:
    pass
  else: print y
  i=i-1
  time.sleep(0.1)
print "end"


