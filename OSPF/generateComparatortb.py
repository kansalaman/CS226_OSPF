y = ''
for i in range(64):
	x = bin(63-i)[2:]
	x = '0'*(6-len(x)) + x
	y = y  + x

print(y)
