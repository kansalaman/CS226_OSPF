packet = input("enter packet contents: ")
port = input("Enter port to send out: ")
for i in range(len(packet)//8):
    print("in"+ str(port) + '<="' + packet[8*i:8*(i+1)]+'";')
    print("wait for clk_period;")

    