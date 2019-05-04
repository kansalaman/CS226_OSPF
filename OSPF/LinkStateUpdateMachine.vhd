----------------------------------------------------------------------------------
-- Company:      AC/DC
-- Engineer:     Saksham Goel
-- 
-- Create Date:    12:31:18 05/01/2019 
-- Module Name:    LinkStateUpdateMachine - Behavioral 
-- Project Name:   OSPF
-- Description: 
--
-- Dependencies: 
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LinkStateUpdateMachine is
  Generic
  (
    ADDR_SIZE : integer := 12;
    PORTS : integer := 8
  );
  Port
  (
    clk : in std_logic;
    empty : in std_logic;
    q_din : in std_logic_vector(7 downto 0);
    q_read : out std_logic;
    db_read : out std_logic;
    db_addr : out std_logic_vector(ADDR_SIZE-1 downto 0);
    db_din : in std_logic_vector(7 downto 0);
    db_write : out std_logic;
    db_dout : out std_logic_vector(7 downto 0);
    fl_val : out std_logic;
    fl_out : out std_logic_vector(7 downto 0);
    fl_port : out std_logic_vector(7 downto 0);
    dijkstra_on : out std_logic
  );
end LinkStateUpdateMachine;

architecture Behavioral of LinkStateUpdateMachine is
constant zero8 : std_logic_vector(7 downto 0) := (others => '0');
constant zero16 : std_logic_vector(15 downto 0) := (others => '0');
constant zero32 : std_logic_vector(31 downto 0) := (others => '0');
constant zeroA : std_logic_vector(ADDR_SIZE-1 downto 0) := (others => '0');
constant hlen : integer := 18;

type STATES is (IDLE, RECV, DBLEN, MATCH, GET_AD, GET_SEQ, WRITE_DB, UPDATE, DUMP);

signal p_state, n_state : STATES := IDLE;

--COUNTERS
signal p_c1, n_c1 : integer range 0 to 25 := 0;
signal p_c2, n_c2, p_sc, n_sc, p_dumpc, n_dumpc, n_ac, p_ac, p_wc, n_wc: integer := 0;     --COUNTERS

signal n_port, p_port, p_op, n_op : std_logic_vector(7 downto 0) := (others => '0');
signal n_age, p_age, p_links, n_links, p_len, n_len : std_logic_vector(15 downto 0) := (others => '0');
signal p_id, n_id, p_ad, n_ad, p_seqno, n_seqno, p_tSeqno, n_tSeqno, p_tAdno, n_tAdno : std_logic_vector(31 downto 0) := (others => '0');


-- Memory management
signal p_loc, n_loc : std_logic_vector(ADDR_SIZE-1 downto 0) := (others => '0');
signal p_dblen, n_dblen : std_logic_vector(7 downto 0) := (others => '0');
begin

SEQ : process (clk)
begin
  if (clk'event and clk = '1') then
    --State
    p_state <= n_state;

    --Counters
    p_c1 <= n_c1;
    p_c2 <= n_c2;
    p_sc <= n_sc;
    p_dumpc <= n_dumpc;
    p_ac <= n_ac;
    p_wc <= n_wc;

    --LSA Stuff
    p_port <= n_port;
    p_links <= n_links;
    p_age <= n_age;
    p_id <= n_id;
    p_ad <= n_ad;
    p_seqno <= n_seqno;
    p_len <= n_len;
    p_loc <= n_loc;
    p_dblen <= n_dblen;
    p_tSeqno <= n_tSeqno;
    p_tAdno <= n_tAdno;
  end if;
end process SEQ;

COMB : process (p_state, db_din, empty, q_din,
                p_c1, p_c2, p_sc, p_dumpc, p_ac, p_wc,
                p_port, p_links, p_age, p_id, p_ad, p_seqno, p_len, 
                p_loc, p_dblen, p_tSeqno, p_tAdno)
variable seqAddr, adAddr : integer := 0;
begin
  case(p_state) is
    when IDLE =>
    --COUNTERS
      n_c1 <= 0;
      n_c2 <= 0;
      n_sc <= 0;
      n_dumpc <= 0;
      n_ac <= 0;
      n_wc <= 0;
    --LSA Stuff
      n_port <= zero8;
      n_links <= zero16;
      n_age <= zero16;
      n_id <= zero32;
      n_ad <= zero32;
      n_seqno <= zero32;
      n_len <= zero16;
      n_loc <= zeroA;
      n_dblen <= zero8;
      n_tSeqno <= zero32;
      n_tAdno <= zero32;
    --Dijkstra
      dijkstra_on <= '0';

    --READ/WRITE
      db_write <= '0';
      db_read <= '0';
      db_dout <= zero8;
      db_addr <= zeroA;
      fl_val <= '0';
      fl_out <= zero8;
      fl_port <= zero8;

      if (empty = '0') then
        q_read <= '1';
        n_state <= RECV;
      else
        q_read <= '0';
        n_state <= IDLE;
      end if;

    when RECV =>
      --COUNTERS
      n_c2 <= 0;
      n_sc <= 0;
      n_dumpc <= 0;
      n_ac <= 0;
      n_wc <= 0;

      --Dijkstra
      dijkstra_on <= '0';

      n_c1 <= p_c1 + 1;
      case(p_c1) is
        when 0 => 
          n_port <= q_din;
          q_read <= '1';
        when 1 =>
          n_age(15 downto 8) <= q_din;
          q_read <= '1';
        when 2 =>
          n_age(7 downto 0) <= q_din;
          q_read <= '1';
        when 5 =>
          n_id(31 downto 24) <= q_din;
          q_read <= '1';
        when 6 =>
          n_id(23 downto 16) <= q_din;
          q_read <= '1';
        when 7 =>
          n_id(15 downto 8) <= q_din;
          q_read <= '1';
        when 8 =>
          n_id(7 downto 0) <= q_din;
          q_read <= '1';
        when 9 =>
          n_ad(31 downto 24) <= q_din;
          q_read <= '1';
        when 10 =>
          n_ad(23 downto 16) <= q_din;
          q_read <= '1';
        when 11 =>
          n_ad(15 downto 8) <= q_din;
          q_read <= '1';
        when 12 =>
          n_ad(7 downto 0) <= q_din;
          q_read <= '1';
        when 13 =>
          n_seqno(31 downto 24) <= q_din;
          q_read <= '1';
        when 14 =>
          n_seqno(23 downto 16) <= q_din;
          q_read <= '1';
        when 15 =>
          n_seqno(15 downto 8) <= q_din;
          q_read <= '1';
        when 16 =>
          n_seqno(7 downto 0) <= q_din;
          q_read <= '1';
        when 19 =>
          n_len(15 downto 8) <=  q_din;
          q_read <= '1';
        when 20 =>
          n_len(7 downto 0) <=  q_din;
          q_read <= '1';
        when 23 =>
          n_links(15 downto 8) <= q_din;
          q_read <= '1';
        when 24 =>
          n_links(7 downto 0) <= q_din;
          q_read <= '0';
          n_state <= DBLEN;
          db_read <= '1';
          db_addr <= (others => '0');
        when others =>
          null;
      end case;

    when DBLEN =>
      n_dblen <= db_din;
      n_state <= GET_AD;
      n_len <= p_len - "110";
      n_c2 <= 0;
      n_ac <= 0;
      n_sc <= 0;

    when GET_AD =>
      n_ac <= p_ac + 1;
      -- NOT 8 AS OPTIONS AND LS_AGE HAS BEEN REMOVED
      adAddr := p_c2*(hlen + 12*PORTS) + 6;
      case(p_ac) is
        when 0 => 
          db_addr <= std_logic_vector(to_unsigned(adAddr + 1 , ADDR_SIZE));
          db_read <= '1';
          --n_dblen <= db_dout;
          n_state <= GET_AD;
        when 1 =>
          db_addr <= std_logic_vector(to_unsigned(adAddr + 2 , ADDR_SIZE));
          db_read <= '1';
          n_tAdno(31 downto 24) <= db_din;
          n_state <= GET_AD;
        when 2 =>
          db_addr <= std_logic_vector(to_unsigned(adAddr + 3 , ADDR_SIZE));
          db_read <= '1';
          n_tAdno(23 downto 16) <= db_din;
          n_state <= GET_AD;
        when 3 =>
          db_addr <= std_logic_vector(to_unsigned(adAddr + 4 , ADDR_SIZE));
          db_read <= '1';
          n_tAdno(15 downto 8) <= db_din;
          n_state <= GET_AD;
        when 4 =>
          db_read <= '0';
          n_tAdno(7 downto 0) <= db_din;
          n_state <= MATCH;
          n_ac <= 0;
        when others =>
          null;
      end case;

    when MATCH =>
      n_c2 <= p_c2 + 1;
      if (p_c2 = to_integer(unsigned(p_dblen))) then
        db_addr <= zeroA;
        db_dout <= p_dblen + "1";
        db_write <= '1';
        n_loc <= std_logic_vector(to_unsigned(p_c2*(hlen + 12*PORTS) + 1, ADDR_SIZE));
        n_wc <= 0;
        n_state <= WRITE_DB;
      elsif (p_tAdno = p_ad) then
        n_loc <= std_logic_vector(to_unsigned(p_c2*(hlen + 12*PORTS) + 12, ADDR_SIZE));
        n_state <= GET_SEQ;
        n_sc <= 0;
      else
        n_state <= GET_AD;
        n_ac <= 0;
      end if;

    when GET_SEQ =>
      n_sc <= p_sc + 1;
      --seqAddr := p_c2*(hlen + 8*PORTS) + 12;
      case(p_sc) is
        when 0 => 
          db_addr <= p_loc + "1";
          db_read <= '1';
          --n_dblen <= db_dout;
          n_state <= GET_SEQ;
        when 1 =>
          db_addr <= p_loc + "10";
          db_read <= '1';
          n_tSeqno(31 downto 24) <= db_din;
          n_state <= GET_SEQ;
        when 2 =>
          db_addr <= p_loc + "11";
          db_read <= '1';
          n_tSeqno(23 downto 16) <= db_din;
          n_state <= GET_SEQ;
        when 3 =>
          db_addr <= p_loc + "100";
          db_read <= '1';
          n_tSeqno(15 downto 8) <= db_din;
          n_state <= GET_SEQ;
        when 4 =>
          db_read <= '0';
          n_tSeqno(7 downto 0) <= db_din;
          n_state <= UPDATE;
          n_sc <= 0;
        when others =>
          null;
      end case;

    when UPDATE =>
      if (p_seqno > p_tSeqno) then
        n_loc <= p_loc - "1011";      --Subtracting the SeqNo. offset 12 + 1
        n_state <= WRITE_DB;
        n_wc <= 0;
      else
        n_state <= DUMP;
        n_dumpc <= 0;
      end if;

    when WRITE_DB =>
      n_wc <= p_wc + 1;
      n_loc <= p_loc + "1";
      fl_port <= p_port;
      db_addr <= p_loc;

      if (p_wc < to_integer(unsigned(p_len))) then
        db_write <= '1';
        fl_val <= '1';
        n_state <= WRITE_DB;
        dijkstra_on <= '0';
      else
        db_write <= '0';
        n_state <= IDLE;
        if (empty = '1') then
          dijkstra_on <= '1';
        else
          dijkstra_on <= '0';
        end if;
      end if;

      if (p_wc < to_integer(unsigned(p_len)) - 1 and p_wc > 16) then
        q_read <= '1';
      else
        q_read <= '0';
      end if;

      case(p_wc) is
        when 0 =>
          db_dout <= p_age(15 downto 8);
          fl_out <= p_age(15 downto 8);
          --db_write <= '1';
        when 1 =>
          db_dout <= p_age(7 downto 0);
          fl_out <= p_age(7 downto 0);
          --db_write <= '1';
        when 2 =>
          db_dout <= p_id(31 downto 24);
          fl_out <= p_id(31 downto 24);
          --db_write <= '1';
        when 3 =>
          db_dout <= p_id(23 downto 16);
          fl_out <= p_id(23 downto 16);
          --db_write <= '1';
        when 4 =>
          db_dout <= p_id(15 downto 8);
          fl_out <= p_id(15 downto 8);
          --db_write <= '1';
        when 5 =>
          db_dout <= p_id(7 downto 0);
          fl_out <= p_id(7 downto 0);
          --db_write <= '1';
        when 6 =>
          db_dout <= p_ad(31 downto 24);
          fl_out <= p_ad(31 downto 24);
          --db_write <= '1';
        when 7 =>
          db_dout <= p_ad(23 downto 16);
          fl_out <= p_ad(23 downto 16);
          --db_write <= '1';
        when 8 =>
          db_dout <= p_ad(15 downto 8);
          fl_out <= p_ad(15 downto 8);
          --db_write <= '1';
        when 9 =>
          db_dout <= p_ad(7 downto 0);
          fl_out <= p_ad(7 downto 0);
          --db_write <= '1';
        when 10 =>
          db_dout <= p_seqno(31 downto 24);
          fl_out <= p_seqno(31 downto 24);
          --db_write <= '1';
        when 11 =>
          db_dout <= p_seqno(23 downto 16);
          fl_out <= p_seqno(23 downto 16);
          --db_write <= '1';
        when 12 =>
          db_dout <= p_seqno(15 downto 8);
          fl_out <= p_seqno(15 downto 8);
          --db_write <= '1';
        when 13 =>
          db_dout <= p_seqno(7 downto 0);
          fl_out <= p_seqno(7 downto 0);
          --db_write <= '1';
        when 14 =>
          db_dout <= p_len(15 downto 8);
          fl_out <= p_len(15 downto 8);
          --db_write <= '1';
        when 15 =>
          db_dout <= p_len(7 downto 0);
          fl_out <= p_len(7 downto 0);
          --db_write <= '1';
        when 16 =>
          db_dout <= p_links(15 downto 8);
          fl_out <= p_links(15 downto 8);
          --db_write <= '1';
        when 17 =>
          db_dout <= p_links(7 downto 0);
          fl_out <= p_links(7 downto 0);
          --db_write <= '1';
        when others =>
          db_dout <= q_din;
          fl_out <= q_din;
      end case;
    when DUMP =>
      n_dumpc <= p_dumpc + 1;
      if (p_dumpc = to_integer(unsigned(p_len)) - 18) then
        q_read <= '0';
        n_state <= IDLE;
        n_len <= (others => '0');
        n_dumpc <= 0;
        n_c1 <= 0;
      else
        q_read <= '1';
        n_state <= DUMP;
      end if;
  end case;
end process COMB;
end Behavioral;