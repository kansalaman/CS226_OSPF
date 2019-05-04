--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY tb_helloalive IS
END tb_helloalive;
 
ARCHITECTURE behavior OF tb_helloalive IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT helloalive
    PORT(
         out1 : OUT  std_logic_vector(7 downto 0);
--         on1 : IN  std_logic;
--         networkmask : IN  std_logic_vector(31 downto 0);
--         ospfhelloheader : IN  std_logic_vector(191 downto 0);
--         IPheader : IN  std_logic_vector(159 downto 0);
         neighbor : IN  std_logic_vector(31 downto 0);
         clk : IN  std_logic;
         val : OUT  std_logic;
         reply_signal : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
--   signal on1 : std_logic := '1';
--   signal networkmask : std_logic_vector(31 downto 0) := "10101010101010101010101010101010";
--   signal ospfhelloheader : std_logic_vector(191 downto 0) := "000000100000000100000000001011001100000010101000000000100000000100000000000000000000000000000000001010011001000100000000000000000000000000000000000000000000000000000000000000000000000000000000";
--   signal IPheader : std_logic_vector(159 downto 0) := "1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111";
   signal clk : std_logic := '0';
   signal reply_signal : std_logic := '0';

	--BiDirs
   signal neighbor : std_logic_vector(31 downto 0) := "10101010101010101010101010101010";

 	--Outputs
   signal out1 : std_logic_vector(7 downto 0);
   signal val : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: helloalive PORT MAP (
          out1 => out1,
--          on1 => on1,
--          networkmask => networkmask,
--          ospfhelloheader => ospfhelloheader,
--          IPheader => IPheader,
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
--		on1 <= '1';
--      IPheader <= ;
--		ospfhelloheader <= ";	
--		networkmask <= ;
--		neighbor <= ;
      wait for clk_period*120;

      -- insert stimulus here 

      wait;
   end process;

END;
