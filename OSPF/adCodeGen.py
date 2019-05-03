# Code to generate cases of sending link state advertisements
# for i in range(8):
#     print("signal g" + (str(i+1)) + ": std_logic := (act_on(" + str(i) + ") and not (served(" + str(i) + ")));")

# for i in range(7):
#     print("     elsif (g" + str(i+1) + " = '1') then")
#     print("         out1<=neigh" + str(i+1) + " (31 downto 24);")

for i in range(8):
    bit8lid1 = str(bin(1 + i*12))[2:]
    
    bit8type = str(bin(9 + i*12))[2:]
    bit8type = (8 - len(bit8type))*"0" + bit8type
    print ('                elsif(p_adstimer = "'+ bit8type + '") then')
    print ('                    out1<= type;')
    bit8tos = str(bin(10 + i*12))[2:]
    bit8tos = (8 - len(bit8tos))*"0" + bit8tos
    print ('                elsif(p_adstimer = "'+ bit8tos + '") then')
    print ('                    out1<= zero8;')
    bit8metric = str(bin(11 + i*12))[2:]
    bit8metric = (8 - len(bit8metric))*"0" + bit8metric
    print ('                elsif(p_adstimer = "'+ bit8metric + '") then')
    print ('                    out1<= metric(' + str(i+1) + ');')
    bit8