
edges = input("Enter no of edges:- ")

edgeList = []
costList = []
for i in range(int(edges)):
    temp = input("Enter vertex no with cost: ")
    node, cost = temp.split()
    node = int(node)
    cost = int(cost)
    edgeList.append(node)
    costList.append(cost)

string = ""
for i in edgeList:
    binary = bin(i)[2:]
    binary = ("0"*(6-len(binary))) + binary
    string = binary + string
string = ("1"*(48 - len(string))) + string

for i in costList:
    binary = bin(i)[2:]
    binary = ("0" * (6 - len(binary))) + binary
    string = binary + string
string = ("1"*(96 - len(string))) + string

print(string)

# for i in range(59):
#     print("1"*96 + ",")

