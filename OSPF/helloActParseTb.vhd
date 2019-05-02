--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:38:14 04/30/2019
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
         self : IN  std_logic_vector(31 downto 0);
         routerid_val : IN  std_logic;
         in1 : IN  std_logic_vector(7 downto 0);
         hellogenin : IN  std_logic;
         stateout : OUT  std_logic_vector(1 downto 0);
         router_id : OUT  std_logic_vector(31 downto 0);
         in_val : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal self : std_logic_vector(31 downto 0) := "00000100000001010000011000000111";
   signal routerid_val : std_logic := '0';
   signal in1 : std_logic_vector(7 downto 0) := (others => '0');
   signal hellogenin : std_logic := '0';
   signal in_val : std_logic := '0';

    --Outputs
   signal stateout : std_logic_vector(1 downto 0);
   signal router_id : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: helloActParse PORT MAP (
          clk => clk,
          self => self,
          routerid_val => routerid_val,
          in1 => in1,
          hellogenin => hellogenin,
          stateout => stateout,
          router_id => router_id,
          in_val => in_val
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
        hellogenin <= '1';
      wait for clk_period;
      hellogenin <= '0';
      wait for clk_period;
      routerid_val <= '1';
      in1 <= "00001111";
      wait for clk_period*4;
      routerid_val <= '0';
		in1 <= (others => '0');
		wait for clk_period*20;
      -- insert stimulus here 
      for i in 0 to 15 loop
          wait for clk_period;
          in_val <= '1';
             in1 <= conv_std_logic_vector(i, 8);
      end loop;
		wait for clk_period;
		in_val <= '0';
		in1 <= (others => '0');
      wait for clk_period*1100;
      -- insert stimulus here 

      wait;
   end process;

END;
