----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity helloalive is
	Generic (
		ROUTER_IP : STD_LOGIC_VECTOR(31 downto 0) := "00000001000000010000000100000001"
		);
    Port (  out1 : out  STD_LOGIC_VECTOR (7 downto 0):= "00000000";
--          on1 : in  STD_LOGIC;
--            networkmask: in STD_LOGIC_VECTOR(31 downto 0);
--            isgen : out std_logic;
--            ospfhelloheader: in STD_LOGIC_VECTOR(191 downto 0);
--          IPheader : in STD_LOGIC_VECTOR(159 downto 0);
            neighbor: in STD_LOGIC_VECTOR(31 downto 0); -- My neighbours.
            clk : in std_logic;
            val: out std_logic :='0';
            reply_signal: in std_logic := '0'
        );

    end helloalive;

architecture Behavioral of helloalive is
constant tts : STD_LOGIC_VECTOR(8 downto 0) := "001000100";
--constant hellointerval : STD_LOGIC_VECTOR(15 downto 0) := "0000000001100100";
constant hellointerval: STD_LOGIC_VECTOR(15 downto 0) :=  "0000001111101000";
constant options, rtrpri : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
--signal networkmaskm : STD_LOGIC_VECTOR(31 downto 0) := networkmask;
constant hellotimer : STD_LOGIC_VECTOR(15 downto 0) := hellointerval - tts;


constant IPheader : std_logic_vector(159 downto 0) := "1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111";
constant ospfhelloheader: STD_LOGIC_VECTOR(191 downto 0) := "000000100000000100000010001110000000000100000001000000010000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
constant networkmask : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');


signal p_hellotimer, n_hellotimer : STD_LOGIC_VECTOR(15 downto 0) := hellotimer;
signal n_sendtimer, p_sendtimer : STD_LOGIC_VECTOR(8 downto 0) := tts;
--constant routerdeadinterval : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000011001000"; -- 2x hello_interval
constant routerdeadinterval : STD_LOGIC_VECTOR(31 downto 0) :=  "00000000000000000000011111010000";


constant zero32 : STD_LOGIC_VECTOR(31 downto 0) := (others => '0'); -- DR and BDR
constant zero8 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
-- signal cur_buffer : STD_LOGIC_VECTOR(7 downto 0) := zero8;
type states is (COUNTING, SENDING, INIT);
signal p_state: states := INIT;
signal n_state: states := COUNTING;
--signal hellopacket : STD_LOGIC_VECTOR(191 downto 0) := networkmaskm & hellointerval & options & 
--                                                    rtrpri & routerdeadinterval & zero32 & zero32 & neighbor;
signal completepacket : STD_LOGIC_VECTOR(543 downto 0); 
--signal hellopacket : STD_LOGIC_VECTOR(191 downto 0) := hellopacketm;
--signal completepacket : STD_LOGIC_VECTOR(543 downto 0) :=  completepacketm;
-- ospfheader(15 downto 8) <= "0000001"; --type
-- hellopacket(31 downto 0) <= networkmask;
-- hellopacket(47 downto 32) <= hellointerval;
-- hellopacket(55 downto 48) <= options;
-- hellopacket(63 downto 56) <= rtrpri;
-- hellopacket(95 downto 64) <= routerdeadinterval;
-- hellopacket(127 downto 96) <= zero32;
-- hellopacket(159 downto 128) <= zero32;
-- hellopacket(191 downto 160) <= neighbor;

--sending packet requires 68 clock cycles

begin
SEQ1: process(clk)
variable msb : integer := 543;
variable lsb: integer := 536;
begin
if (clk='1' and clk'event) then

	p_state <= n_state;
	p_hellotimer <= n_hellotimer;
	p_sendtimer <= n_sendtimer;			
	case (n_state) is
		when COUNTING =>
			if (p_hellotimer = zero8 + "00000001") then
					msb := 543;
					lsb := 536;
			end if;
			val <='0';
		when SENDING =>
			val <= '1';
--			cur_buffer <= ;				 
			out1 <= completepacket(msb downto lsb);
			msb := msb - 8;
			lsb := lsb - 8;
	--		completepacket <= completepacket(535 downto 0) & completepacket(543 downto 536);
		when others => 
			msb := msb;
	end case;
 end if;

end process;
COMB1: process(clk, p_state, completepacket, neighbor, p_hellotimer, p_sendtimer, reply_signal)
begin
    case( p_state ) is  
		  when INIT =>
		  completepacket <= IPheader & ospfhelloheader & networkmask & hellointerval & options & 
                          rtrpri & routerdeadinterval & zero32 & zero32 & neighbor;
			n_state <= COUNTING;
			n_hellotimer <= p_hellotimer - "00000001";
        when COUNTING =>
            completepacket <= completepacket;
				if (reply_signal = '1') then
--					 val <= '1';
                n_state <= SENDING;
                n_sendtimer <= tts - "00000001";
				elsif (p_hellotimer = zero8) then
                n_state <= SENDING;
                n_sendtimer <= tts - "00000001";
--                val <= '1';
				else
                n_hellotimer <= p_hellotimer - "00000001";    
            end if;
        when others =>
            completepacket <= completepacket;
				if (p_sendtimer = zero8) then
                n_state  <= COUNTING;
                n_hellotimer <= hellotimer;
--                val <= '0';
            else
                n_sendtimer <= p_sendtimer - "00000001";
				end if;
			 end case ;
end process;	
end Behavioral;

 