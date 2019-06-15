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
         dbd_outval : OUT  std_logic;
         dbd_rd_en : OUT  std_logic;
         dbd_rst : OUT  std_logic;
         numLSA : IN  std_logic_vector(1 downto 0);
         dbd_out : IN  std_logic_vector(7 downto 0);
         dbd_valid : IN  std_logic;
         dbd_empty : IN  std_logic;
         lsa_queue_wr_en : OUT  std_logic;
         lsa_queue_dout : OUT  std_logic_vector(7 downto 0);
         loading_done : in STD_LOGIC
        );
    END COMPONENT;
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
    END COMPONENT;

    component LSRgen is
    Generic
    (
        router_id : std_logic_vector(31 downto 0) := "11110011000000000000000000000000"
    );
    Port ( clk : in  STD_LOGIC;
           wr_en : in  STD_LOGIC;
           --rst : in STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (7 downto 0);
        --    rd_en : in  STD_LOGIC;
           dout : out  STD_LOGIC_VECTOR (7 downto 0);
           out_val : out std_logic;
           done_sending : out  STD_LOGIC);
    end component;

   --Inputs
   signal clk : std_logic := '0';
   signal neighbor_val : std_logic := '0';
   signal self : std_logic_vector(31 downto 0) := "00000100000001010000011000000111";
   signal routerid_val : std_logic := '0';
   signal dbd_val : std_logic := '0';
   signal in1 : std_logic_vector(7 downto 0) := (others => '0');
   signal hellogenin : std_logic := '0';
   signal numLSA : std_logic_vector(1 downto 0) := (others => '0');
   signal dbd_out : std_logic_vector(7 downto 0) := (others => '0');
   signal dbd_valid : std_logic := '0';
   signal dbd_empty : std_logic := '0';
   signal lsa_queue_din : std_logic_vector(7 downto 0) := (others => '0');
 	--Outputs
   signal stateout : std_logic_vector(2 downto 0);
   signal router_id : std_logic_vector(31 downto 0);
   signal dbd_out1 : std_logic_vector(7 downto 0);
   signal dbd_outval : std_logic;
   signal lsr_outval : std_logic;
   signal dbd_rd_en : std_logic;
   signal dbd_rst : std_logic;
   signal lsa_queue_wr_en : std_logic;
   signal lsa_queue_dout : std_logic_vector(7 downto 0);
   --EXTRAS
   signal db_addr : STD_LOGIC_VECTOR(11 downto 0);
   signal db_din : STD_LOGIC_VECTOR(7 downto 0);
   signal db_busy : STD_LOGIC := '0';
   signal db_rd_en : STD_LOGIC;
   signal loading_done : STD_LOGIC;
   signal lsr_out : STD_LOGIC_VECTOR(7 downto 0);
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
          out1 => dbd_out1,
          dbd_outval => dbd_outval,
          dbd_rd_en => dbd_rd_en,
          dbd_rst => dbd_rst,
          numLSA => numLSA,
          dbd_out => dbd_out,
          dbd_valid => dbd_valid,
          dbd_empty => dbd_empty,
          lsa_queue_wr_en => lsa_queue_wr_en,
          lsa_queue_dout => lsa_queue_dout,
          loading_done => loading_done
        );
   ram : RAMDB PORT MAP(
          clka => clk,
          ena => '1',
          wea => "0",
          addra => db_addr,
          dina => (others => '0'),
          douta => db_din
     );
   lsr_gen : LSRgen
        GENERIC MAP (
          router_id => self)
        PORT MAP (
          clk => clk,
          wr_en => lsa_queue_wr_en,
          din => lsa_queue_dout,
          dout => lsr_out,
          out_val => lsr_outval,
          done_sending => loading_done

          );
   fetcher : LSAFetcher PORT MAP(
          clk => clk,
          rd_en => dbd_rd_en,
          rst => dbd_rst,
          num_lsa => numLSA,
          db_rd_en => db_rd_en,
          db_addr => db_addr,
          db_din => db_din,
          dout => dbd_out,
          db_busy => db_busy,
          rd_val => dbd_valid,
          empty => dbd_empty
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
      wait for clk_period*5;
      hellogenin <= '0';
      wait for clk_period;
      routerid_val <= '1';
      in1 <= "00000001";
      wait for clk_period;
		in1 <= "00000100";
      wait for clk_period;
		in1 <= "00000101";
      wait for clk_period;
		in1 <= "00001100";
      wait for clk_period;
      routerid_val <= '0';
      in1 <= (others => '0');
      wait for clk_period*20;
        -- insert stimulus here 
        for i in 0 to 15 loop
            wait for clk_period;
            neighbor_val <= '1';
               in1 <= conv_std_logic_vector(i, 8);
        end loop;
      wait for clk_period;
      neighbor_val <= '0';
      in1 <= (others => '0');
      wait for clk_period*100;
      -- insert stimulus here 
      dbd_val <= '1';
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000111";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "11000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      dbd_val <= '0';
      in1 <= (others => '0');
		wait for clk_period*200;
		dbd_val <= '1';
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "11111111";
      wait for clk_period;
      in1 <= "11111111";
      wait for clk_period;
      dbd_val <= '0';
		wait for clk_period*300;
		dbd_val <= '1';
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000001";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      dbd_val <= '0';
		wait for clk_period*300;
    dbd_val <= '1';
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000001";
      wait for clk_period;
      in1 <= "00000000";
      wait for clk_period;
      in1 <= "00000001";
      wait for clk_period;
      dbd_val <= '0';
      wait;
   end process;

END;
