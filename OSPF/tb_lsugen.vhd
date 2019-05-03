--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:07:37 05/03/2019
-- Design Name:   
-- Module Name:   /home/ansh/Desktop/Academics/Semester 4/CS 226/Project/CS226_OSPF/OSPF/tb_lsugen.vhd
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
 
ENTITY tb_lsugen IS
END tb_lsugen;
 
ARCHITECTURE behavior OF tb_lsugen IS 
 
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
         neighbour1 : IN  std_logic_vector(31 downto 0);
         neighbour2 : IN  std_logic_vector(31 downto 0);
         neighbour3 : IN  std_logic_vector(31 downto 0);
         neighbour4 : IN  std_logic_vector(31 downto 0);
         neighbour5 : IN  std_logic_vector(31 downto 0);
         neighbour6 : IN  std_logic_vector(31 downto 0);
         neighbour7 : IN  std_logic_vector(31 downto 0);
         neighbour8 : IN  std_logic_vector(31 downto 0);
         out_val : OUT  std_logic;
         out1 : OUT  std_logic_vector(7 downto 0);
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
         fl_val : OUT  std_logic;
         fl_out : OUT  std_logic_vector(7 downto 0);
         fl_port : OUT  std_logic_vector(7 downto 0)
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
   signal neighbour1 : std_logic_vector(31 downto 0) := (others => '0');
   signal neighbour2 : std_logic_vector(31 downto 0) := (others => '0');
   signal neighbour3 : std_logic_vector(31 downto 0) := (others => '0');
   signal neighbour4 : std_logic_vector(31 downto 0) := (others => '0');
   signal neighbour5 : std_logic_vector(31 downto 0) := (others => '0');
   signal neighbour6 : std_logic_vector(31 downto 0) := (others => '0');
   signal neighbour7 : std_logic_vector(31 downto 0) := (others => '0');
   signal neighbour8 : std_logic_vector(31 downto 0) := (others => '0');
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
   signal fl_val : std_logic;
   signal fl_out : std_logic_vector(7 downto 0);
   signal fl_port : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: lsugen PORT MAP (
          n1state => n1state,
          n2state => n2state,
          n3state => n3state,
          n4state => n4state,
          n5state => n5state,
          n6state => n6state,
          n7state => n7state,
          n8state => n8state,
          neighbour1 => neighbour1,
          neighbour2 => neighbour2,
          neighbour3 => neighbour3,
          neighbour4 => neighbour4,
          neighbour5 => neighbour5,
          neighbour6 => neighbour6,
          neighbour7 => neighbour7,
          neighbour8 => neighbour8,
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
          fl_val => fl_val,
          fl_out => fl_out,
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
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
