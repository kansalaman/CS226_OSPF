from testBench.padder import  pad, chunkstring
from ipaddress import IPv4Address
import random

def makeHeader(type, rid, plen):
    '''
      Type   Description
      ________________________________
      1      Hello
      2      Database Description
      3      Link State Request
      4      Link State Update
      5      Link State Acknowledgment
    '''
    version = pad(2, 8)
    typeP = pad(int(type), 8)
    packetlen = pad(plen + 24, 16)
    rid = pad(int(IPv4Address(rid)), 32)
    aid = pad(0, 32)
    checksum = pad(0, 16)
    autype = pad(0, 16)
    auth1 = pad(0, 32)
    auth2 = pad(0, 32)
    return version + typeP + packetlen + rid + aid + checksum + autype + auth1 + auth2


def HelloPacket(rid, netmask, neighL):
    nmask = pad(int(IPv4Address(netmask)), 32)
    hinterval = pad(1000, 16)
    options = pad(0, 8)
    rtrpri = pad(0, 8)
    routerdead = pad(2000, 32)
    dr = pad(0, 32)
    bdr = pad(0, 32)
    neighpadded = []
    for i in neighL:
        neighpadded.append(pad(int(IPv4Address(i)), 32))

    packet = nmask + hinterval + options + rtrpri + routerdead + dr + bdr + "".join(neighpadded)
    plen = len(packet)//8
    # print(plen)
    header = makeHeader(1, rid, plen)
    return header + packet


def DD(rid, LSAs, seqno):
    plen = len(LSAs)//8 + 8
    header = makeHeader(2, rid, plen)
    mtu = pad(1500, 16)
    options = pad(0, 16)
    seqno = pad(seqno, 32)
    return header + mtu + options + seqno + LSAs


def LSR(rid, LSAHeaderl):
    plen = len(LSAHeaderl)*12
    header = makeHeader(3, rid, plen)
    li = ""
    for i in LSAHeaderl:
        li = li + pad(1, 32) + i[32:96]
    return header + li


def LSA(lsid, seqno, linkarray):
    LSAge = pad(random.randint(0, 65535), 16)
    Options = pad(0, 8)
    LSType = pad(1, 8)
    LSID = pad(int(IPv4Address(lsid)), 32)
    Ad = LSID
    LSSeqNo = pad(seqno, 32)
    Checksum = pad(0, 16)
    VEB = pad(0, 16)
    li = ""
    for i in linkarray:
        lid = pad(int(IPv4Address(i[0])), 32)
        ld = i[1]
        if not ld:
            ld = pad(0, 32)
        else:
            ld = pad(int(IPv4Address(ld)), 32)
        ltype = pad(i[2], 8)
        TOSm = pad(0, 8) + pad(i[3], 16)
        li = li + lid + ld + ltype + TOSm

    links = pad(len(linkarray), 16)
    length = pad(len(LSAge + Options + LSType + LSID + Ad + LSSeqNo + Checksum + VEB + links + li) // 8 + 2, 16)
    packet = LSAge + Options + LSType + LSID + Ad + LSSeqNo + Checksum + length + VEB + links + li
    return packet


def LSU(rid, LSAList):
    LSAComb = "".join(LSAList)
    header = makeHeader(4, rid, len(LSAComb)//8)
    return header + LSAComb


# Router A
LSA_A = LSA("1.1.1.1", 1, [])

# Router B
linkB1 = ("1.1.1.1", "0.0.0.0", 1, 1)
linkB2 = ("20.20.20.20", "255.255.255.0", 3, 7)
linkB3 = ("5.5.5.5", "0.0.0.0", 1, 4)
linkB4 = ("4.4.4.4", "0.0.0.0", 1, 2)
links_B = [linkB1, linkB2, linkB3, linkB4]
LSA_B = LSA("2.2.2.2", 2, links_B)

# Router C
linkC1 = ("1.1.1.1", "0.0.0.0", 1, 5)
linkC2 = ("4.4.4.4", "0.0.0.0", 1, 2)
linkC3 = ("5.5.5.5", "0.0.0.0", 1, 3)
linkC4 = ("30.30.30.30", "255.255.255.0", 3, 8)
links_C = [linkC1, linkC2, linkC3, linkC4]
LSA_C = LSA("3.3.3.3", 2, links_C)

# Router D
linkD1 = ("2.2.2.2", "0.0.0.0", 1, 2)
linkD2 = ("5.5.5.5", "0.0.0.0", 1, 1)
linkD3 = ("3.3.3.3", "0.0.0.0", 1, 2)
links_D = [linkD1, linkD2, linkD3]
LSA_D = LSA("4.4.4.4", 2, links_D)

# Router E
linkE1 = ("4.4.4.4", "0.0.0.0", 1, 1)
linkE2 = ("2.2.2.2", "0.0.0.0", 1, 4)
linkE3 = ("50.50.50.50", "255.255.255.0", 3, 9)
linkE4 = ("3.3.3.3", "0.0.0.0", 1, 3)
links_E = [linkE1, linkE2, linkE3, linkE4]
LSA_E = LSA("5.5.5.5", 2, links_E)

# print(len(LSA_A)//8, len(LSA_B)//8, len(LSA_C)//8, len(LSA_D)//8)
HelloB = "0"*20*8 + HelloPacket("2.2.2.2", "0.0.0.0", ["1.1.1.1", "5.5.5.5", "4.4.4.4"])
HelloC = "0"*20*8 + HelloPacket("3.3.3.3", "0.0.0.0", ["1.1.1.1", "4.4.4.4", "5.5.5.5"])

EmptyDDB = DD("2.2.2.2", "", 5)
EmptyDDC = DD("3.3.3.3", "", 10)

DDB = DD("2.2.2.2", LSA_B[:160] + LSA_D[:160] + LSA_E[:160], 6)
DDC = DD("3.3.3.3", LSA_C[:160] + LSA_D[:160] + LSA_E[:160], 11)

ReqB = LSR("2.2.2.2", [LSA_A])
ReqC = LSR("3.3.3.3", [LSA_A])

LSU_B = LSU("2.2.2.2", [LSA_B, LSA_D, LSA_E])
LSU_C = LSU("3.3.3.3", [LSA_C, LSA_D, LSA_E])
