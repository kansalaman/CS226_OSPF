----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:25:55 04/13/2019 
-- Design Name: 
-- Module Name:    Parser - Behavioral 
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

entity Parser is
    Port ( in1 : in  STD_LOGIC_VECTOR (7 downto 0);
           validity : in  STD_LOGIC;
           clk : in  STD_LOGIC;
--           interface_no : in  STD_LOGIC_VECTOR (2 downto 0);
           out1 : out  STD_LOGIC_VECTOR (8 downto 0);
           hello_out : out  STD_LOGIC;
           ls_out : out  STD_LOGIC;
           common_out_16: out STD_LOGIC_VECTOR(15 downto 0);
           common_out_8: out STD_LOGIC_VECTOR(7 downto 0);
           packet_len_valid: out STD_LOGIC);
end Parser;

architecture Behavioral of Parser is
signal typePacket : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal packet_length : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal p_counter, n_counter : INTEGER := 0;
type states is (IDLE, IP_STRIP, OSPF_STRIP, HELLO, LS);
signal p_state, n_state : states := IDLE;
--signal n_hello_out, n_ls_out : STD_LOGIC := '0';
begin
SEQ: process(clk)
begin
	if (clk'event and clk = '1') then
		p_state <= n_state;
--		hello_out <= n_hello_out;
--		ls_out <= n_ls_out;
		p_counter <= n_counter;
		if (n_state = OSPF_STRIP and n_counter = 2) then
			typePacket <= in1;
		end if;
        if (n_state = OSPF_STRIP and n_counter > 2  and n_counter + 1< 5 ) then
                common_out_16 <= 
				packet_length <= packet_length(7 downto 0) & in1;
		end if;
		
		if (n_state = HELLO) then
			hello_out <= '1';
		else
			hello_out <= '0';
		end if;
		
		if (n_state = LS) then
			ls_out <= '1';
		else
			ls_out <= '0';
		end if;
	end if;
end process; 

COMB: process(validity, p_state, in1, p_counter, typepacket, packet_length)
--variable packet_length : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
begin
	case p_state is
		when IDLE =>
			if (validity = '1') then
				n_state <= IP_STRIP;
				n_counter <= 2;
			else
				n_state <= IDLE;
				n_counter <= 0;
			end if;

		when IP_STRIP =>
			if p_counter = 20 then
				n_state <= OSPF_STRIP;
				n_counter <= 0;
			else
				n_state <= IP_STRIP;
				n_counter <= p_counter + 1;
			end if;

		when OSPF_STRIP =>
			n_counter <= p_counter + 1;
			if (p_counter + 1 < 5 ) then
				n_state <= p_state;
			elsif (p_counter + 1 > 23) then
				--packet_length := packet_length;
				if (typePacket = "00000001" or typePacket = "00000010") then
					n_state <= HELLO;
--					n_hello_out <= '1';
--					n_ls_out <= '0';
					--typePacket := typePacket;
				elsif (typePacket = "00000101" or typePacket = "00000011" or typePacket = "00000100") then
					n_state <= LS;
--					n_ls_out <= '1';
--					n_hello_out <= '0';
				else
					n_state <= OSPF_STRIP;
--					n_ls_out <= '0';
--					n_hello_out <= '0';
				end if;
			elsif (validity = '1') then
				n_state <= p_state;
			else
				--typePacket := typePacket;
				--packet_length := packet_length;
				n_state <= IDLE;
			end if;

		when HELLO =>
			--typePacket := typePacket;
			--packet_length := packet_length;
--			n_hello_out <= '1';
--			n_counter <= p_counter + 1;
			if  p_counter + 1 > packet_length then
--				n_hello_out <= '0';
				n_counter <= 0;
				if (validity = '1') then
					n_state <= IP_STRIP;
				else
					n_state <= IDLE;
				end if;
			else
				n_counter <= p_counter + 1;
				n_state <= p_state;
			end if;

		when others =>
			--typePacket := typePacket;
			--packet_length := packet_length;
--			n_ls_out <= '1';
--			n_counter <= p_counter + 1;
			if  p_counter + 1 > packet_length then
--				n_ls_out <= '0';
				if (validity = '1') then
					n_state <= IP_STRIP;
					n_counter <= 1;
				else
					n_state <= IDLE;
					n_counter <= 0;
				end if;
			else
				n_counter <= p_counter + 1;
				n_state <= p_state;
			end if;
	end case;
end process;

end Behavioral;

