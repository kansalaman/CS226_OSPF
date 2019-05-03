--------------------------------------------------------------------------------
-- Company:       AC/DC
-- Engineer:      Saksham Goel
--
-- Create Date:   10:24:22 05/02/2019
-- Design Name:   
-- Module Name:   /home/ise/ISE/CS226_OSPF/OSPF/LSUM_tb.vhd
-- Project Name:  OSPF
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LinkStateUpdateMachine
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY LSUM_tb IS
END LSUM_tb;
 
ARCHITECTURE behavior OF LSUM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
		component DBtoDijkstra is
		Generic
		(
		DB_ADDR_SIZE : integer := 12;
		ADDR_SIZE : integer := 6;
		NETWORK_SIZE : integer := 6;
		COST_SIZE : integer := 6;
		ROUTERID_SIZE : integer := 5;
		PORTS : integer := 8
		);
		Port
		(
		clk : in STD_LOGIC;
		write : out STD_LOGIC := '0';
		addr : out STD_LOGIC_VECTOR(5 downto 0);
		dout : out  STD_LOGIC_VECTOR ((PORTS*(NETWORK_SIZE+COST_SIZE)+2**ROUTERID_SIZE - 1) downto 0);
		db_din : in STD_LOGIC_VECTOR(7 downto 0);
		db_read : out STD_LOGIC;
		db_addr : out STD_LOGIC_VECTOR(DB_ADDR_SIZE-1 downto 0);
		enable : in STD_LOGIC;
		d_on : out STD_LOGIC
		);
		end component;
    COMPONENT LinkStateUpdateMachine
    PORT(
         clk : IN  std_logic;
         empty : IN  std_logic;
         q_din : IN  std_logic_vector(7 downto 0);
         q_read : OUT  std_logic;
         db_read : OUT  std_logic;
         db_addr : OUT  std_logic_vector(11 downto 0);
         db_din : IN  std_logic_vector(7 downto 0);
         db_write : OUT  std_logic;
         db_dout : OUT  std_logic_vector(7 downto 0);
         fl_val : OUT  std_logic;
         fl_out : OUT  std_logic_vector(7 downto 0);
         fl_port : OUT  std_logic_vector(7 downto 0);
         dijkstra_on : OUT  std_logic
        );
    END COMPONENT;
	 COMPONENT FIFOLSU
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
	COMPONENT RAMDB
	  PORT (
		 clka : IN STD_LOGIC;
		 ena : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal empty : std_logic := '0';
   signal q_din : std_logic_vector(7 downto 0) := (others => '0');
   signal db_din : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal q_read : std_logic;
   signal db_read, db_read1, db_read2 : std_logic := '0';
   signal db_addr, db_addr1, db_addr2 : std_logic_vector(11 downto 0) := (others => '0');
   signal db_write, db_write1, db_write2 : std_logic := '0';
	signal wea : std_logic_vector(0 downto 0);
   signal db_dout, db_dout1, db_dout2 : std_logic_vector(7 downto 0) := (others => '0');
   signal fl_val : std_logic;
   signal fl_out : std_logic_vector(7 downto 0);
   signal fl_port : std_logic_vector(7 downto 0);
   signal dijkstra_on : std_logic;
	signal wr_en : std_logic;
	signal din : std_logic_vector(7 downto 0);
	signal data_count : std_logic_vector(11 downto 0);
	signal full : std_logic;
	signal d_on : std_logic := '0';
	
   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	--Outputs DBtoDijkstra
	signal write_dij, read_dij : STD_LOGIC := '0';
	signal addr_dij : std_logic_vector(5 downto 0) := (others => '0');
	signal dout_dij : std_logic_vector((8*(6+6)+2**5 - 1) downto 0) := (others => '0');
	
 
BEGIN
db_write <= db_write1 or db_write2;
db_read <= db_read1 or db_read2;
db_addr <= db_addr1 or db_addr2;
db_dout <= db_dout1 or db_dout2;
wea(0) <= db_write; 
	-- Instantiate the Unit Under Test (UUT)
   uut: LinkStateUpdateMachine PORT MAP (
          clk => clk,
          empty => empty,
          q_din => q_din,
          q_read => q_read,
          db_read => db_read1,
          db_addr => db_addr1,
          db_din => db_din,
          db_write => db_write1,
          db_dout => db_dout1,
          fl_val => fl_val,
          fl_out => fl_out,
          fl_port => fl_port,
          dijkstra_on => dijkstra_on
        );
		  
	uut2: DBtoDijkstra PORT MAP (
		clk => clk,
		write => write_dij,
		addr => addr_dij,
		dout => dout_dij,
		db_din => db_din,
		db_read => db_read2,
		db_addr => db_addr2,
		enable => dijkstra_on,
		d_on => d_on
		);

	FIFO : FIFOLSU
	  PORT MAP (
		 clk => clk,
		 rst => '0',
		 din => din,
		 wr_en => wr_en,
		 rd_en => q_read,
		 dout => q_din,
		 full => full,
		 empty => empty,
		 data_count => data_count
	  );
	
	RAM : RAMDB
	  PORT MAP (
		 clka => clk,
		 ena => '1',
		 wea => wea,
		 addra => db_addr,
		 dina => db_dout,
		 douta => db_din
	  );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      wr_en <= '1'; 
      din <= "00000100";
      wait for clk_period;
     wr_en <= '1'; 
din <= "10110100";
wait for clk_period;
wr_en <= '1'; 
din <= "10010100";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000001";
wait for clk_period;
wr_en <= '1'; 
din <= "00000001";
wait for clk_period;
wr_en <= '1'; 
din <= "00000001";
wait for clk_period;
wr_en <= '1'; 
din <= "00000001";
wait for clk_period;
wr_en <= '1'; 
din <= "00000001";
wait for clk_period;
wr_en <= '1'; 
din <= "00000001";
wait for clk_period;
wr_en <= '1'; 
din <= "00000001";
wait for clk_period;
wr_en <= '1'; 
din <= "00000001";
wait for clk_period;
wr_en <= '1'; 
din <= "00000001";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000001";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00110000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000010";
wait for clk_period;
wr_en <= '1'; 
din <= "00000010";
wait for clk_period;
wr_en <= '1'; 
din <= "00000010";
wait for clk_period;
wr_en <= '1'; 
din <= "00000010";
wait for clk_period;
wr_en <= '1'; 
din <= "00000010";
wait for clk_period;
wr_en <= '1'; 
din <= "11111111";
wait for clk_period;
wr_en <= '1'; 
din <= "11111111";
wait for clk_period;
wr_en <= '1'; 
din <= "11111111";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000011";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000011";
wait for clk_period;
wr_en <= '1'; 
din <= "00000011";
wait for clk_period;
wr_en <= '1'; 
din <= "00000011";
wait for clk_period;
wr_en <= '1'; 
din <= "00000011";
wait for clk_period;
wr_en <= '1'; 
din <= "11111111";
wait for clk_period;
wr_en <= '1'; 
din <= "11111111";
wait for clk_period;
wr_en <= '1'; 
din <= "11111111";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000011";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '0';

wait for 10*clk_period;
wr_en <= '1';
din <= "00100000";
wait for clk_period;
wr_en <= '1'; 
din <= "10010001";
wait for clk_period;
wr_en <= '1'; 
din <= "11100100";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000001";
wait for clk_period;
wr_en <= '1'; 
din <= "00000101";
wait for clk_period;
wr_en <= '1'; 
din <= "00000101";
wait for clk_period;
wr_en <= '1'; 
din <= "00000101";
wait for clk_period;
wr_en <= '1'; 
din <= "00000101";
wait for clk_period;
wr_en <= '1'; 
din <= "00000101";
wait for clk_period;
wr_en <= '1'; 
din <= "00000101";
wait for clk_period;
wr_en <= '1'; 
din <= "00000101";
wait for clk_period;
wr_en <= '1'; 
din <= "00000101";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000001";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00110000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000010";
wait for clk_period;
wr_en <= '1'; 
din <= "11000000";
wait for clk_period;
wr_en <= '1'; 
din <= "10101000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000001";
wait for clk_period;
wr_en <= '1'; 
din <= "00111011";
wait for clk_period;
wr_en <= '1'; 
din <= "11111111";
wait for clk_period;
wr_en <= '1'; 
din <= "11111111";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000011";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "11000000";
wait for clk_period;
wr_en <= '1'; 
din <= "10101000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000001";
wait for clk_period;
wr_en <= '1'; 
din <= "00111100";
wait for clk_period;
wr_en <= '1'; 
din <= "11111111";
wait for clk_period;
wr_en <= '1'; 
din <= "11111111";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000011";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '1'; 
din <= "00000000";
wait for clk_period;
wr_en <= '0';
      wait;
   end process;

END;
