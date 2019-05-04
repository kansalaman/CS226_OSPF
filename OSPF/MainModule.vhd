----------------------------------------------------------------------------------
-- Company: 		AC/DC
-- Engineer: 
-- 
-- Create Date:    08:19:38 05/04/2019 
-- Design Name: 
-- Module Name:    MainModule - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MainModule is
	Port
	(
		clk : in std_logic;
		--Inputs
		in1, in2, in3, in4, in5, in6, in7, in8 : in std_logic_vector(7 downto 0);
		in_val1, in_val2, in_val3, in_val4, in_val5, in_val6, in_val7, in_val8 : in std_logic_vector(7 downto 0);

		--Outputs
		out1, out2, out3, out4, out5, out6, out7, out8 : out std_logic_vector(7 downto 0);
		out_val1, out_val2, out_val3, out_val4, out_val5, out_val6, out_val7, out_val8 : std_logic;

		--Dijkstra button
		dijkstra_on : in std_logic := '0'
	);
end MainModule;

architecture Behavioral of MainModule is
  constant router_id : std_logic_vector(31 downto 0) := "00000001000000010000000100000001";
	component Parser is
    Port 
    ( 
      in1 : in  STD_LOGIC_VECTOR (7 downto 0);
      validity : in  STD_LOGIC;
      clk : in  STD_LOGIC;
      out1 : out  STD_LOGIC_VECTOR (7 downto 0);
      hello_out : out  STD_LOGIC;
      ls_out : out  STD_LOGIC;
      telling_lsu : out std_logic;
      telling_dd : out std_logic;
      telling_plen : out std_logic;
      telling_rid: out std_logic;
      telling_lsr : out std_logic;
      telling_neighbour: out std_logic;
      full_size_len: out std_logic_vector(15 downto 0)
    );
  end component;

  component helloalive is
    Generic 
    (
      ROUTER_IP : STD_LOGIC_VECTOR(31 downto 0) := "00000001000000010000000100000001"
    );
    Port 
    ( 
      out1 : out  STD_LOGIC_VECTOR (7 downto 0):= "00000000";
      neighbor: in STD_LOGIC_VECTOR(31 downto 0); -- My neighbours.
      clk : in std_logic;
      val: out std_logic :='0';
      reply_signal: in std_logic := '0'
    );

    end component;

  --NO BUSY for input to Main LSA queue
  component LSU_Parser is
    Generic
    (
      PORT_NO : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
      router_id : std_logic_vector(31 downto 0) := "11110011000000000000000000000000"
    );
    Port 
    (
     state_in : in  STD_LOGIC_VECTOR (3 downto 0);
     data_in : in  STD_LOGIC_VECTOR (7 downto 0);
     data_valid : in  STD_LOGIC;
     clk : in std_logic;
     write_to_q : out  STD_LOGIC;
     qout : out  STD_LOGIC_VECTOR (7 downto 0);
     ack_q_out : out STD_LOGIC_VECTOR(7 downto 0);
     ack_q_val : out std_logic
    );
  end component;

  --Output interface machine
  component interfaceOut is
      Generic
      (
        PORT_NO : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
        router_id : std_logic_vector(31 downto 0) := "11110011000000000000000000000000"
      );
      Port 
      ( 
        clk : in std_logic;
        qin1 : in std_logic_vector(7 downto 0);
        qin2 : in std_logic_vector(7 downto 0);
        readq1 : out std_logic;
        readq2 : out std_logic;
        empq1 : in std_logic;
        empq2 : in std_logic;
        dout: out std_logic_vector(7 downto 0);
        dout_val: out std_logic
      );
  end component;

  --ACK/LSA Queue per interface; Per interface 2
  COMPONENT InterfaceFIFO
    PORT 
    (
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      wr_en : IN STD_LOGIC;
      rd_en : IN STD_LOGIC;
      dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      full : OUT STD_LOGIC;
      empty : OUT STD_LOGIC;
      data_count : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
    );
  END COMPONENT;

  -- One; NO BUSY
  component LinkStateUpdateMachine is
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
  end component;

  --The Database RAM!
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

  --The flooding FSM
  component FloodingFSM is
    Port
    (
      clk : in std_logic;
      val : in std_logic;
      din : in std_logic_vector(7 downto 0);
      port_in : in std_logic_vector(7 downto 0);
      out1, out2, out3, out4, out5, out6, out7, out8 : out std_logic_vector(7 downto 0);
      write1, write2, write3, write4, write5, write6, write7, write8 : out std_logic
    );
  end component;

  --RAMDB to Dijkstra DB
  component DBtoDijkstra is
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
  end component;

  --Dijkstra's Memory
  COMPONENT RAMDijkstra
    PORT (
      clka : IN STD_LOGIC;
      ena : IN STD_LOGIC;
      wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addra : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      dina : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      douta : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
  END COMPONENT;

  --The Holy Dijkstra Module
  component Dijkstra is
    Generic 
    ( 
      PORTS : integer := 8;
      NETWORK_SIZE : integer := 6;
      COST_SIZE : integer := 6;
      DB_ADDR_SIZE : integer := 32;
      ROUTER_INDEX : integer := 0
    );    
    Port 
    ( 
      din : in  STD_LOGIC_VECTOR ((PORTS*(NETWORK_SIZE+COST_SIZE) - 1) downto 0);
      ip_in : in STD_LOGIC_VECTOR(DB_ADDR_SIZE-1 downto 0);
      addr_read : out  STD_LOGIC_VECTOR ((NETWORK_SIZE - 1) downto 0) := (others => '0');
      read : out STD_LOGIC;
      write : out STD_LOGIC := '0';
      addr_write : out STD_LOGIC_VECTOR ((NETWORK_SIZE - 1) downto 0) := (others => '0');
      dout :  out STD_LOGIC_VECTOR(2*DB_ADDR_SIZE-1 downto 0) := (others => '0');
      enable : in  STD_LOGIC := '0';
      done : out STD_LOGIC := '1';
      help : out STD_LOGIC_VECTOR(PORTS-1 downto 0) := (others => '0');
      router_ip : in STD_LOGIC_VECTOR(DB_ADDR_SIZE-1 downto 0) := (others => '0');
      clk : in STD_LOGIC
    );
  end component;

  COMPONENT RoutingDB
    PORT (
      clka : IN STD_LOGIC;
      ena : IN STD_LOGIC;
      wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addra : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      dina : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
      douta : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    );
  END COMPONENT;

  --LSR Reply
  component lsraction is
    Generic
    (
      ADDR_SIZE : integer := 12;
      PORTS : integer := 8
    );
    Port 
    ( 
      clk : in  STD_LOGIC;
      len : in  STD_LOGIC_VECTOR (15 downto 0);
      len_val : in  STD_LOGIC;
      in1 : in  STD_LOGIC_VECTOR (7 downto 0);
      data_val: in STD_LOGIC;
      out1 : inout  STD_LOGIC_VECTOR (7 downto 0):= "00000000";
      badreq: out STD_LOGIC;
      out_val : out  STD_LOGIC;
      db_read : out std_logic;
      db_addr : out std_logic_vector(ADDR_SIZE-1 downto 0);
      db_din : in std_logic_vector(7 downto 0);
      db_write : out std_logic;
      db_dout : out std_logic_vector(7 downto 0);
      db_busy_read : in std_logic;
      db_busy_write : in std_logic
      );
  end component;

  component lsugen is
    Generic
    (
      ADDR_SIZE : integer := 12;
      PORTS : integer := 8
    );
    Port
    (
     -- State determinatation
     n1state : in std_logic_vector(2 downto 0);
     n2state : in std_logic_vector(2 downto 0);
     n3state : in std_logic_vector(2 downto 0);
     n4state : in std_logic_vector(2 downto 0);
     
     n5state : in std_logic_vector(2 downto 0);
     n6state : in std_logic_vector(2 downto 0);
     n7state : in std_logic_vector(2 downto 0);
     n8state : in std_logic_vector(2 downto 0);
     
     -- Neighbour's IP 
     neigh1: in std_logic_vector(31 downto 0);
     neigh2: in std_logic_vector(31 downto 0);
     neigh3: in std_logic_vector(31 downto 0);
     neigh4: in std_logic_vector(31 downto 0);
     
     neigh5: in std_logic_vector(31 downto 0);
     neigh6: in std_logic_vector(31 downto 0);
     neigh7: in std_logic_vector(31 downto 0);
     neigh8: in std_logic_vector(31 downto 0);
     
     -- Flooding related controls
     out_val: inout std_logic := '0';
     out1: inout std_logic_vector(7 downto 0):= (others => '0');
     negIface: out std_logic_vector(7 downto 0) := (others => '0');
     
     -- Memory related controls
     clk : in std_logic;
  --    empty : in std_logic;
    db_read : out std_logic;
    db_addr : out std_logic_vector(ADDR_SIZE-1 downto 0);
    db_din : in std_logic_vector(7 downto 0);
    db_write : out std_logic;
    db_dout : out std_logic_vector(7 downto 0);
     db_busy_read : in std_logic;
     db_busy_write : in std_logic      
    );
  end component;

  --Neighborhood Machine
  component NeighborMachine is
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
  end component;

type QArrayT is array (1 to 8) of std_logic_vector(7 downto 0);
type QVArrayT is array (1 to 8) of std_logic;
type QDCArrayT is array (1 to 8) of std_logic_vector(10 downto 0);
type IOArrayT is array (1 to 8) of std_logic_vector(7 downto 0);
type IOArrayV is array (1 to 8) of std_logic;


--Neighborhood Machine I/O
type NM_StateOutT is array(1 to 8) of std_logic_vector(2 downto 0);
type NM_RouterIDT is array(1 to 8) of std_logic_vector(31 downto 0);
type NM_AddrT is array(1 to 8) of std_logic_vector(11 downto 0);
signal neighM_stateout : NM_StateOutT;
signal neighM_router_id : NM_RouterIDT;
signal neighM_outArr : QArrayT;
signal neighM_dbd_outval : QVArrayT;
signal neighM_lsr_outval : QVArrayT;
signal neighM_db_rd_en : QVArrayT;
signal neighM_db_addr : NM_AddrT;
signal neighM_db_din : QArrayT;

signal dummy_var : std_logic := '0';
--I/O Ports Array
signal outputArray, inputArray : IOArrayT;
signal outputvalArray, inputvalArray : IOArrayV;

--Parser I/O
signal parserOutput : IOArrayT;
signal telling_neighbour, telling_lsu, telling_dd, telling_plen, telling_rid, telling_lsr : IOArrayV;
type ParserLenT is array(1 to 8) of std_logic_vector(15 downto 0);
signal full_size_len : ParserLenT;

--LSU_P I/O
signal LSUPQ_W : IOArrayV;
signal LSUPQ_O : IOArrayT;

--Hello Alive I/O
signal haOArr : IOArrayT;
signal haVArr : IOArrayV;

--LSR I/O
signal lsrOutArr : IOArrayT;

signal lsrOutVArr, lsr_db_read  : IOArrayV;
type LsrAddrT is array(1 to 8) of std_logic_vector(11 downto 0);
signal lsr_dr_addr : LsrAddrT;

--Queue Read/Write Arrays
signal ackQOArr, ackQIArr : QArrayT;
signal LSAQOArr, LSAQIArr : QArrayT;
signal ackQWArr, ackQRArr, LSAQWArr, LSAQRArr : QVArrayT;
--Queue Empty/Full Arrays
signal ackQEArr, LSAQEArr : QVArrayT;

--Queues super reset
signal rst : std_logic := '0';
--Queue Data Count Arrays
signal ackQDCArr, LSAQDCArr : QDCArrayT;

--LSUM I/O
signal LSUMRAMrea : std_logic := '0';
signal LSUMRAMaddr : std_logic_vector(11 downto 0) := (others => '0');
signal LSUM_fl_val : std_logic := '0';
signal LSUM_fl_out : std_logic_vector(7 downto 0);
signal LSUM_fl_port : std_logic_vector(7 downto 0);

--Main LSA Queue I/O
signal mainLSAQW, mainLSAQR, mainLSAQE : std_logic := '0';
signal mainLSAQI, mainLSAQO : std_logic_vector(7 downto 0);
signal mainLSAQDC : std_logic_vector(11 downto 0);

--Database RAM I/O
signal dbRAMena : std_logic;
signal dbRAMwea : std_logic_vector(0 downto 0);
signal dbRAMaddr : std_logic_vector(11 downto 0);
signal dbRAMdin : std_logic_vector(7 downto 0);
signal dbRAMdout : std_logic_vector(7 downto 0);
signal dbRAMrea : std_logic;

--Dijkstra RAM I/O
signal RAMDijkstra_wea : std_logic_vector(0 downto 0) := (others => '0');
signal RAMDijkstra_addr : std_logic_vector(5 downto 0) := (others => '0');
signal RAMDijkstra_din, RAMDijkstra_dout : std_logic_vector(127 downto 0) := (others => '0');

--Routing RAM I/O
signal routingRAMwea : std_logic_vector(0 downto 0) := (others => '0');
signal routingRAMaddr : std_logic_vector(5 downto 0) := (others => '0');
signal routingRAMdin : std_logic_vector(63 downto 0) := (others => '0');
signal routingRAMdout : std_logic_vector(63 downto 0) := (others => '0');

--DBtoDijkstra I/O
signal db2dj_d_on, db2dj_db_read : std_logic;
signal db2dj_addr, db2dj_db_addr : std_logic_vector(5 downto 0) := (others => '0');

--Dijkstra I/O
signal dj_addr_read, dj_addr_write : std_logic_vector(5 downto 0) := (others => '0');
signal dj_done : std_logic;

--FLOODING I/O
signal fl_out : IOArrayT;
signal fl_write : IOArrayV;

begin
  --Mapping i/o ports to i/o Array
  out1 <= outputArray(1);
  out2 <= outputArray(2);
  out3 <= outputArray(3);
  out4 <= outputArray(4);
  out5 <= outputArray(5);
  out6 <= outputArray(6);
  out7 <= outputArray(7);
  out8 <= outputArray(8);

  inputArray(1) <= in1;
  inputArray(2) <= in2;
  inputArray(3) <= in3;
  inputArray(4) <= in4;
  inputArray(5) <= in5;
  inputArray(6) <= in6;
  inputArray(7) <= in7;
  inputArray(8) <= in8;

  --Mapping i/o port validities to i/o validity array
  out_val1 <= outputvalArray(1);
  out_val2 <= outputvalArray(2);
  out_val3 <= outputvalArray(3);
  out_val4 <= outputvalArray(4);
  out_val5 <= outputvalArray(5);
  out_val6 <= outputvalArray(6);
  out_val7 <= outputvalArray(7);
  out_val8 <= outputvalArray(8);

  inputvalArray(1) <= in_val1;
  inputvalArray(2) <= in_val2;
  inputvalArray(3) <= in_val3;
  inputvalArray(4) <= in_val4;
  inputvalArray(5) <= in_val5;
  inputvalArray(6) <= in_val6;
  inputvalArray(7) <= in_val7;
  inputvalArray(8) <= in_val8;
 

  --Main Parser + Interface output machines + queues + LSUParser + LSRMachine + DBDMachine for-generate loop
  INTERFACE_OUTPUTS : for i in 1 to 8 generate
    P : Parser
      port map
      (
        in1 => inputArray(i),
        validity => inputvalArray(i),
        clk => clk,
        out1 => parserOutput(i),
        hello_out => open,
        ls_out => open,
        telling_lsu => telling_lsu(i),
        telling_dd => telling_dd(i),
        telling_plen => telling_plen(i),
        telling_rid => telling_rid(i),
        telling_lsr => telling_lsr(i),
        telling_neighbour => telling_neighbour(i),
        full_size_len => full_size_len(i)
      );

    NM : NeighborMachine
      generic map (
          self => router_id
          )
      port map (
          clk => clk,
          neighbor_val => telling_neighbour(i),
          routerid_val => telling_rid(i),
          dbd_val => telling_dd(i),
          in1 => parserOutput(i),
          hellogenin => haVArr(i),
          stateout => neighM_stateout(i),
          router_id => neighM_router_id(i),
          out1 => neighM_outArr(i),
          dbd_outval => neighM_dbd_outval(i),
          lsr_outval => neighM_lsr_outval(i),
          db_rd_en => neighM_db_rd_en(i),
          db_addr => neighM_db_addr(i),
          db_din => dbRAMdout,
          db_busy => dummy_var
          );

    LSU_P : LSU_Parser
      generic map
      (
        PORT_NO => std_logic_vector(to_unsigned(i, 8)),
        router_id => router_id
      )
      port map
      (
        state_in => '0' & neighM_stateout(i),
        data_in => parserOutput(i),
        data_valid => telling_lsu(i),
        clk => clk,
        write_to_q => LSUPQ_W(i),
        qout => LSUPQ_O(i),
        ack_q_out => ackQIArr(i),
        ack_q_val => ackQWArr(i)
      );

    I : interfaceOut
      generic map 
      (
        PORT_NO => std_logic_vector(to_unsigned(i, 8)),
        router_id => router_id
      )
      port map
      (
        clk => clk,
        qin1 => ackQOArr(i),
        qin2 => LSAQOArr(i),
        readq1 => ackQRArr(i),
        readq2 => LSAQRArr(i),
        empq1 => ackQEArr(i),
        empq2 => LSAQEArr(i),
        dout => outputArray(i),
        dout_val => outputvalArray(i)
      );

    AckQ : InterfaceFIFO
      port map
      (
        clk => clk,
        rst => rst,
        din => ackQIArr(i),
        wr_en => ackQWArr(i),
        rd_en => ackQRArr(i),
        dout => ackQOArr(i),
        full => open,
        empty => ackQEArr(i),
        data_count => ackQDCArr(i)
      );

    LSAQ : InterfaceFIFO
      port map
      (
        clk => clk,
        rst => rst,
        din => LSAQIArr(i),
        wr_en => LSAQWArr(i),
        rd_en => LSAQRArr(i),
        dout => LSAQOArr(i),
        full => open,
        empty => LSAQEArr(i),
        data_count => LSAQDCArr(i)
      );


    HA : HelloAlive
      generic map
      (
        ROUTER_IP => router_id
      )
      port map
      (
        out1 => haOArr(i),
        neighbor => neighM_router_id(i),
        clk => clk,
        val => haVArr(i),
        reply_signal => dummy_var
      );
    
    LSR_M : lsraction
      port map
      ( 
        clk => clk,
        len => full_size_len(i),
        len_val => telling_plen,
        in1 => parserOutput(i),
        data_val => telling_lsr(i),
        out1 => lsrOutArr(i),
        badreq => open,
        out_val => lsrOutVArr(i),
        db_read => lsr_db_read(i),
        db_addr => lsr_db_addr(i),
        db_din => dbRAMdout,
        db_write => open,
        db_dout => open,
        db_busy_read => dummy_var,
        db_busy_write => dummy_var
      );
  end generate;

  --LSU Update Machine
  --component LinkStateUpdateMachine is
  --  Generic
  --  (
  --    ADDR_SIZE : integer := 12;
  --    PORTS : integer := 8
  --  );
  --  Port
  --  (
  --    clk : in std_logic;
  --    empty : in std_logic;
  --    q_din : in std_logic_vector(7 downto 0);
  --    q_read : out std_logic;
  --    db_read : out std_logic;
  --    db_addr : out std_logic_vector(ADDR_SIZE-1 downto 0);
  --    db_din : in std_logic_vector(7 downto 0);
  --    db_write : out std_logic;
  --    db_dout : out std_logic_vector(7 downto 0);
  --    fl_val : out std_logic;
  --    fl_out : out std_logic_vector(7 downto 0);
  --    fl_port : out std_logic_vector(7 downto 0);
  --    dijkstra_on : out std_logic
  --  );
  --end component;
  LSU_GEN : lsugen
    PORT map
    (
      n1state => neighM_stateout(1),
     n2state => neighM_stateout(2),
     n3state => neighM_stateout(3),
     n4state => neighM_stateout(4),
     
     n5state => neighM_stateout(5),
     n6state => neighM_stateout(6),
     n7state => neighM_stateout(7),
     n8state => neighM_stateout(8),
     
     -- Neighbour's IP 
     neigh1 => neighM_router_id(1),
     neigh2 => neighM_router_id(2),
     neigh3 => neighM_router_id(3),
     neigh4 => neighM_router_id(4),
     
     neigh5 => neighM_router_id(5),
     neigh6 => neighM_router_id(6),
     neigh7 => neighM_router_id(7),
     neigh8 => neighM_router_id(8),
     
     -- Flooding related controls
     out_val => LSU_GEN_out_val,
     out1 => LSU_GEN_out1,
     negIface => LSU_GEN_FACE,
     
     -- Memory related controls
     clk => clk,
    db_read => lsu_gen_db_read,
    db_addr => lsu_gen_db_addr,
    db_din => dbRAMdout,
    db_write => ,
    db_dout => ,
     db_busy_read => ,
     db_busy_write =>
      );

  Main_Q : InterfaceFIFO
    port map
    (
      clk => clk,
      rst => rst,
      din => mainLSAQI,
      wr_en => mainLSAQW,
      rd_en => mainLSAQR,
      dout => mainLSAQO,
      full => open,
      empty => mainLSAQE,
      data_count => mainLSADC
    );
  LSU_Update_M : LinkStateUpdateMachine
    port map
    (
      clk => clk,
      empty => mainLSAQE,
      q_din => mainLSAQO,
      q_read => mainLSAQR,
      db_read => LSUMRAMrea,
      db_addr => LSUMRAMaddr,
      db_din => dbRAMdout,
      db_write => LSUM_dbRAM,
      db_dout => LSUMDBOUT,
      fl_val => LSUM_fl_val,
      fl_out => LSUM_fl_out,
      fl_port => LSUM_fl_port,
      dijkstra_on => dijkstra_on
    );

  --Database RAM
  Database_RAM : RAMDB
    port map
    (
      clka => clk,
      ena => dbRAMena,
      wea => dbRAMwea,
      addra => dbRAMaddr,
      dina => dbRAMdin,
      douta => dbRAMdout
    );

  FloodF : FloodingFSM
    port map
    (
      clk => clk,
      val => fl_val,
      din => fl_din,
      port_in => fl_port_in,

      --Mux with LSAQ
      out1 => fl_out(1),
      out2 => fl_out(2),
      out3 => fl_out(3),
      out4 => fl_out(4),
      out5 => fl_out(5),
      out6 => fl_out(6),
      out7 => fl_out(7),
      out8 => fl_out(8),

      write1 => fl_write(1),
      write2 => fl_write(2),
      write3 => fl_write(3),
      write4 => fl_write(4),
      write5 => fl_write(5),
      write6 => fl_write(6),
      write7 => fl_write(7),
      write8 => fl_write(8)
    );

  DB2D : DBtoDijkstra
    port map
    (
      clk => clk,
      write => RAMDijkstra_wea(0),
      --TO DO Please MUX WITH RAMDijkstra's Address
      addr => db2dj_addr,
      dout => RAMDijkstra_din,
      db_din => dbRAMdout,
      db_read => db2dj_db_read,
      db_addr => db2dj_db_addr,

      -- Don't need to do anything here
      enable => dijkstra_on,
      d_on => db2dj_d_on
    );


  RDijkstra : RAMDijkstra
    port map
    (
      clka => clk,
      ena => '1',
      wea => RAMDijkstra_wea,
      addra => RAMDijkstra_addr,
      dina => RAMDijkstra_din,
      douta => RAMDijkstra_dout
    );

  DijkstraInstantiate : Dijkstra
    generic map
    (
      ROUTER_INDEX => 1
    )
    port map
    (
      din => RAMDijkstra_dout(95 downto 0),
      ip_in => RAMDijkstra_dout(127 downto 96),
      addr_read => dj_addr_read(5 downto 0),
      read => dj_read,
      write => routingRAMwea(0),
      addr_write => routingRAMaddr,
      dout => routingRAMdin,
      enable => db2dj_d_on,
      done => dj_done,
      help => open,
      router_ip => router_ip,
      clk => clk
    );

  RoutingDatabase : RoutingDB
    port map
    (
      clk => clk,
      ena => '1',
      wea => routingRAMwea,
      addra => routingRAMaddr,
      dina => routingRAMdin,
      douta => routingRAMdout
    );


--TODO : dbRAMaddr mux in all possibel addr
-- neighM_db_rd_en(i) and neighM_db_addr(i),
-- db_read => db2dj_db_read and db_addr => db2dj_db_addr,
dbRAMaddr <= db2dj_db_addr when db2dj_db_read else
             lsu_gen_db_addr when lsu_gen_db_read else
             neighM_db_addr(1) when neighM_db_rd_en(1) else
             neighM_db_addr(2) when neighM_db_rd_en(2) else
             neighM_db_addr(3) when neighM_db_rd_en(3) else
             neighM_db_addr(4) when neighM_db_rd_en(4) else
             neighM_db_addr(5) when neighM_db_rd_en(5) else
             neighM_db_addr(6) when neighM_db_rd_en(6) else
             neighM_db_addr(7) when neighM_db_rd_en(7) else
             neighM_db_addr(8) when neighM_db_rd_en(8) else
             lsr_db_addr(1) when lsr_db_read(1) else
             lsr_db_addr(2) when lsr_db_read(2) else
             lsr_db_addr(3) when lsr_db_read(3) else
             lsr_db_addr(4) when lsr_db_read(4) else
             lsr_db_addr(5) when lsr_db_read(5) else
             lsr_db_addr(6) when lsr_db_read(6) else
             lsr_db_addr(7) when lsr_db_read(7) else
             lsr_db_addr(8) when lsr_db_read(8) else
             LSUMRAMaddr when LSUMRAMrea else
             (others => '0');

addra <= db2dj_addr or dj_addr_read;

QUEUEMUX : for i in 1 to 8 loop
    LSAQIArr(i) <= fl_out(i) when fl_write(i) else
                   lsrOutArr(i) when telling_lsr(i) else
                   (others => '0');
    LSAQWArr(i) <= fl_write(i) or telling_lsr(i);
end loop;

fl_val <= LSUM_fl_val or LSU_GEN_out_val;
fl_din <= LSU_GEN_out1 when LSU_GEN_out_val else
          LSUM_fl_out when LSUM_fl_val else
          (others => '0');

mainLSAQW <= LSUPQ_W(1) or LSUPQ_W(2) or LSUPQ_W(3) or LSUPQ_W(4) or LSUPQ_W(5) or LSUPQ_W(6) or LSUPQ_W(7) or LSUPQ_W(8);
mainLSAQI <= LSUPQ_O(1) when LSUPQ_W(1) else
             LSUPQ_O(2) when LSUPQ_W(2) else
             LSUPQ_O(3) when LSUPQ_W(3) else
             LSUPQ_O(4) when LSUPQ_W(4) else
             LSUPQ_O(5) when LSUPQ_W(5) else
             LSUPQ_O(6) when LSUPQ_W(6) else
             LSUPQ_O(7) when LSUPQ_W(7) else
             LSUPQ_O(8) when LSUPQ_W(8) else
             (others => '0');

end Behavioral;

