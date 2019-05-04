--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:19:00 05/04/2019
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
         clk =>  ,
         neighbor_val =>  ,
         self =>  ,
         routerid_val =>  ,
         dbd_val =>  ,
         in1 =>  ,
         hellogenin =>  ,
         stateout =>  ,
         router_id =>  ,
         out1 =>  ,
         dbd_outval =>  ,
         lsr_outval =>  ,
         dbd_rd_en =>  ,
         dbd_rst =>  ,
         numLSA =>  ,
         dbd_out =>  ,
         dbd_valid =>  ,
         dbd_empty =>  ,
         lsa_queue_wr_en =>  ,
         lsa_queue_dout =>  ,
         lsa_queue_rd_en =>  ,
         lsa_queue_din =>  ,
         lsa_queue_val =>  ,
         lsa_queue_empty : IN  std_logic
        );
    END COMPONENT;
    COMPONENT LSAFetcher
    PORT(
         clk =>  ,
         rd_en =>  ,
         rst =>  ,
         num_lsa =>  ,
         db_rd_en =>  ,
         db_addr =>  ,
         db_din =>  ,
         dout =>  ,
         db_busy =>  ,
         rd_val =>  ,
         empty : OUT std_logic
        );
    END COMPONENT;

    COMPONENT RAMDB
    PORT (
     clka =>  ,
     ena =>  ,
     wea =>  ,
     addra =>  ,
     dina =>  ,
     douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
   END component;
   COMPONENT FIFOLSU IS
    PORT (
      clk =>  ,
      rst =>  ,
      din =>  ,
      wr_en =>  ,
      rd_en =>  ,
      dout =>  ,
      full =>  ,
      empty =>  ,
      data_count : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
    );
   END COMPONENT;
    

   --Inputs
   signal clk =>  ,
   signal neighbor_val =>  ,
   signal self : std_logic_vector(31 downto 0) := (others => '0');
   signal routerid_val =>  ,
   signal dbd_val =>  ,
   signal in1 : std_logic_vector(7 downto 0) := (others => '0');
   signal hellogenin =>  ,
   signal numLSA : std_logic_vector(1 downto 0) := (others => '0');
   signal dbd_out : std_logic_vector(7 downto 0) := (others => '0');
   signal dbd_valid =>  ,
   signal dbd_empty =>  ,
   signal lsa_queue_din : std_logic_vector(7 downto 0) := (others => '0');
   signal lsa_queue_val =>  ,
   signal lsa_queue_empty =>  ,

 	--Outputs
   signal stateout : std_logic_vector(2 downto 0);
   signal router_id : std_logic_vector(31 downto 0);
   signal out1 : std_logic_vector(7 downto 0);
   signal dbd_outval : std_logic;
   signal lsr_outval : std_logic;
   signal dbd_rd_en : std_logic;
   signal dbd_rst : std_logic;
   signal lsa_queue_wr_en : std_logic;
   signal lsa_queue_dout : std_logic_vector(7 downto 0);
   signal lsa_queue_rd_en : std_logic;


   --EXTRAS
   signal db_addr : STD_LOGIC_VECTOR(11 downto 0);
   signal db_din : STD_LOGIC_VECTOR(7 downto 0);

   -- Clock period definitions
   constant clk_period =>  ,
 
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
          dbd_outval => dbd_outval,
          lsr_outval => lsr_outval,
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
          lsa_queue_val => lsa_queue_val,
          lsa_queue_empty => lsa_queue_empty
        );
   ram : RAMDB PORT MAP(
          clka => clk,
          ena => '1',
          wea => "0",
          addra => db_addr,
          dina => (others => '0'),
          douta => db_din
     );
   queue : FIFOLSU PORT MAP(
          clk =>  ,
          rst =>  ,
          din =>  ,
          wr_en =>  ,
          rd_en =>  ,
          dout =>  ,
          full =>  ,
          empty =>  ,
          data_count => 
    );
   fetcher : LSAFetcher PORT MAP(
          clk =>  ,
          rd_en =>  ,
          rst =>  ,
          num_lsa =>  ,
          db_rd_en =>  ,
          db_addr =>  ,
          db_din =>  ,
          dout =>  ,
          db_busy =>  ,
          rd_val =>  ,
          empty : => 
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
