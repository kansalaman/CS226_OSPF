string_to_print='''in1 <= "00000000";
wait for clk_period;'''

string_to_print2='''in1 <= "11111111";
wait for clk_period;'''

string_to_print3='''in1 <= "00000001";
wait for clk_period;'''
print("--ip packet header starts here")


for i in range(20):
    print(string_to_print)

print("--ip packet header ends here")

print("--ospf header starts here")

print(string_to_print2)
print(string_to_print3)
print(string_to_print2)
print(string_to_print2)

print("--router id here")
for i in range(4):
    print(string_to_print)
print("--router id ends")

for i in range(36):
    print(string_to_print2)

print("--neighbour goes here")
for i in range(4):
    print(string_to_print)

