--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:52:30 04/25/2019
-- Design Name:   
-- Module Name:   /home/ansh/Desktop/Academics/Semester 4/CS 226/CS226_OSPF/OSPF/tb_helloalive.vhd
-- Project Name:  OSPF
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: helloalive
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
 
ENTITY tb_helloalive IS
END tb_helloalive;
 
ARCHITECTURE behavior OF tb_helloalive IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT helloalive
    PORT(
         out1 : OUT  std_logic_vector(7 downto 0);
         on1 : IN  std_logic;
         networkmask : IN  std_logic_vector(31 downto 0);
         ospfhelloheader : IN  std_logic_vector(191 downto 0);
         IPheader : IN  std_logic_vector(31 downto 0);
         neighbor : INOUT  std_logic_vector(31 downto 0);
         clk : IN  std_logic;
         val : OUT  std_logic;
         reply_signal : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal on1 : std_logic := '0';
   signal networkmask : std_logic_vector(31 downto 0) := (others => '0');
   signal ospfhelloheader : std_logic_vector(191 downto 0) := (others => '0');
   signal IPheader : std_logic_vector(31 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal reply_signal : std_logic := '0';

	--BiDirs
   signal neighbor : std_logic_vector(31 downto 0);

 	--Outputs
   signal out1 : std_logic_vector(7 downto 0);
   signal val : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: helloalive PORT MAP (
          out1 => out1,
          on1 => on1,
          networkmask => networkmask,
          ospfhelloheader => ospfhelloheader,
          IPheader => IPheader,
          neighbor => neighbor,
          clk => clk,
          val => val,
          reply_signal => reply_signal
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

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
