--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:46:58 05/04/2019
-- Design Name:   
-- Module Name:   /home/ansh/Desktop/Academics/Semester 4/CS 226/Project/CS226_OSPF/OSPF/lsraction_tb.vhd
-- Project Name:  OSPF
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: lsraction
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
 
ENTITY lsraction_tb IS
END lsraction_tb;
 
ARCHITECTURE behavior OF lsraction_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT lsraction
    PORT(
         clk : IN  std_logic;
         len : IN  std_logic_vector(15 downto 0);
         len_val : IN  std_logic;
         in1 : IN  std_logic_vector(7 downto 0);
         data_val : IN  std_logic;
         out1 : INOUT  std_logic_vector(7 downto 0);
         badreq : OUT  std_logic;
         out_val : OUT  std_logic;
         db_read : OUT  std_logic;
         db_addr : OUT  std_logic_vector(11 downto 0);
         db_din : IN  std_logic_vector(7 downto 0);
         db_write : OUT  std_logic;
         db_dout : OUT  std_logic_vector(7 downto 0);
         db_busy_read : IN  std_logic;
         db_busy_write : IN  std_logic
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
   signal clk : std_logic := '0';
   signal len : std_logic_vector(15 downto 0) := (others => '0');
   signal len_val : std_logic := '0';
   signal in1 : std_logic_vector(7 downto 0) := (others => '0');
   signal data_val : std_logic := '0';
   signal db_din : std_logic_vector(7 downto 0) := (others => '0');
   signal db_busy_read : std_logic := '0';
   signal db_busy_write : std_logic := '0';

	--BiDirs
   signal out1 : std_logic_vector(7 downto 0);

 	--Outputs
   signal badreq : std_logic;
   signal out_val : std_logic;
   signal db_read : std_logic;
   signal db_addr : std_logic_vector(11 downto 0);
   signal db_write : std_logic;
   signal db_dout : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: lsraction PORT MAP (
          clk => clk,
          len => len,
          len_val => len_val,
          in1 => in1,
          data_val => data_val,
          out1 => out1,
          badreq => badreq,
          out_val => out_val,
          db_read => db_read,
          db_addr => db_addr,
          db_din => db_din,
          db_write => db_write,
          db_dout => db_dout,
          db_busy_read => db_busy_read,
          db_busy_write => db_busy_write
        );


  comp: RAMDB PORT MAP (
	 clka => clk, 
    ena => '1',
    wea => "0",
    addra => db_addr,
    dina => db_dout,
    douta => db_din);
	 
	 
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
      len_val <='1';
		len <= "00000000" & "00100100";
		wait for clk_period;
		len_val <='0';
		len <= "00000000" & "00000000";
		wait for 3* clk_period;
		data_val <= '1';
		in1 <= "00000000";
		wait for clk_period;
		data_val <= '0';
		wait for clk_period*7;
		in1 <= "00000001";
		wait for clk_period * 4;
		in1 <= "00000000";
      -- insert stimulus here
      wait;
   end process;

END;
