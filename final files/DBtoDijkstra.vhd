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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
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
    dout : out  STD_LOGIC_VECTOR ((PORTS*(NETWORK_SIZE+COST_SIZE)+2**ROUTERID_SIZE - 1) downto 0);
    db_din : in STD_LOGIC_VECTOR(7 downto 0);
    db_read : out STD_LOGIC;
    db_addr : out STD_LOGIC_VECTOR(DB_ADDR_SIZE-1 downto 0);
    enable : in STD_LOGIC;
    d_on : out STD_LOGIC
	);
end DBtoDijkstra;

architecture Behavioral of DBtoDijkstra is

--CONSTANTS
constant h_len : integer := 18;
constant zeroA : STD_LOGIC_VECTOR(DB_ADDR_SIZE-1 downto 0) := (others => '0');
constant zeroADDR : STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0) := (others => '0');
constant zeroIP : STD_LOGIC_VECTOR((2**ROUTERID_SIZE)-1 downto 0) := (others => '0');
constant zeroN : STD_LOGIC_VECTOR(NETWORK_SIZE-1 downto 0) := (others => '0');
constant zero8 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
constant zero16 : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
constant zeroDOUT : STD_LOGIC_VECTOR ((PORTS*(NETWORK_SIZE+COST_SIZE)+2**ROUTERID_SIZE - 1) downto 0) := (others => '0');
constant oneH : STD_LOGIC_VECTOR((PORTS*(NETWORK_SIZE+COST_SIZE) - 1) downto 0) := (others => '1');

--FSM STATES
type STATES is (IDLE, DBLEN, SELR, GETID, LINKNO, ADJ_LID, ADJ_COST, WRITE_STUB, WRITEINFO);

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
signal n_countLID, p_countLID : integer range 0 to 3 := 0;

--STUB STUFF
signal n_lid, p_lid : STD_LOGIC_VECTOR(2**ROUTERID_SIZE-1 downto 0) := (others => '1');
signal n_cost, p_cost : STD_LOGIC_VECTOR(COST_SIZE-1 downto 0) := (others => '1');
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
    p_countLID <= n_countLID;

    --DBD LEN
    p_db_len <= n_db_len;

    --ROUTER ID
    p_router <= n_router;

    --ROUTER INFO LIST
    p_crl <= n_crl;

    --ROUTER LINKS
    p_links <= n_links;

    --STUB LINKS
    p_lid <= n_lid;
    p_cost <= n_cost;

  end if;
end process SEQ;

COMB : process(p_sc, p_gc, p_lc, p_adlid, p_adcost,
               p_state, p_db_len, p_router,
               p_crl, p_links, db_din, enable,
					p_countLID, p_lid, p_cost)
variable tempStubData : std_logic_vector((PORTS*(NETWORK_SIZE+COST_SIZE) - 1) downto 0) := (others => '1');
begin
  case(p_state) is
    when IDLE =>
      --COUNTERS
      n_sc <= p_sc;
      n_gc <= p_gc;
      n_lc <= p_lc;
      n_adlid <= p_adlid;
      n_adcost <= p_adcost;
      n_countLID <= p_countLID;

      --STUB LINKS
      n_lid <= p_lid;
      n_cost <= p_cost;

      d_on <= '0';
      --DBD LEN
      n_db_len <= zero8;

      --ROUTER ID
      n_router <= zeroIP;

      --ROUTER INFO LIST
      n_crl <= oneH;

      --READ/WRITE
      write <= '0';
      dout <= zeroDOUT;
      addr <= zeroADDR;
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
      n_countLID <= p_countLID;

      --STUB LINKS
      n_lid <= p_lid;
      n_cost <= p_cost;

      d_on <= '0';

      --DBD LEN
      n_db_len <= db_din;

      --ROUTER ID
      n_router <= zeroIP;

      --ROUTER INFO LIST
      n_crl <= oneH;

      --READ/WRITE
      write <= '0';
      dout <= zeroDOUT;
      n_state <= SELR;
      db_read <= '1';
      db_addr <= zeroA;
      addr <= zeroADDR;
      --ROUTER LINKS
      n_links <= p_links;

    when SELR =>
      --COUNTERS
      n_gc <= p_gc;
      n_lc <= p_lc;
      n_adlid <= p_adlid;
      n_adcost <= p_adcost;
      n_countLID <= p_countLID;

      --STUB LINKS
      n_lid <= p_lid;
      n_cost <= p_cost;

      d_on <= '0';
      if (p_sc = to_integer(unsigned(db_din))) then
        n_state <= IDLE;
        n_sc <= 0;
        db_read <= '0';
        db_addr <= zeroA;
      else
        n_state <= GETID;
        n_sc <= p_sc + 1;
        db_read <= '1';
        db_addr <= std_logic_vector(to_unsigned((p_sc)*(h_len + 12*PORTS) + 7, DB_ADDR_SIZE));
      end if;

      --DBD LEN
      n_db_len <= p_db_len;

      --ROUTER ID
      n_router <= zeroIP;

       --ROUTER INFO LIST
      n_crl <= oneH;

      --READ/WRITE
      write <= '0';
      dout <= zeroDOUT;
      addr <= zeroADDR;
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
      n_countLID <= p_countLID;

      --STUB LINKS
      n_lid <= p_lid;
      n_cost <= p_cost;

      d_on <= '0';

      --DBD LEN
      n_db_len <= p_db_len;

       --ROUTER INFO LIST
      n_crl <= oneH;

      --READ/WRITE
      write <= '0';
      dout <= zeroDOUT;
      db_read <= '1';
      addr <= zeroADDR;
      --ROUTER LINKS
      n_links <= p_links;
      if (p_gc < 3) then
        db_addr <= std_logic_vector(to_unsigned((p_sc-1)*(h_len + 12*PORTS) + 8 + p_gc, DB_ADDR_SIZE));
      else
        db_addr <= std_logic_vector(to_unsigned((p_sc-1)*(h_len + 12*PORTS) + 17, DB_ADDR_SIZE));
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

      --STUB LINKS
      n_lid <= p_lid;
      n_cost <= p_cost;

      d_on <= '0';

      --DBD LEN
      n_db_len <= p_db_len;

      --ROUTER ID
      n_router <= p_router;
       --ROUTER INFO LIST
      n_crl <= oneH;

      --READ/WRITE
      write <= '0';
      dout <= zeroDOUT;
      db_read <= '1';
      addr <= zeroADDR;
      if (p_lc = 0) then
        n_links(15 downto 8) <= db_din;
      else
        n_links(15 downto 8) <= p_links(15 downto 8);
      end if;

      if (p_lc = 1) then
        n_links(7 downto 0) <= db_din;
        n_state <= ADJ_LID;
        db_addr <= std_logic_vector(to_unsigned((p_sc-1)*(h_len + 12*PORTS) + h_len + 1, DB_ADDR_SIZE));  --Read Link ID's FIRST BYTE
        n_lc <= 0;
        n_countLID <= 3;
      else
        n_lc <= p_lc + 1;
        n_links(7 downto 0) <= p_links(7 downto 0);
        n_state <= LINKNO;
        db_addr <= std_logic_vector(to_unsigned((p_sc-1)*(h_len + 12*PORTS) + h_len, DB_ADDR_SIZE));
      end if;

    when ADJ_LID =>
      --COUNTERS
      n_sc <= p_sc;
      n_gc <= p_gc;
      n_lc <= p_lc;
      n_adcost <= p_adcost;

      --STUB LINKS
      n_cost <= p_cost;

      d_on <= '0';

      --DBD LEN
      n_db_len <= p_db_len;

      --ROUTER ID
      n_router <= p_router;

      --READ/WRITE
      write <= '0';
      db_read <= '1';
      dout <= zeroDOUT;
      addr <= zeroADDR;

      --ROUTER LINKS
      n_links <= p_links;

      if (to_integer(unsigned(p_links)) = 0) then
        n_crl <= p_crl;
        n_adlid <= 0;
        db_addr <= zeroA;
        n_state <= SELR;
      elsif (p_countLID > 0) then
        n_countLID <= p_countLID - 1;
        n_lid((p_countLID+1)*8-1 downto p_countLID*8) <= db_din;
        db_addr <= std_logic_vector(to_unsigned((p_sc-1)*(h_len + 12*PORTS) + h_len + 12*p_adlid + 5 - p_countLID, DB_ADDR_SIZE));
        n_state <= ADJ_LID;
        n_crl <= p_crl;
      else
        n_countLID <= 3;
        n_lid((p_countLID+1)*8-1 downto p_countLID*8) <= db_din;
        db_addr <= std_logic_vector(to_unsigned((p_sc-1)*(h_len + 12*PORTS) + h_len + 12*p_adlid + 12, DB_ADDR_SIZE));
        n_state <= ADJ_COST;        
        n_adlid <= p_adlid + 1;
        n_crl((p_adlid + 1)*NETWORK_SIZE-1 downto p_adlid*NETWORK_SIZE) <= db_din(NETWORK_SIZE-1 downto 0);
        if (p_adlid*NETWORK_SIZE > 0) then
          n_crl(p_adlid*NETWORK_SIZE-1 downto 0) <= p_crl(p_adlid*NETWORK_SIZE-1 downto 0);
        end if;
        if ((p_adlid + 1)*NETWORK_SIZE < PORTS*(NETWORK_SIZE+COST_SIZE)) then
          n_crl(PORTS*(NETWORK_SIZE + COST_SIZE) - 1 downto (p_adlid + 1)*NETWORK_SIZE) <= p_crl(PORTS*(NETWORK_SIZE + COST_SIZE) - 1 downto (p_adlid + 1)*NETWORK_SIZE);
        end if;
      end if;

    when ADJ_COST =>
      --COUNTERS
      n_sc <= p_sc;
      n_gc <= p_gc;
      n_lc <= p_lc;
      n_countLID <= p_countLID;

      --STUB LINKS
      n_lid <= p_lid;

      d_on <= '0';

      --DBD LEN
      n_db_len <= p_db_len;

      --ROUTER ID
      n_router <= p_router;

      --READ/WRITE
      write <= '0';
      db_read <= '1';
      dout <= zeroDOUT;
      addr <= zeroADDR;
      --ROUTER LINKS
      n_links <= p_links;

      db_addr <= std_logic_vector(to_unsigned((p_sc-1)*(h_len + 12*PORTS) + h_len + 12*p_adcost + 4, DB_ADDR_SIZE));
      n_crl((p_adcost + 1)*COST_SIZE-1 + PORTS*NETWORK_SIZE downto p_adcost*COST_SIZE + PORTS*NETWORK_SIZE) <= db_din(COST_SIZE-1 downto 0);
      n_cost <= db_din(COST_SIZE-1 downto 0);
      if (p_adcost*COST_SIZE + PORTS*NETWORK_SIZE > 0) then
        n_crl(p_adcost*COST_SIZE + PORTS*NETWORK_SIZE - 1 downto 0) <= p_crl(p_adcost*COST_SIZE + PORTS*NETWORK_SIZE-1 downto 0);
      end if;
      if ((p_adcost + 1)*COST_SIZE + PORTS*NETWORK_SIZE < PORTS*(NETWORK_SIZE+COST_SIZE)) then
        n_crl(PORTS*(NETWORK_SIZE + COST_SIZE) - 1 downto (p_adcost + 1)*COST_SIZE + PORTS*NETWORK_SIZE) <= p_crl(PORTS*(NETWORK_SIZE + COST_SIZE) - 1 downto (p_adcost + 1)*COST_SIZE + PORTS*NETWORK_SIZE);
      end if;
      --if (p_adlid = to_integer(unsigned(p_links))) then
      --  n_adcost <= 0;
      --  n_adlid <= 0;
      --  n_state <= WRITEINFO;
      --else
        n_adcost <= p_adcost + 1;
        n_adlid <= p_adlid;
        n_state <= WRITE_STUB;
      --end if;

    when WRITE_STUB =>
    --COUNTERS
      n_sc <= p_sc;
      n_gc <= p_gc;
      n_lc <= p_lc;
      n_adlid <= p_adlid;
      n_adcost <= p_adcost;
      n_countLID <= 3;

      --STUB LINKS
      n_lid <= p_lid;
      n_cost <= p_cost;

      d_on <= '0';
      --DBD LEN
      n_db_len <= zero8;

      --ROUTER ID
      n_router <= p_router;

      --ROUTER INFO LIST
      n_crl <= p_crl;

      --READ/WRITE
      db_read <= '0';

      write <= '1';
      tempStubData(NETWORK_SIZE-1 downto 0) := p_router(NETWORK_SIZE-1 downto 0);
      tempStubData(PORTS*NETWORK_SIZE + COST_SIZE -1 downto PORTS*NETWORK_SIZE) := p_cost;
      dout <= p_lid & tempStubData;
      addr <= p_lid(ADDR_SIZE-1 downto 0);
      if (p_adlid = to_integer(unsigned(p_links))) then
        n_state <= WRITEINFO;
        n_adcost <= 0;
        n_adlid <= 0;
        db_addr <= zeroA;
      else
        n_state <= ADJ_LID;
        db_addr <= std_logic_vector(to_unsigned((p_sc-1)*(h_len + 12*PORTS) + h_len + 12*p_adlid + 1, DB_ADDR_SIZE));
        n_adcost <= p_adcost;
        n_adlid <= p_adlid;
      end if;

    when others =>
      --COUNTERS
      n_sc <= p_sc;
      n_gc <= p_gc;
      n_lc <= p_lc;
      n_adlid <= p_adlid;
      n_adcost <= p_adcost;
      n_countLID <= p_countLID;

      --STUB LINKS
      n_lid <= p_lid;
      n_cost <= p_cost;

      d_on <= '1';

      --DBD LEN
      n_db_len <= p_db_len;

      --ROUTER ID
      n_router <= zeroIP;

      --ROUTER INFO LIST
      n_crl <= p_crl;

      --READ/WRITE
      db_read <= '1';
      db_addr <= zeroA;

      --ROUTER LINKS
      n_links <= p_links;

      write <= '1';
      addr <= p_router(ADDR_SIZE-1 downto 0);
      dout <= p_router & p_crl;
      n_state <= SELR;
  end case;
end process COMB;

end Behavioral;

