--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:30:48 05/04/2019
-- Design Name:   
-- Module Name:   /home/yash20/isefiles/CS226_OSPF/OSPF/LSAFetcherTb.vhd
-- Project Name:  OSPF
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LSAFetcher
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
 
ENTITY LSAFetcherTb IS
END LSAFetcherTb;
 
ARCHITECTURE behavior OF LSAFetcherTb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LSAFetcher
    PORT(
         clk : IN  std_logic;
         rd_en : IN  std_logic;
         rst : IN  std_logic;
         num_lsa : OUT  std_logic_vector(1 downto 0);
         db_rd_en : OUT  std_logic;
         db_addr : OUT  std_logic_vector(11 downto 0);
         db_din : IN  std_logic_vector(7 downto 0);
         dout : OUT  std_logic_vector(7 downto 0);
         db_busy : IN  std_logic;
         rd_val : OUT  std_logic;
         empty : OUT std_logic
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
   END component;

   --Inputs
   signal clk : std_logic := '0';
   signal rd_en : std_logic := '0';
   signal rst : std_logic := '0';
   signal db_din : std_logic_vector(7 downto 0) := (others => '0');
   signal db_busy : std_logic := '0';

 	--Outputs
   signal num_lsa : std_logic_vector(1 downto 0);
   signal db_rd_en : std_logic;
   signal db_addr : std_logic_vector(11 downto 0);
   signal dout : std_logic_vector(7 downto 0);
   signal rd_val : std_logic;
   signal empty : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
	
	-- Instantiate the Unit Under Test (UUT)
   uut: LSAFetcher PORT MAP (
          clk => clk,
          rd_en => rd_en,
          rst => rst,
          num_lsa => num_lsa,
          db_rd_en => db_rd_en,
          db_addr => db_addr,
          db_din => db_din,
          dout => dout,
          db_busy => db_busy,
          rd_val => rd_val,
          empty => empty
        );
	RAMM : RAMDB PORT MAP(
          clka => clk,
          ena => '1',
          wea => "0",
          addra => db_addr,
          dina => (others => '0'),
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
		
      wait for clk_period*10;
      rst <= '0';
      db_busy <= '0';
      wait for clk_period;
      rd_en <= '1';
      wait for clk_period;
      rd_en <= '0';
      -- insert stimulus here 

      wait for clk_period*100;

      rd_en <= '1';
      wait for clk_period;
      rd_en <= '0';

      wait;
   end process;

END;
