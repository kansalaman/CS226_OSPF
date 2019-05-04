import random
import ipaddress

def pad(s, length):
    ans = bin(s)[2:]
    return "0"*(length - len(ans)) + ans


LSAge = pad(random.randint(0, 65535), 16)
Options = pad(0, 8)
LSType = pad(1, 8)
LSID = pad(int(ipaddress.IPv4Address(input("Enter Router ID: "))), 32)
Ad = LSID
LSSeqNo = pad(int(input("Enter Seq No.: ")), 32)
Checksum = pad(0, 16)
VEB = pad(0, 16)
links = int(input("Enter No. of Links: ",))

li = ""
for i in range(links):
    lid = pad(int(ipaddress.IPv4Address(input("Enter Link ID" + str(i) + " : "))), 32)
    ld = input("Enter Link Data " + str(i) + " : ")
    if not ld:
        ld = pad(0, 32)
    else:
        ld = pad(int(ipaddress.IPv4Address(ld)), 32)
    ltype = pad(int(input("Enter Link Type " + str(i) + " : ")), 8)
    TOSm = pad(0, 24)
    li = li + lid + ld + ltype + TOSm

links = pad(links, 16)
length = pad(len(LSAge + Options + LSType + LSID + Ad + LSSeqNo + Checksum + VEB + links + li)//8 + 2, 16)
print(length)

def chunkstring(string, length):
    return (string[0+i:length+i] for i in range(0, len(string), length))


packet = list(chunkstring(LSAge + Options + LSType + LSID + Ad + LSSeqNo + Checksum + length + VEB + links + li, 8))
print(len(packet))
for i in packet:
    print("wr_en <= '1';", "\ndin <= \"" + i + "\";")
    print("wait for clk_period;")
