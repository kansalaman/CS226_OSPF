for i in range(256):
    x = bin(i)
    stdx = (8 - (len(str(x)) - 2)) * "0" + x[2:]
    temp = str(bin(stdx.count('1')))[2:]
    res = (4 - len(temp))*"0" + temp
    print('when ' + '"'+ stdx + '"' + " =>")
    print('out1 <= "' + res + '";')



    