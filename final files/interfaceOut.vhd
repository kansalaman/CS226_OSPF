----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:48:48 05/03/2019 
-- Design Name: 
-- Module Name:    ACK_generator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity interfaceOut is
    Generic
    (
        PORT_NO : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
        router_id : std_logic_vector(31 downto 0) := "11110011000000000000000000000000"
    );
    Port ( 
           clk : in std_logic;
           qin1 : in std_logic_vector(7 downto 0);
           qin2 : in std_logic_vector(7 downto 0);
           readq1 : out std_logic;
           readq2 : out std_logic;
           empq1 : in std_logic;
           empq2 : in std_logic;
           dout: out std_logic_vector(7 downto 0);
        -- if((current_state=serve1 or current_state=serve2) and not(current_byte_no=1 or current_byte_no=2)) then
           dout_val: out std_logic);
end interfaceOut;

architecture Behavioral of interfaceOut is

-- COMPONENT FIFOACK
-- PORT (
--     clk : IN STD_LOGIC;
--     srst : IN STD_LOGIC;
--     din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
--     wr_en : IN STD_LOGIC;
--     rd_en : IN STD_LOGIC;
--     dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
--     full : OUT STD_LOGIC;
--     empty : OUT STD_LOGIC;
--     data_count : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
--     );
-- END COMPONENT;

-- type states is (idle,getLSAcount,sendHeader,sendLSA);
-- signal p_state,n_state : states := idle;
-- signal p_counter,n_counter : integer := 0;
-- signal empty : std_logic;
-- signal rd_en,srst,full : std_logic;
-- signal data_count : STD_LOGIC_VECTOR(10 downto 0);

signal typeq1 : std_logic_vector(7 downto 0) := "00000100";
signal typeq2 : std_logic_vector(7 downto 0) := "00000101";
type states is (idle,serve1,serve2,makeHead,packetout);
type arr1 is array(0 to 360) of std_logic_vector(7 downto 0);
signal data_arr : arr1;
signal packet_count : integer range 0 to 3 := 0;
signal makeLSUhead : integer range 0 to 3 := 1;
signal p_index,n_index : integer := 0;
signal max_index : integer := 0;
signal p_state,n_state : states := idle;
signal p_counter,n_counter : integer := 0;
signal lsa_length : std_logic_vector(15 downto 0) := (others => '1');
signal lsa_length_int : integer := 0;
signal dataout : std_logic_vector(7 downto 0);
signal dataobtained_p : integer := 0;
--signal dataobtained_n : integer := 1;
signal dataobtained : integer := 0;
signal plen_vec1,plen_vec2 : std_logic_vector(31 downto 0);
signal state_temp : integer range 0 to 3;
signal temp_wait : integer := 0;
begin
plen_vec1 <= std_logic_vector(to_unsigned(max_index+24,32));
plen_vec2 <= std_logic_vector(to_unsigned(max_index+28,32));
comb4: process(p_state,lsa_length)
begin
if(p_state=idle) then
	lsa_length_int <= 50;
else
	lsa_length_int <= conv_integer(lsa_length);
end if;
end process;

process(clk)
    variable current_byte_no : integer;
    variable current_state : states;
    variable dataread : integer;
begin
    if(clk='1' and clk'event) then
        current_byte_no := n_counter;
        current_state := n_state;
      --  dataread := dataobtained_n;

        p_state <= n_state;
        p_counter <= n_counter;

        if((current_state = serve1 or current_state = serve2) and current_byte_no=lsa_length_int and temp_wait=0) then
            temp_wait <= 2;
        elsif((current_state = serve1 or current_state = serve2) and current_byte_no=lsa_length_int and temp_wait=2) then
            temp_wait <= 1;
        else
            temp_wait <=0;
        end if;
        


        if(current_state=serve1) then
            state_temp <= 1;
        elsif(current_state=serve2) then
            state_temp <=2;
        end if;

        if(current_state=serve1) then
            makeLSUhead <= 1;
        elsif(current_state=serve2) then
            makeLSUhead <= 2;
        end if;

        if(temp_wait = 0) then
        if(current_state=idle) then
            packet_count <= 0;
        elsif(current_state=serve1 or current_state=serve2) then
            if(current_byte_no=lsa_length_int) then
                packet_count <= packet_count+1;
            else
                packet_count <= packet_count;
            end if;
        end if;
        end if;


        if(current_state=idle) then
            lsa_length <= "1111111111111111";
        elsif(current_state=serve2 and dataobtained_p=19) then
            lsa_length(15 downto 8) <= data_arr(19);
        elsif(current_state=serve2 and dataobtained_p=20) then
            lsa_length(7 downto 0) <= data_arr(20);
        elsif(current_state=serve1) then
            lsa_length <= "0000000000010100";
        end if;

        if(temp_wait=0) then
        if(current_state=serve1 or current_state=serve2) then
            max_index <= max_index+1;
        elsif(current_state=idle) then
            max_index <= 0;
            --temp_wait <= 0;
        else
            max_index <= max_index;
        end if;
        end if;


        if(current_state=makeHead and current_byte_no=1) then
            dout_val <= '1';
            dout <= "00000010";
        elsif (current_state=makeHead and current_byte_no=2) then
            dout_val <= '1';
            dout <= "00000100";
        elsif(current_state=makeHead and current_byte_no=3 and makeLSUhead=1) then
            dout_val <= '1';
            dout <= plen_vec1(15 downto 8);
        elsif(current_state=makeHead and current_byte_no=4 and makeLSUhead=1) then
            dout_val <= '1';
            dout <= plen_vec1(7 downto 0);
        elsif(current_state=makeHead and current_byte_no=3 and makeLSUhead=2) then
            dout_val <= '1';
            dout <= plen_vec2(15 downto 8);
        elsif(current_state=makeHead and current_byte_no=4 and makeLSUhead=2) then
            dout_val <= '1';
            dout <= plen_vec2(7 downto 0);
        elsif(current_state=makeHead and current_byte_no=5) then
            dout_val <= '1';
            dout <= router_id(31 downto 24);
        elsif(current_state=makeHead and current_byte_no=6) then
            dout_val <= '1';
            dout <= router_id(23 downto 16);
        elsif(current_state=makeHead and current_byte_no=7) then
            dout_val <= '1';
            dout <= router_id(15 downto 8);
        elsif(current_state=makeHead and current_byte_no=8) then
            dout_val <= '1';
            dout <= router_id(7 downto 0);
        elsif(current_state=makeHead and current_byte_no>=9 and current_byte_no<=24) then
            dout_val <= '1';
            dout <= "00000000";
        elsif(current_state=makeHead and current_byte_no/=28) then
            dout_val <= '1';
            dout <= "00000000";
        elsif(current_state=makeHead and current_byte_no=28 and temp_wait=0) then
            dout_val <= '1';
            dout <= std_logic_vector(to_unsigned(packet_count,8));
        
        elsif(current_state=packetout) then
            dout_val <= '1';
            dout <= data_arr(current_byte_no);
		  else
				dout_val <= '0';
        end if;
        
        
        

        
            
            --continue from here
            


        if(current_state=serve1 and temp_wait = 0) then
            readq1 <= '1';
            -- max_index <= current_byte_no;
        else
            readq1 <= '0';
        end if;

        if(current_state=serve2 and temp_wait = 0) then
            readq2 <= '1';
            -- max_index <= current_byte_no;
        else
            readq2 <= '0';
        end if;
        
            

-- if((current_state=serve1 or current_state=serve2) and current_byte_no=1) then
        --     dataobtained_p <= 0;
        -- elsif ((current_state=serve1 or current_state=serve2) and current_byte_no=2) then
        --     dataobtained_p <= 0;
        -- elsif(current_state=serve1 or current_state=serve2) then
        --     dataobtained_p <= dataobtained_n;
        -- end if;
        
        -- if((current_state=serve1 or current_state=serve2) and current_byte_no=1)
        if(current_state=idle) then
            dataobtained_p <= 0;
        elsif((current_state=serve1 or current_state=serve2) and max_index+1=1) then
            dataobtained_p <= 0;
        elsif ((current_state=serve1 or current_state=serve2) and max_index+1=2) then
            dataobtained_p <= 0;
        elsif((current_state=serve1 or current_state=serve2) and (current_byte_no=1 or current_byte_no=2)) then
            dataobtained_p <= dataobtained_p;
        else
            dataobtained_p <= dataobtained_p+1;
        end if;
end if;

end process;

comb2 : process(qin1,max_index,dataobtained_p,qin2,state_temp)
begin
if(dataobtained_p < max_index) then
    if(state_temp = 1) then
        data_arr(dataobtained_p+1) <= qin1;
    elsif (state_temp=2) then
        data_arr(dataobtained_p+1) <= qin2;
    end if;
        
end if;
end process;

-- comb3 : process(qin2,max_index,dataobtained_p)
-- begin
--     if(dataobtained_p < max_index) then
--         -- dataobtained_n <= dataobtained_p+1;
--         data_arr(dataobtained_p+1) <= qin2;
--     end if;
-- end process;


comb1 : process(p_state,p_counter,empq1,empq2,packet_count,lsa_length_int,makeLSUhead,max_index,temp_wait)
begin
    case p_state is
        when idle =>
            if(empq1='0') then
                n_state <= serve1;
                n_counter <= 1;
            elsif (empq2='0') then
                n_state <= serve2;
                n_counter <= 1;
            else
                n_state <= idle;
                n_counter <= 0;
            end if;
                
        when serve1 =>
            if(packet_count = 3) then
                n_state <= makeHead;
                n_counter <= 1;
            elsif(empq1='1') then
                n_state <= makeHead;
                n_counter <= 1;
            elsif(p_counter=lsa_length_int and temp_wait/=0) then
                n_state <= p_state;
                n_counter <= p_counter;
            elsif(p_counter=lsa_length_int and temp_wait=0) then
                n_state <= p_state;
                n_counter <= 1;
            else
                n_state <= p_state;
                n_counter <= p_counter+1;
            end if;
        when serve2 =>
            if(packet_count = 3) then
                n_state <= makeHead;
                n_counter <= 1;
            elsif(empq2='1') then
                n_state <= makeHead;
                n_counter <= 1;
            elsif(p_counter=lsa_length_int and temp_wait/=0) then
                n_state <= p_state;
                n_counter <= p_counter;
            elsif(p_counter=lsa_length_int and temp_wait=0) then
                n_state <= p_state;
                n_counter <= 1;
            else
                n_state <= p_state;
                n_counter <= p_counter+1;
            end if;
        when makeHead =>
            if(makeLSUhead = 1 and p_counter = 24) then
                n_state <= packetout;
                n_counter <= 1;
            elsif(makeLSUhead = 2 and p_counter = 28) then
                n_state <= packetout;
                n_counter <= 1;
            else
                n_state <= p_state;
                n_counter <= p_counter+1;
            end if;
        when packetout =>
            if(p_counter = max_index) then
                n_state <= idle;
                n_counter <= 0;
            else
                n_state <= p_state;
                n_counter <= p_counter+1;
            end if;

        end case;
		  end process;

        


end Behavioral;

