----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:23:55 05/04/2019 
-- Design Name: 
-- Module Name:    NeighborMachine - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NeighborMachine is
    Generic (
        self : std_logic_vector(31 downto 0) := "10101010101010101010101010101010"
        );
    PORT (
        clk : IN STD_LOGIC;
        neighbor_val : IN std_logic;
        routerid_val : IN std_logic;
        dbd_val : IN std_logic;
        in1 : IN std_logic_vector(7 downto 0);
        hellogenin : IN std_logic;
        stateout : OUT std_logic_vector(2 downto 0);
        router_id : OUT std_logic_vector(31 downto 0);
        out1 : OUT std_logic_vector(7 downto 0);
        dbd_outval : OUT std_logic;
        lsr_outval : OUT std_logic;
        db_rd_en : OUT std_logic;
        db_addr : OUT std_logic_vector(11 downto 0);
        db_din : IN std_logic_vector(7 downto 0);
        db_busy : IN std_logic
        );
end NeighborMachine;

architecture Behavioral of NeighborMachine is
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
         loading_done : IN STD_LOGIC
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

   signal dbd_rd_en : std_logic;
   signal dbd_rst : std_logic;
   signal numLSA : std_logic_vector(1 downto 0);
   signal dbd_out : std_logic_vector(7 downto 0);
   signal dbd_valid : std_logic;
   signal dbd_empty : std_logic;
   signal lsa_queue_wr_en : std_logic;
   signal lsa_queue_dout : std_logic_vector(7 downto 0);
   signal loading_done : std_logic;
   signal dbd_out1 : STD_LOGIC_VECTOR(7 downto 0);
   signal lsr_out : STD_LOGIC_VECTOR(7 downto 0);
   signal dbd_outval_sig : STD_LOGIC;
   signal lsr_outval_sig : STD_LOGIC;

begin
    hello_act_parse : helloActParse PORT MAP(
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
                    dbd_outval => dbd_outval_sig,
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
    lsr_gen : LSRgen
        GENERIC MAP (
          router_id => self)
        PORT MAP (
          clk => clk,
          wr_en => lsa_queue_wr_en,
          din => lsa_queue_dout,
          dout => lsr_out,
          out_val => lsr_outval_sig,
          done_sending => loading_done

          );
    out1 <= dbd_out1 when (dbd_outval_sig = '1') else
            lsr_out when (lsr_outval_sig = '1') else
            (others => '0');
    dbd_outval <= dbd_outval_sig;
    lsr_outval <= lsr_outval_sig;

end Behavioral;

