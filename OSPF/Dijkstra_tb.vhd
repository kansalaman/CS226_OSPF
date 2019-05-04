--------------------------------------------------------------------------------
-- Company: 		AC/DC
-- Engineer:		Saksham Goel
--
-- Create Date:   18:46:45 04/30/2019
-- Design Name:   
-- Module Name:   /home/ise/ISE/CS226_OSPF/OSPF/Dijkstra_tb.vhd
-- Project Name:  OSPF
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Dijkstra
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
 
ENTITY Dijkstra_tb IS
END Dijkstra_tb;
 
ARCHITECTURE behavior OF Dijkstra_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Dijkstra
    PORT(
         din : IN  std_logic_vector(95 downto 0);
			ip_in : IN std_logic_vector(31 downto 0);
         addr_read : OUT  std_logic_vector(5 downto 0);
         read : OUT  std_logic;
         write : OUT  std_logic;
         addr_write : OUT  std_logic_vector(5 downto 0);
         dout : OUT  std_logic_vector(63 downto 0);
         enable : IN  std_logic;
         done : OUT  std_logic;
			help : OUT STD_LOGIC_VECTOR(7 downto 0);
			router_ip : in std_logic_vector(31 downto 0);
         clk : IN  std_logic
        );
    END COMPONENT;
    
	 COMPONENT RAMDijkstra
	PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
  );
END COMPONENT;

COMPONENT RoutingDB
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
  );
END COMPONENT;

   --Inputs
   signal din, dina : std_logic_vector(127 downto 0) := (others => '0');
   signal enable : std_logic := '0';
   signal clk : std_logic := '0';
	signal wea1,wea2 : std_logic_vector(0 downto 0) := "0";
	signal router_ip : std_logic_vector(31 downto 0) := "00000001000000010000000100000001";
 	--Outputs
   signal addr_read : std_logic_vector(5 downto 0);
   signal read : std_logic;
   signal write : std_logic;
   signal addr_write : std_logic_vector(5 downto 0);
   signal dout, douta : std_logic_vector(63 downto 0);
   signal done : std_logic;
	signal help : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
wea2(0) <= write;
	-- Instantiate the Unit Under Test (UUT)
   uut: Dijkstra PORT MAP (
          din => din(95 downto 0),
			 ip_in => din(127 downto 96),
          addr_read => addr_read,
          read => read,
          write => write,
          addr_write => addr_write,
          dout => dout,
          enable => enable,
          done => done,
			 help => help,
			 router_ip => router_ip,
          clk => clk
        );
	RAM: RAMDijkstra PORT MAP(
			clka => clk,
			ena => '1',
			wea => wea1,
			addra => addr_read,
			dina => dina,
			douta => din
		  );
		  
	RDB : RoutingDB
	  PORT MAP (
		 clka => clk,
		 ena => '1',
		 wea => wea2,
		 addra => addr_write,
		 dina => dout,
		 douta => douta
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
		enable <= '1';
      wait for clk_period*10;
		enable <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
