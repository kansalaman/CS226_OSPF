--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   04:19:17 05/05/2019
-- Design Name:   
-- Module Name:   /home/aman/Desktop/IITB/CS226/project_ospf/CS226_OSPF/OSPF/lsrgen_tb.vhd
-- Project Name:  OSPF
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: LSRgen
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
 
ENTITY lsrgen_tb IS
END lsrgen_tb;
 
ARCHITECTURE behavior OF lsrgen_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LSRgen
    PORT(
         clk : IN  std_logic;
         wr_en : IN  std_logic;
         din : IN  std_logic_vector(7 downto 0);
         dout : OUT  std_logic_vector(7 downto 0);
         out_val : OUT  std_logic;
         done_sending : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal wr_en : std_logic := '0';
   signal din : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal dout : std_logic_vector(7 downto 0);
   signal out_val : std_logic;
   signal done_sending : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LSRgen PORT MAP (
          clk => clk,
          wr_en => wr_en,
          din => din,
          dout => dout,
          out_val => out_val,
          done_sending => done_sending
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
		wr_en <= '1';
		din <= "00000001";
      wait for clk_period;
      din <= "00000010";
      wait for clk_period;
      din <= "00000011";
      wait for clk_period;
      din <= "00000100";
      wait for clk_period;
      din <= "00000101";
      wait for clk_period;
      din <= "00000110";
      wait for clk_period;
      din <= "00000111";
      wait for clk_period;
      din <= "00001000";
      wait for clk_period;
      din <= "00001001";
      wait for clk_period;
      din <= "00001010";
      wait for clk_period;
      din <= "00001011";
      wait for clk_period;
      din <= "00001100";
      wait for clk_period;
      din <= "00001101";
      wait for clk_period;
      din <= "00001110";
      wait for clk_period;
      din <= "00001111";
      wait for clk_period;
      din <= "00010000";
      wait for clk_period;
      din <= "00010001";
      wait for clk_period;
      din <= "00010010";
      wait for clk_period;
      din <= "00010011";
      wait for clk_period;
      din <= "00010100";
      wait for clk_period;
      
      din <= "00000001";
      wait for clk_period;
      din <= "00000010";
      wait for clk_period;
      din <= "00000011";
      wait for clk_period;
      din <= "00000100";
      wait for clk_period;
      din <= "00000101";
      wait for clk_period;
      din <= "00000110";
      wait for clk_period;
      din <= "00000111";
      wait for clk_period;
      din <= "00001000";
      wait for clk_period;
      din <= "00001001";
      wait for clk_period;
      din <= "00001010";
      wait for clk_period;
      din <= "00001011";
      wait for clk_period;
      din <= "00001100";
      wait for clk_period;
      din <= "00001101";
      wait for clk_period;
      din <= "00001110";
      wait for clk_period;
      din <= "00001111";
      wait for clk_period;
      din <= "00010000";
      wait for clk_period;
      din <= "00010001";
      wait for clk_period;
      din <= "00010010";
      wait for clk_period;
      din <= "00010011";
      wait for clk_period;
      din <= "00010100";
      wait for clk_period;
      wr_en <= '0';
      wait for clk_period*5;
      -- insert stimulus here 

      wait;
   end process;

END;
