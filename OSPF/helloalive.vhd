----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:56:49 04/20/2019 
-- Design Name: 
-- Module Name:    helloalive - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity helloalive is
    Port (  clk : in  STD_LOGIC;
            out1 : out  STD_LOGIC_VECTOR (7 downto 0);
            on : in  STD_LOGIC;
            networkmask: in STD_LOGIC_VECTOR(31 downto 0);
            ospftemplate: in std_logic(191 downto 0);
            neighbor: out STD_LOGIC_VECTOR(31 downto 0);
            clk : in std_logic;
            val: out std_logic;
            reply_signal: in std_logic
        );

    end helloalive;

architecture Behavioral of helloalive is
signal ospfheader : STD_LOGIC_VECTOR(191 downto 0);
signal hellopacket : STD_LOGIC_VECTOR(191 downto 0);
constant tts : STD_LOGIC_VECTOR(8 downto 0) := "00010100";
constant hellointerval : STD_LOGIC_VECTOR(15 downto 0) := "01000000";
constant options, rtrpri : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
signal hellotimer : STD_LOGIC_VECTOR(7 downto 0);
signal sendtimer : STD_LOGIC_VECTOR(7 downto 0) := tts;
constant routerdeadinterval : STD_LOGIC_VECTOR(31 downto 0) := "0000000010000000"; -- 2x hello_interval
constant zero32 : STD_LOGIC_VECTOR(31 downto 0) := (others => '0'); -- DR and BDR
constant zero8 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
hellotimer <= hellointerval - tts;
ospfheader <= ospftemplate;
val <= '0';
ospfheader(15 downto 8) <= "0000001";
hellopacket(31 downto 0) <= networkmask;
hellopacket(47 downto 32) <= hellointerval;
hellopacket(55 downto 48) <= options;
hellopacket(63 downto 56) <= rtrpri;
hellopacket(95 downto 64) <= routerdeadinterval;
hellopacket(127 downto 96) <= zero32;
hellopacket(159 downto 128) <= zero32;
hellopacket(191 downto 160) <= neighbor;
signal cur_buffer(7 downto 0) <= zero8;
type states is (COUNTING, SENDING);
signal p_state, n_state : states := COUNTING;


begin
SEQ1: process(clk)
begin
if (clk='1' and clk'event) then
		p_state <= n_state;
		p_hellotimer <= n_hellotimer;
		p_sendtimer <= n_sendtimer;
        out1 <= cur_buffer;
    end if;

end process;
COMB1: process(clk, p_hellotimer, p_sendtimer, reply_signal)
begin
    case( p_state ) is
    
        when COUNTING =>
            if (reply_signal = '1') then
                n_state <= SENDING;
                n_sendtimer <= tts - "00000001"
            elsif (p_hellotimer = zero8) then
                n_state <= SENDING;
                n_sendtimer <= tts - "00000001";
            else
                n_hellotimer = p_hellotimer-"00000001";    
            end if ;
        when others =>
            
    end case ;
end process;	
end Behavioral;

