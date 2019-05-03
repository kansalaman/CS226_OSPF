# Code to generate cases of sending link state advertisements
# for i in range(8):
#     print("signal g" + (str(i+1)) + ": std_logic := (act_on(" + str(i) + ") and not (served(" + str(i) + ")));")

# for i in range(7):
#     print("     elsif (g" + str(i+1) + " = '1') then")
#     print("         out1<=neigh" + str(i+1) + " (31 downto 24);")

# for i in range(8):
#     bit8lid1 = str(bin(1 + i*12))[2:]
#     bit8lid1 = (8 - len(bit8lid1))*"0" + bit8lid1
#     if i==0:
#         print('     if (p_adstimer = "' + bit8lid1 + '") then')
#     else: 
#         print('     elsif (p_adstimer = "' + bit8lid1 + '") then')    
#     for j in range(8):
#         if j==0:
#             print("                    if (g"+ str(j+1)+ " =" + "'1') " + "then")
#             print ('                     out1<= neigh' + str(j+1) + '(31 downto 24);')
#             # print('                      served(' + str(j+1) + ") <='1';")
#         elif j==7:
#             print("                    else")
#             print ('                     out1<= neigh' + str(j+1) + '(31 downto 24);')
#             # print('                      served(' + str(j+1) + ") <='1';")
#         else:
#             print("                    elsif (g"+ str(j+1)+ " =" + "'1') " + "then")
#             print ('                     out1<= neigh' + str(j+1) + '(31 downto 24);')
#             # print('                      served(' + str(j+1) + ") <='1';")
#     print("                      end if;")

# for i in range(8):
#     bit8lid2 = str(bin(2 + i*12))[2:]
#     bit8lid2 = (8 - len(bit8lid2))*"0" + bit8lid2
#     print('     elsif (p_adstimer = "' + bit8lid2 + '") then')    
#     for j in range(8):
#         if j==0:
#             print("                    if (g"+ str(j+1)+ " =" + "'1') " + "then")
#             print ('                     out1<= neigh' + str(j+1) + '(23 downto 16);')
#             # print('                      served(' + str(j+1) + ") <='1';")
#         elif j==7:
#             print("                    else")
#             print ('                     out1<= neigh' + str(j+1) + '(23 downto 16);')
#             # print('                      served(' + str(j+1) + ") <='1';")
#         else:
#             print("                    elsif (g"+ str(j+1)+ " =" + "'1') " + "then")
#             print ('                     out1<= neigh' + str(j+1) + '(23 downto 16);')
#             # print('                      served(' + str(j+1) + ") <='1';")
#     print("                      end if;")



# for i in range(8):
#     bit8lid3 = str(bin(3 + i*12))[2:]
#     bit8lid3 = (8 - len(bit8lid3))*"0" + bit8lid3
#     print('     elsif (p_adstimer = "' + bit8lid3 + '") then')    
#     for j in range(8):
#         if j==0:
#             print("                    if (g"+ str(j+1)+ " =" + "'1') " + "then")
#             print ('                     out1<= neigh' + str(j+1) + '(15 downto 8);')
#             # print('                      served(' + str(j+1) + ") <='1';")
#         elif j==7:
#             print("                    else")
#             print ('                     out1<= neigh' + str(j+1) + '(15 downto 8);')
#             # print('                      served(' + str(j+1) + ") <='1';")
#         else:
#             print("                    elsif (g"+ str(j+1)+ " =" + "'1') " + "then")
#             print ('                     out1<= neigh' + str(j+1) + '(15 downto 8);')
#             # print('                      served(' + str(j+1) + ") <='1';")
#     print("                      end if;")

# for i in range(8):
#     bit8lid4 = str(bin(4 + i*12))[2:]
#     bit8lid4 = (8 - len(bit8lid4))*"0" + bit8lid4
#     print('     elsif (p_adstimer = "' + bit8lid4 + '") then')    
#     for j in range(8):
#         if j==0:
#             print("                    if (g"+ str(j+1)+ " =" + "'1') " + "then")
#             print ('                     out1<= neigh' + str(j+1) + '(7 downto 0);')
#             # print('                      served(' + str(j+1) + ") <='1';")
#         elif j==7:
#             print("                    else")
#             print ('                     out1<= neigh' + str(j+1) + '(7 downto 0);')
#             # print('                      served(' + str(j+1) + ") <='1';")
#         else:
#             print("                    elsif (g"+ str(j+1)+ " =" + "'1') " + "then")
#             print ('                     out1<= neigh' + str(j+1) + '(7 downto 0);')
#             # print('                      served(' + str(j+1) + ") <='1';")
#     print("                      end if;")

# for i in range(8):
#     bit8typeval = str(bin(9 + i*12))[2:]
#     bit8typeval = (8 - len(bit8typeval))*"0" + bit8typeval
#     print ('                elsif(p_adstimer = "'+ bit8typeval + '") then')
#     print ('                    out1<= typeval;')

# for i in range(8):
#     bit8tos = str(bin(10 + i*12))[2:]
#     bit8tos = (8 - len(bit8tos))*"0" + bit8tos
#     print ('                elsif(p_adstimer = "'+ bit8tos + '") then')
#     print ('                    out1<= zero8;')

for i in range(8):
    bit8metric1 = str(bin(11 + i*12))[2:]
    bit8metric1 = (8 - len(bit8metric1))*"0" + bit8metric1
    print('     elsif (p_adstimer = "' + bit8metric1 + '") then')    
    for j in range(8):
        if j==0:
            print("                    if (g"+ str(j+1)+ " =" + "'1') " + "then")
            print ('                     out1<= metric' + str(j+1) + '(15 downto 8);')
            # print('                      served(' + str(j+1) + ") <='1';")
        elif j==7:
            print("                    else")
            print ('                     out1<= metric' + str(j+1) + '(15 downto 8);')
            # print('                      served(' + str(j+1) + ") <='1';")
        else:
            print("                    elsif (g"+ str(j+1)+ " =" + "'1') " + "then")
            print ('                     out1<= metric' + str(j+1) + '(15 downto 8);')
            # print('                      served(' + str(j+1) + ") <='1';")
    print("                      end if;")



for i in range(8):
    bit8metric2 = str(bin(12 + i*12))[2:]
    bit8metric2 = (8 - len(bit8metric2))*"0" + bit8metric2
    print ('                elsif(p_adstimer = "'+ bit8metric2 + '") then')
    for j in range(8):
        if j==0:
            print("                    if (g"+ str(j+1)+ "=" + "'1') " + "then")
            print ('                     out1<= metric' + str(j+1) + '(7 downto 0);')
            print('                      served(' + str(j) + ") <='1';")
        elif j==8:
            print("                    else")
            print ('                     out1<= metric' + str(j+1) + '(7 downto 0);')
            print('                      served(' + str(j) + ") <='1';")
        else:
            print("                    elsif (g"+ str(j+1)+ "=" + "'1') " + "then")
            print ('                     out1<= metric' + str(j+1) + '(7 downto 0);')
            print('                      served(' + str(j) + ") <='1';")
    print("                 end if;")
