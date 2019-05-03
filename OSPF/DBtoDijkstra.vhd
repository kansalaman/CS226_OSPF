----------------------------------------------------------------------------------
-- Company: AC/DC
-- Engineer: Saksham Goel
-- 
-- Create Date:    20:15:21 04/26/2019 
-- Module Name:    DbtoDijkstra
-- Project Name:   OSPF
-- Description: 
--
-- Dependencies: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DBtoDijkstra is
  Generic
  (
    DB_ADDR_SIZE : integer := 12;
    ADDR_SIZE : integer := 6;
    NETWORK_SIZE : integer := 6;
    COST_SIZE : integer := 6;
    ROUTERID_SIZE : integer := 5;
    PORTS : integer := 8
  );
	Port
	(
    clk : in STD_LOGIC;
		write : out STD_LOGIC := '0';
    addr : out STD_LOGIC_VECTOR(5 downto 0);
    dout : out  STD_LOGIC_VECTOR ((PORTS*(NETWORK_SIZE+COST_SIZE)+DB_ADDR_SIZE - 1) downto 0);
    db_din : in STD_LOGIC_VECTOR(7 downto 0);
    db_read : out STD_LOGIC;
    db_addr : out STD_LOGIC_VECTOR(DB_ADDR_SIZE-1 downto 0);
    enable : in STD_LOGIC
	);
end DBtoDijkstra;

architecture Behavioral of DBtoDijkstra is

--CONSTANTS
constant zeroA : STD_LOGIC_VECTOR(DB_ADDR_SIZE-1 downto 0) := (others => '0');
constant zeroN : STD_LOGIC_VECTOR(NETWORK_SIZE-1 downto 0) := (others => '0');
constant zero8 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
constant zero16 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
constant oneH : STD_LOGIC_VECTOR((PORTS*(NETWORK_SIZE+COST_SIZE) - 1) downto 0) := (others => '1');

--FSM STATES
type STATES is (IDLE, DBLEN, SELR, GETID, LINKNO, ADJ_LID, ADJ_COST, WRITEINFO);

signal p_db_len, n_db_len : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal p_state, n_state : STATES := IDLE;
signal p_router, n_router : STD_LOGIC_VECTOR((2**ROUTERID_SIZE)-1 downto 0) := (others => '0');
signal p_links, n_links : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal n_crl, p_crl : STD_LOGIC_VECTOR((PORTS*(NETWORK_SIZE+COST_SIZE) - 1) downto 0) := (others => '1');

--COUNTERS
signal n_sc, p_sc : integer range 0 to 63 := 0;
signal n_gc, p_gc : integer range 0 to 3 := 0;
signal n_lc, p_lc : integer range 0 to 1 := 0;
signal n_adlid, p_adlid, n_adcost, p_adcost : integer range 0 to 15 := 0;
begin
SEQ : process(clk)
begin
  if (clk'event and clk = '1') then
    --FSM STATE
    p_state <= n_state;

    --COUNTERS
    p_sc <= n_sc;
    p_gc <= n_gc;
    p_lc <= n_lc;
    p_adlid <= n_adlid;
    p_adcost <= n_adcost;

    --DBD LEN
    p_db_len <= n_db_len;

    --ROUTER ID
    p_router <= n_router;

    --ROUTER INFO LIST
    p_crl <= n_crl;

    --ROUTER LINKS
    p_links <= n_links;
  end if;
end process SEQ;

COMB : process(p_state)
begin
  case(p_state) is
    when IDLE =>
      --COUNTERS
      n_sc <= p_sc;
      n_gc <= p_gc;
      n_lc <= p_lc;
      n_adlid <= p_adlid;
      n_adcost <= p_adcost;

      --DBD LEN
      n_db_len <= zero8;

      --ROUTER ID
      n_router <= zeroN;

      --ROUTER INFO LIST
      p_crl <= oneH;

      --READ/WRITE
      write <= '0';

      if (enable = '1') then
        n_state <= DBLEN;
        db_read <= '1';
        db_addr <= zeroA;
      else
        n_state <= IDLE;
        db_read <= '0';
        db_addr <= zeroA;
      end if;

      --ROUTER LINKS
      n_links <= p_links;

    when DBLEN =>
      --COUNTERS
      n_sc <= p_sc;
      n_gc <= p_gc;
      n_lc <= p_lc;
      n_adlid <= p_adlid;
      n_adcost <= p_adcost;

      --DBD LEN
      n_db_len <= db_din;

      --ROUTER ID
      n_router <= zeroN;

      --ROUTER INFO LIST
      p_crl <= oneH;

      --READ/WRITE
      write <= '0';

      n_state <= SELR;
      db_read <= '1';
      db_addr <= zeroA;

      --ROUTER LINKS
      n_links <= p_links;

    when SELR =>
      --COUNTERS
      n_gc <= p_gc;
      n_lc <= p_lc;
      n_adlid <= p_adlid;
      n_adcost <= p_adcost;

      if (p_sc = to_i(unsigned(p_db_len))) then
        n_state <= IDLE;
        n_sc <= 0;
        db_read <= '0';
        db_addr <= zeroA;
      else
        n_state <= GETID;
        n_sc <= p_sc + 1;
        db_read <= '1';
        db_addr <= std_logic_vector(to_unsigned((p_sc)*(18 + 12*PORTS) + 7, DB_ADDR_SIZE));
      end if;

      --DBD LEN
      n_db_len <= p_db_len;

      --ROUTER ID
      n_router <= zeroN;

       --ROUTER INFO LIST
      p_crl <= oneH;

      --READ/WRITE
      write <= '0';

      --ROUTER LINKS
      n_links <= p_links;

    when GETID =>
      --COUNTERS
      n_sc <= p_sc;
      n_lc <= p_lc;
      n_adlid <= p_adlid;
      n_adcost <= p_adcost;
      n_adlid <= 0;
      n_lc <= 0;

      --DBD LEN
      n_db_len <= p_db_len;

       --ROUTER INFO LIST
      p_crl <= oneH;

      --READ/WRITE
      write <= '0';

      --ROUTER LINKS
      n_links <= p_links;
      if (p_gc < 3) then
        db_addr <= std_logic_vector(to_unsigned((p_sc-1)*(18 + 12*PORTS) + 8 + p_gc, DB_ADDR_SIZE));
      else
        db_addr <= std_logic_vector(to_unsigned((p_sc-1)*(18 + 12*PORTS) + 17, DB_ADDR_SIZE));
      end if;
      if (p_gc = 0) then
        n_router(31 downto 24) <= db_din;
      else
        n_router(31 downto 24) <= p_router(31 downto 24);
      end if;
      if (p_gc = 1) then
        n_router(23 downto 16) <= db_din;
      else
        n_router(23 downto 16) <= p_router(23 downto 16);
      end if;
      if (p_gc = 2) then
        n_router(15 downto 8) <= db_din;
      else
        n_router(15 downto 8) <= p_router(15 downto 8);
      end if;
      if (p_gc = 3) then
        n_router(7 downto 0) <= db_din;
      else
        n_router(7 downto 0) <= p_router(7 downto 0);
      end if;
      if (p_gc = 3) then
        n_state <= LINKNO;
        n_gc <= 0;
      else
        n_state <= GETID;
        n_gc <= p_gc + 1;
      end if;

    when LINKNO =>
      --COUNTERS
      n_sc <= p_sc;
      n_gc <= p_gc;
      n_adlid <= p_adlid;
      n_adcost <= p_adcost;
      --DBD LEN
      n_db_len <= p_db_len;

      --ROUTER ID
      n_router <= p_router;
       --ROUTER INFO LIST
      p_crl <= oneH;

      --READ/WRITE
      write <= '0';
      db_read <= '1';
      if (p_lc = 0) then
        n_links(15 downto 8) <= db_din;
      else
        n_links(15 downto 8) <= p_links;
      end if;

      if (p_lc = 1) then
        n_links(7 downto 0) <= db_din;
        n_state <= ADJ_LID;
        db_addr <= std_logic_vector(to_unsigned((p_sc-1)*(18 + 12*PORTS) + 22, DB_ADDR_SIZE));
        n_lc <= 0;
      else
        n_lc <= p_lc + 1;
        n_links(7 downto 0) <= p_links;
        n_state <= LINKNO;
        db_addr <= std_logic_vector(to_unsigned((p_sc-1)*(18 + 12*PORTS) + 18, DB_ADDR_SIZE));
      end if;

    when ADJ_LID =>
      --COUNTERS
      n_sc <= p_sc;
      n_gc <= p_gc;
      n_lc <= p_lc;
      n_adcost <= p_adcost;

      --DBD LEN
      n_db_len <= p_db_len;

      --ROUTER ID
      n_router <= p_router;

      --READ/WRITE
      write <= '0';
      db_read <= '1';

      --ROUTER LINKS
      n_links <= p_links;

      n_adlid <= p_adlid + 1;
      db_addr <= std_logic_vector(to_unsigned((p_sc-1)*(18 + 12*PORTS) + 18 + 12*p_adcost + 12, DB_ADDR_SIZE));
      n_crl((p_adlid + 1)*NETWORK_SIZE-1 downto p_adlid*NETWORK_SIZE) <= db_din(NETWORK_SIZE-1 downto 0);
      n_state <= ADJ_COST;

    when ADJ_COST =>
      --COUNTERS
      n_sc <= p_sc;
      n_gc <= p_gc;
      n_lc <= p_lc;

      --DBD LEN
      n_db_len <= p_db_len;

      --ROUTER ID
      n_router <= p_router;

      --READ/WRITE
      write <= '0';
      db_read <= '1';

      --ROUTER LINKS
      n_links <= p_links;

      db_addr <= std_logic_vector(to_unsigned((p_sc-1)*(18 + 12*PORTS) + 18 + 12*p_adlid + 4, DB_ADDR_SIZE));
      n_crl((p_adcost + 1)*COST_SIZE-1 + PORTS*NETWORK_SIZE downto p_adlid*NETWORK_SIZE + PORTS*NETWORK_SIZE) <= db_din(COST_SIZE-1 downto 0);
      if (p_adlid = to_integer(unsigned(p_links))) then
        n_adcost <= 0;
        n_adlid <= 0;
        n_state <= WRITEINFO;
      else
        n_adcost <= p_adcost + 1;
        n_adlid <= p_adlid;
        n_state <= ADJ_LID;
      end if;

    when others =>
      --COUNTERS
      n_sc <= p_sc;
      n_gc <= p_gc;
      n_lc <= p_lc;
      n_adlid <= p_adlid;
      n_adcost <= p_adcost;

      --DBD LEN
      n_db_len <= p_db_len;

      --ROUTER ID
      n_router <= zeroN;

      --ROUTER INFO LIST
      n_crl <= p_crl;

      --READ/WRITE
      db_read <= '0';
      db_addr <= zeroA;

      --ROUTER LINKS
      n_links <= p_links;

      write <= '1';
      addr <= p_router(ADDR_SIZE-1 downto 0);
      dout <= p_crl & p_router;
      n_state <= SELR;
  end case;
end process COMB;

end Behavioral;

