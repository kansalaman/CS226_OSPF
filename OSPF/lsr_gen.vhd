----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:23:26 05/03/2019 
-- Design Name: 
-- Module Name:    LSAFilter - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LSRgen is
    Generic
    (
        PORT_NO : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
        router_id : std_logic_vector(31 downto 0) := "11110011000000000000000000000000"
    );
    Port ( clk : in  STD_LOGIC;
           wr_en : in  STD_LOGIC;
           --rst : in STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (7 downto 0);
        --    rd_en : in  STD_LOGIC;
           dout : out  STD_LOGIC_VECTOR (7 downto 0);
           out_val : out std_logic;
           done_sending : out  STD_LOGIC);
end LSRgen;

architecture Behavioral of LSRgen is
	COMPONENT FIFOACK
PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    data_count : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
END COMPONENT;
	-- END COMPONENT;
	type arr1 is array(0 to 20) of std_logic_vector(7 downto 0);
	signal data_arr : arr1;
	-- signal outqueue_din: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal qdata : STD_LOGIC_VECTOR(7 downto 0) ;
	signal readq : STD_LOGIC := '0';
	signal qempt : STD_LOGIC;
	-- signal ram_read : std_logic;
	-- signal ram_data : std_logic_vector(7 downto 0);
	type states is (idle,q_reading,ipheader_sending,ospfheader_sending,data_sending);
	signal p_state,n_state : states := idle;
	signal data_obtained : integer := 0;
	signal p_counter,n_counter : integer := 0;
	signal rst: std_logic;
	
begin
done_sending <= qempt;
	INPUTQUEUE : FIFOACK PORT MAP (clk => clk,
								   srst => rst,
								   din => din,
								   wr_en => wr_en,
								   rd_en => readq,
								   dout => qdata,
								   full => open,
								   empty => qempt,
								   data_count => open);
process(clk)
	variable current_byte_no : integer;
	variable current_state : states;
begin
	if(clk='1' and clk'event) then
		current_byte_no := n_counter;
		current_state := n_state;
		
		p_state <= n_state;
        p_counter <= n_counter;
        


        if(current_state=ipheader_sending) then
            dout <= "00000000";
            out_val <= '1';
        elsif(current_state=ospfheader_sending and current_byte_no=1) then
            dout <= "00000010";
            out_val <= '1';
        elsif (current_state=ospfheader_sending and current_byte_no=2) then
            dout <= "00000011";
            out_val <= '1';
        elsif(current_state=ospfheader_sending and current_byte_no=3) then
            dout <= "00000000";
            out_val <= '1';
        elsif (current_state=ospfheader_sending and current_byte_no=4) then
            dout <= "00111000";
            out_val <= '1';
        elsif (current_state=ospfheader_sending and current_byte_no=5) then
            dout <= router_id(31 downto 24);
            out_val <= '1';
        elsif (current_state=ospfheader_sending and current_byte_no=6) then
            dout <= router_id(23 downto 16);
            out_val <= '1';
        elsif (current_state=ospfheader_sending and current_byte_no=7) then
            dout <= router_id(15 downto 8);
            out_val <= '1';
        elsif (current_state=ospfheader_sending and current_byte_no=8) then
            dout <= router_id(7 downto 0);
            out_val <= '1';
        elsif (current_state=ospfheader_sending and current_byte_no>8 and current_byte_no<25) then
            dout <= "00000000";
            out_val <= '1';
        elsif(current_state=data_sending and current_byte_no>0 and current_byte_no<4) then
            dout <= "00000000";
            out_val <= '1';
        elsif(current_state=data_sending and current_byte_no=4) then
            dout <= data_arr(4);
            out_val <= '1';
        elsif(current_state=data_sending and current_byte_no>4 and current_byte_no<13) then
            dout <= data_arr(current_byte_no);
            out_val <= '1';
        else
            dout <= "00000000";
            out_val <= '0';
        end if;

            

        

            
            

		if(current_state=q_reading) then
			readq <= '1';
		else
			readq <= '0';
		end if;

		if(current_state=idle) then
			data_obtained <= 0;
		elsif(current_state=q_reading and current_byte_no=1) then
			data_obtained <= 0;
		elsif(current_state=q_reading and current_byte_no=2) then
			data_obtained <= 0;
		else
			data_obtained <= data_obtained+1;
		end if;


end if;

end process;

comb2 : process(data_obtained,qdata)
begin
if(data_obtained < 20) then
	data_arr(data_obtained+1) <= qdata;
end if;
end process;	

comb1 : process(p_state,p_counter,qempt)
begin
	case p_state is
		when IDLE =>
			if(qempt = '0') then
				n_state <= q_reading;
				n_counter <= 1;
			else
				n_state <= p_state;
				n_counter <= 0;
			end if;
		
		when q_reading =>
			if(p_counter = 20) then
				n_state <= ipheader_sending;
				n_counter <= 1;
			else
				n_state <= p_state;
				n_counter <= p_counter+1;
			end if;
		
        when ipheader_sending =>
            if(p_counter = 20) then
                n_state <= ospfheader_sending;
                n_counter <= 1;
            else
                n_state <= p_state;
                n_counter <= p_counter+1;
            end if;
        
        when ospfheader_sending =>
            if(p_counter = 24) then
                n_state <= data_sending;
                n_counter <= 1;
            else
                n_state <= p_state;
                n_counter <= p_counter+1;
            end if;
                
                
			
		when data_sending =>
			if(p_counter=12) then
				n_state <= idle;
				n_counter <= 0;
			else
				n_state <= p_state;
				n_counter <= p_counter+1;
			end if;
		
		when others =>
                null;
        end case;
		  end process;


 
end Behavioral;