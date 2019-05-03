print("data_valid <= '1';")
string1='''data_in <= "00000000";
wait for clk_period;'''

string2='''data_in <= "11111111";
wait for clk_period;'''

string3='''data_in <= "01010101";
wait for clk_period;'''

for i in range(2):
    print(string1)

print("--enter packet length here")
for i in range(2):
    print(string2)
print("--packet length done")

for i in range(20):
    print(string1)

print("--enter no. of advertisements here")

for i in range(3):
    print(string1)
print('''data_in <= "00000001";\nwait for clk_period;''')
print("--end no. of advertisements here")

for i in range(18):
    print(string1)

print("--enter LS packet length here")
print('''data_in <= "00000000";\nwait for clk_period;''')
print('''data_in <= "00100100";\nwait for clk_period;''')
print("--stop packet length here")

for i in range(16):
    print(string2)

print("data_valid <= '0';")








