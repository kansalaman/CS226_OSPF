--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:27:33 05/04/2019
-- Design Name:   
-- Module Name:   /home/aman/Desktop/IITB/CS226/project_ospf/CS226_OSPF/OSPF/iface_out_tb.vhd
-- Project Name:  OSPF
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: interfaceOut
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
 
ENTITY iface_out_tb IS
END iface_out_tb;
 
ARCHITECTURE behavior OF iface_out_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT interfaceOut
    PORT(
         clk : IN  std_logic;
         qin1 : IN  std_logic_vector(7 downto 0);
         qin2 : IN  std_logic_vector(7 downto 0);
         readq1 : OUT  std_logic;
         readq2 : OUT  std_logic;
         empq1 : IN  std_logic;
         empq2 : IN  std_logic;
         dout : OUT  std_logic_vector(7 downto 0);
         dout_val : OUT  std_logic
        );
    END COMPONENT;
	 
	 COMPONENT FIFOACK
	  PORT (
		 clk : IN STD_LOGIC;
		 srst : IN STD_LOGIC;
		 din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 wr_en : IN STD_LOGIC;
		 rd_en : IN STD_LOGIC;
		 dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 full : OUT STD_LOGIC;
		 empty : OUT STD_LOGIC;
		 data_count : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	  );
	END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal qin1 : std_logic_vector(7 downto 0) := (others => '0');
   signal qin2 : std_logic_vector(7 downto 0) := (others => '0');
   signal empq1 : std_logic := '0';
   signal empq2 : std_logic := '0';

 	--Outputs
   signal readq1 : std_logic;
   signal readq2 : std_logic;
   signal dout : std_logic_vector(7 downto 0);
   signal dout_val : std_logic;
	--signal dcount : std_logic_vector(10 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	signal srst1,srst2,wr_en1,wr_en2 : std_logic;
	signal din1,din2,dout1,dout2 : std_logic_vector(7 downto 0);
	signal full1,full2 : std_logic;
	signal dc1,dc2 : std_logic_vector(10 downto 0);
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: interfaceOut PORT MAP (
          clk => clk,
          qin1 => dout1,
          qin2 => dout2,
          readq1 => readq1,
          readq2 => readq2,
          empq1 => empq1,
          empq2 => empq2,
          dout => dout,
          dout_val => dout_val
        );
	fifo1 : FIFOACK PORT MAP (
		 clk => clk,
		 srst => srst1,
		 din => din1,
		 wr_en => wr_en1,
		 rd_en => readq1,
		 dout => dout1,
		 full => full1,
		 empty => empq1,
		 data_count => dc1);
	fifo2 : FIFOACK PORT MAP (
		 clk => clk,
		 srst => srst2,
		 din => din2,
		 wr_en => wr_en2,
		 rd_en => readq2,
		 dout => dout2,
		 full => full2,
		 empty => empq2,
		 data_count => dc2);
			
			 
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
		wr_en2 <= '1';
		din2 <= "10000111";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "01011100";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000000";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000001";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00001010";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000000";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000000";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000101";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00001010";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000000";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000000";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000101";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000000";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000000";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000000";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000001";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000000";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000000";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000000";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00011000";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000000";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000000";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000000";
		wait for clk_period;
		wr_en2 <= '1';
		din2 <= "00000001";
		wait for clk_period;
		wr_en2 <= '0';
		wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
