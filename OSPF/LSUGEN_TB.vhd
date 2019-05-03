--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:25:12 05/03/2019
-- Design Name:   
-- Module Name:   /home/ansh/Desktop/Academics/Semester 4/CS 226/Project/CS226_OSPF/OSPF/LSUGEN_TB.vhd
-- Project Name:  OSPF
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: lsugen
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
 
ENTITY LSUGEN_TB IS
END LSUGEN_TB;
 
ARCHITECTURE behavior OF LSUGEN_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT lsugen
    PORT(
         n1state : IN  std_logic_vector(2 downto 0);
         n2state : IN  std_logic_vector(2 downto 0);
         n3state : IN  std_logic_vector(2 downto 0);
         n4state : IN  std_logic_vector(2 downto 0);
         n5state : IN  std_logic_vector(2 downto 0);
         n6state : IN  std_logic_vector(2 downto 0);
         n7state : IN  std_logic_vector(2 downto 0);
         n8state : IN  std_logic_vector(2 downto 0);
         neigh1 : IN  std_logic_vector(31 downto 0);
         neigh2 : IN  std_logic_vector(31 downto 0);
         neigh3 : IN  std_logic_vector(31 downto 0);
         neigh4 : IN  std_logic_vector(31 downto 0);
         neigh5 : IN  std_logic_vector(31 downto 0);
         neigh6 : IN  std_logic_vector(31 downto 0);
         neigh7 : IN  std_logic_vector(31 downto 0);
         neigh8 : IN  std_logic_vector(31 downto 0);
         out_val : INOUT  std_logic;
         out1 : INOUT  std_logic_vector(7 downto 0);
         negIface : OUT  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         empty : IN  std_logic;
         db_read : OUT  std_logic;
         db_addr : OUT  std_logic_vector(11 downto 0);
         db_din : IN  std_logic_vector(7 downto 0);
         db_write : OUT  std_logic;
         db_dout : OUT  std_logic_vector(7 downto 0);
         db_busy_read : IN  std_logic;
         db_busy_write : IN  std_logic;
         fl_port : OUT  std_logic_vector(7 downto 0)
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
   signal n1state : std_logic_vector(2 downto 0) := (others => '0');
   signal n2state : std_logic_vector(2 downto 0) := (others => '0');
   signal n3state : std_logic_vector(2 downto 0) := (others => '0');
   signal n4state : std_logic_vector(2 downto 0) := (others => '0');
   signal n5state : std_logic_vector(2 downto 0) := (others => '0');
   signal n6state : std_logic_vector(2 downto 0) := (others => '0');
   signal n7state : std_logic_vector(2 downto 0) := (others => '0');
   signal n8state : std_logic_vector(2 downto 0) := (others => '0');
   signal neigh1 : std_logic_vector(31 downto 0) := (others => '0');
   signal neigh2 : std_logic_vector(31 downto 0) := (others => '0');
   signal neigh3 : std_logic_vector(31 downto 0) := (others => '0');
   signal neigh4 : std_logic_vector(31 downto 0) := (others => '0');
   signal neigh5 : std_logic_vector(31 downto 0) := (others => '0');
   signal neigh6 : std_logic_vector(31 downto 0) := (others => '0');
   signal neigh7 : std_logic_vector(31 downto 0) := (others => '0');
   signal neigh8 : std_logic_vector(31 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal empty : std_logic := '0';
   signal db_din : std_logic_vector(7 downto 0) := (others => '0');
   signal db_busy_read : std_logic := '0';
   signal db_busy_write : std_logic := '0';
	
 	--Outputs
   signal out_val : std_logic;
   signal out1 : std_logic_vector(7 downto 0);
   signal negIface : std_logic_vector(7 downto 0);
   signal db_read : std_logic;
   signal db_addr : std_logic_vector(11 downto 0);
   signal db_write : std_logic;
   signal db_dout : std_logic_vector(7 downto 0);
   signal fl_port : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
	neigh1 <= "11111111000000001111111100000000";
	neigh2 <= "11111111000000001111111100000000";
	neigh3 <= "11111111000000001111111100000000";
	neigh4 <= "11111111000000001111111100000000";
	neigh5 <= "11111111000000001111111100000000";
	neigh6 <= "11111111000000001111111100000000";
	neigh7 <= "11111111000000001111111100000000";
	neigh8 <= "11111111000000001111111100000000";
	-- Instantiate the Unit Under Test (UUT)
   comp: RAMDB PORT MAP (
	 clka => clk, 
    ena => '1',
    wea => "0",
    addra => db_addr,
    dina => db_dout,
    douta => db_din);
	 
	 
	uut: lsugen PORT MAP (
          n1state => n1state,
          n2state => n2state,
          n3state => n3state,
          n4state => n4state,
          n5state => n5state,
          n6state => n6state,
          n7state => n7state,
          n8state => n8state,
          neigh1 => neigh1,
          neigh2 => neigh2,
          neigh3 => neigh3,
          neigh4 => neigh4,
          neigh5 => neigh5,
          neigh6 => neigh6,
          neigh7 => neigh7,
          neigh8 => neigh8,
          out_val => out_val,
          out1 => out1,
          negIface => negIface,
          clk => clk,
          empty => empty,
          db_read => db_read,
          db_addr => db_addr,
          db_din => db_din,
          db_write => db_write,
          db_dout => db_dout,
          db_busy_read => db_busy_read,
          db_busy_write => db_busy_write,
          fl_port => fl_port
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

      wait for clk_period*10;
		n1state<="000";
		n2state<="000";
		n3state<="000";
		n4state<="000";
      n5state<="000";
		n6state<="000";
		n7state<="000";
		n8state<="000";
		-- insert stimulus here 
		wait for clk_period*50;
      n1state <= "111";
		wait for clk_period *150;
		n2state <= "111";
--		wait for clk_period*150;
--		n1state <= "000";
--		n2state <= "000";
		wait;
   end process;

END;
