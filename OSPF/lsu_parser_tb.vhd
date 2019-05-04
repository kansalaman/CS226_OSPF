--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:10:02 05/03/2019
-- Design Name:   
-- Module Name:   /home/aman/Desktop/IITB/CS226/project_ospf/CS226_OSPF/OSPF/lsu_parser_tb.vhd
-- Project Name:  OSPF
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LSU_Parser
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
 
ENTITY lsu_parser_tb IS
END lsu_parser_tb;
 
ARCHITECTURE behavior OF lsu_parser_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LSU_Parser
    PORT(
         state_in : IN  std_logic_vector(3 downto 0);
         data_in : IN  std_logic_vector(7 downto 0);
         data_valid : IN  std_logic;
         clk : IN  std_logic;
         write_to_q : OUT  std_logic;
         qout : OUT  std_logic_vector(7 downto 0);
         ack_q_out : OUT  std_logic_vector(7 downto 0);
         ack_q_val : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal state_in : std_logic_vector(3 downto 0) := (others => '0');
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal data_valid : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal write_to_q : std_logic;
   signal qout : std_logic_vector(7 downto 0);
   signal ack_q_out : std_logic_vector(7 downto 0);
   signal ack_q_val : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LSU_Parser PORT MAP (
          state_in => state_in,
          data_in => data_in,
          data_valid => data_valid,
          clk => clk,
          write_to_q => write_to_q,
          qout => qout,
          ack_q_out => ack_q_out,
          ack_q_val => ack_q_val
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
	  data_valid <= '1';
	  state_in <= "0110";
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  --enter packet length here
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "01000000";
	  wait for clk_period;
	  --packet length done
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  --enter no. of advertisements here
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000001";
	  wait for clk_period;
	  --end no. of advertisements here
	  data_in <= "11000011";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00000000";
	  wait for clk_period;
	  --enter LS packet length here
	  data_in <= "00000000";
	  wait for clk_period;
	  data_in <= "00100100";
	  wait for clk_period;
	  --stop packet length here
	  data_in <= "11111111";
	  wait for clk_period;
	  data_in <= "11111111";
	  wait for clk_period;
	  data_in <= "11111111";
	  wait for clk_period;
	  data_in <= "11111111";
	  wait for clk_period;
	  data_in <= "11111111";
	  wait for clk_period;
	  data_in <= "11111111";
	  wait for clk_period;
	  data_in <= "11111111";
	  wait for clk_period;
	  data_in <= "11111111";
	  wait for clk_period;
	  data_in <= "11111111";
	  wait for clk_period;
	  data_in <= "11111111";
	  wait for clk_period;
	  data_in <= "11111111";
	  wait for clk_period;
	  data_in <= "11111111";
	  wait for clk_period;
	  data_in <= "11111111";
	  wait for clk_period;
	  data_in <= "11111111";
	  wait for clk_period;
	  data_in <= "11111111";
	  wait for clk_period;
	  data_in <= "11000011";
	  wait for clk_period;
	  data_valid <= '0';

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
