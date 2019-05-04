--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:45:51 05/04/2019
-- Design Name:   
-- Module Name:   /home/yash20/isefiles/CS226_OSPF/OSPF/helloActParseTb.vhd
-- Project Name:  OSPF
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: helloActParse
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY helloActParseTb IS
END helloActParseTb;
 
ARCHITECTURE behavior OF helloActParseTb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT helloActParse
    PORT(
         clk : IN  std_logic;
         neighbor_val : IN  std_logic;
         self : IN  std_logic_vector(31 downto 0);
         routerid_val : IN  std_logic;
         dbd_val : IN  std_logic;
         in1 : IN  std_logic_vector(7 downto 0);
         hellogenin : IN  std_logic;
         stateout : OUT  std_logic_vector(2 downto 0);
         router_id : OUT  std_logic_vector(31 downto 0);
         out1 : OUT  std_logic_vector(7 downto 0);
         outval : OUT  std_logic;
         dbd_rd_en : OUT  std_logic;
         dbd_rst : OUT  std_logic;
         numLSA : IN  std_logic_vector(1 downto 0);
         dbd_out : IN  std_logic_vector(7 downto 0);
         dbd_valid : IN  std_logic;
         dbd_empty : IN  std_logic;
         lsa_queue_wr_en : OUT  std_logic;
         lsa_queue_dout : OUT  std_logic_vector(7 downto 0);
         lsa_queue_rd_en : OUT  std_logic;
         lsa_queue_din : IN  std_logic_vector(7 downto 0);
         lsa_queue_empty : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal neighbor_val : std_logic := '0';
   signal self : std_logic_vector(31 downto 0) := (others => '0');
   signal routerid_val : std_logic := '0';
   signal dbd_val : std_logic := '0';
   signal in1 : std_logic_vector(7 downto 0) := (others => '0');
   signal hellogenin : std_logic := '0';
   signal numLSA : std_logic_vector(1 downto 0) := (others => '0');
   signal dbd_out : std_logic_vector(7 downto 0) := (others => '0');
   signal dbd_valid : std_logic := '0';
   signal dbd_empty : std_logic := '0';
   signal lsa_queue_din : std_logic_vector(7 downto 0) := (others => '0');
   signal lsa_queue_empty : std_logic := '0';

 	--Outputs
   signal stateout : std_logic_vector(2 downto 0);
   signal router_id : std_logic_vector(31 downto 0);
   signal out1 : std_logic_vector(7 downto 0);
   signal outval : std_logic;
   signal dbd_rd_en : std_logic;
   signal dbd_rst : std_logic;
   signal lsa_queue_wr_en : std_logic;
   signal lsa_queue_dout : std_logic_vector(7 downto 0);
   signal lsa_queue_rd_en : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: helloActParse PORT MAP (
          clk => clk,
          neighbor_val => neighbor_val,
          self => self,
          routerid_val => routerid_val,
          dbd_val => dbd_val,
          in1 => in1,
          hellogenin => hellogenin,
          stateout => stateout,
          router_id => router_id,
          out1 => out1,
          outval => outval,
          dbd_rd_en => dbd_rd_en,
          dbd_rst => dbd_rst,
          numLSA => numLSA,
          dbd_out => dbd_out,
          dbd_valid => dbd_valid,
          dbd_empty => dbd_empty,
          lsa_queue_wr_en => lsa_queue_wr_en,
          lsa_queue_dout => lsa_queue_dout,
          lsa_queue_rd_en => lsa_queue_rd_en,
          lsa_queue_din => lsa_queue_din,
          lsa_queue_empty => lsa_queue_empty
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
