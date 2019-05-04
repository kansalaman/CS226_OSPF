def pad(s, length):
    ans = bin(s)[2:]
    return "0"*(length - len(ans)) + ans


def chunkstring(string, length):
    return (string[0+i:length+i] for i in range(0, len(string), length))