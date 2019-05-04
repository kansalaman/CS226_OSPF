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

entity LSAFilter is
    Port ( clk : in  STD_LOGIC;
           wr_en : in  STD_LOGIC;
           --rst : in STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (7 downto 0);
           rd_en : in  STD_LOGIC;
           dout : out  STD_LOGIC_VECTOR (7 downto 0);
           empty : out  STD_LOGIC);
end LSAFilter;

architecture Behavioral of LSAFilter is
	COMPONENT FIFOLSU IS
	  PORT (
	    clk : IN STD_LOGIC;
	    rst : IN STD_LOGIC;
	    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    wr_en : IN STD_LOGIC;
	    rd_en : IN STD_LOGIC;
	    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	    full : OUT STD_LOGIC;
	    empty : OUT STD_LOGIC;
	    data_count : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	  );
	END COMPONENT;
	type arr1 is array(0 to 20) of std_logic_vector(7 downto 0);
	signal data_arr : arr1;
	signal outqueue_din: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal inqueue_dout : STD_LOGIC_VECTOR(7 downto 0) ;
	signal outqueue_wr_en, inqueue_rd_en : STD_LOGIC := '0';
	signal inqueue_empty : STD_LOGIC;
	signal ram_read : std_logic;
	signal ram_data : std_logic_vector(7 downto 0);
	type states is (idle,q_reading,processing,q_writing);
	signal p_state,n_state : states := idle;
	signal data_obtained : integer := 0;
	signal p_counter,n_counter : integer := 0;
	
begin
	INPUTQUEUE : FIFOLSU PORT MAP (clk => clk,
								   rst => rst,
								   din => din,
								   wr_en => wr_en,
								   rd_en => inqueue_rd_en,
								   dout => inqueue_dout,
								   full => open,
								   empty => inqueue_empty,
								   data_count => open);
	OUTPUTQUEUE : FIFOLSU PORT MAP (clk => clk,
									rst => rst,
									din => outqueue_din,
									wr_en => outqueue_wr_en,
									rd_en => rd_en,
									dout => dout,
									full => open,
									empty => empty,
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

		if(current_state=q_reading) then
			inqueue_rd_en <= '1';
		else
			inqueue_rd_en <= '0';
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

comb2 : process(dataobtained,inqueue_dout)
begin
if(data_obtained < 20) then
	data_arr(data_obtained+1) <= inqueue_dout;
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
				n_state <= processing;
				n_counter <= 1;
			else
				n_state <= p_state;
				n_counter <= p_counter+1;
			end if;
		
		when processing =>
			
		when q_writing =>
			if(p_counter=20) then
				n_state <= idle;
				n_counter <= 0;
			else
				n_state <= idle;
				n_counter <= p_counter+1;
			end if;
		
		when others =>
				null;
		end process;

 
end Behavioral;