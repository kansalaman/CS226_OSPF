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

type QArrayT is array (1 to 8) of std_logic_vector(7 downto 0);
type QVArrayT is array (1 to 8) of std_logic;
type QDCArrayT is array (1 to 8) of std_logic_vector(10 downto 0);
type IOArrayT is array (1 to 8) of std_logic_vector(7 downto 0);
type IOArrayV is array (1 to 8) of std_logic;

signal dummy_var : std_logic;
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
signal mainLSAQ

--Database RAM I/O
signal dbRAMena : std_logic;
signal dbRAMwea : std_logic_vector(0 downto 0);
signal dbRAMaddr : std_logic_vector(11 downto 0);
signal dbRAMdin : std_logic_vector(7 downto 0);
signal dbRAMdout : std_logic_vector(7 downto 0);
signal dbRAMrea : std_logic;

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

    --component LSU_Parser is
    --  Generic
    --  (
    --      PORT_NO : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    --      router_id : std_logic_vector(31 downto 0) := "11110011000000000000000000000000"
    --  );
    --  Port 
    --  ( 
    --    state_in : in  STD_LOGIC_VECTOR (3 downto 0);
    --     data_in : in  STD_LOGIC_VECTOR (7 downto 0);
    --     data_valid : in  STD_LOGIC;
    --     clk : in std_logic;
    --         write_to_q : out  STD_LOGIC;
    --         qout : out  STD_LOGIC_VECTOR (7 downto 0);
    --         ack_q_out : out STD_LOGIC_VECTOR(7 downto 0);
    --         ack_q_val : out std_logic);
    --end component;

    LSU_P : LSU_Parser
      generic map
      (
        PORT_NO => std_logic_vector(to_unsigned(i, 8)),
        router_id => router_id
      )
      port map
      (
        state_in =>
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

    --TODO - HelloAlive Machine
    --entity helloalive is
    --  Generic (
    --    ROUTER_IP : STD_LOGIC_VECTOR(31 downto 0) := "00000001000000010000000100000001"
    --    );
    --    Port (  out1 : out  STD_LOGIC_VECTOR (7 downto 0):= "00000000";
    --            neighbor: in STD_LOGIC_VECTOR(31 downto 0); -- My neighbours.
    --            clk : in std_logic;
    --            val: out std_logic :='0';
    --            reply_signal: in std_logic := '0'
    --        );

    --    end helloalive;

    --TODO
    HA : HelloAlive
      generic map
      (
        ROUTER_IP => router_id
      )
      port map
      (
        out1 => haOArr(i),
        nieghbour => 
        clk => clk,
        val => haVArr(i),
        reply_signal => dummy_var
      );
    --TODO - DBD Machine

    --TODO - LSR Machine
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
--AckQ : InterfaceFIFO
--      port map
--      (
--        clk => clk,
--        rst => rst,
--        din => ackQIArr(i),
--        wr_en => ackQWArr(i),
--        rd_en => ackQRArr(i),
--        dout => ackQOArr(i),
--        full => ackQFArr(i),
--        empty => ackQEArr(i),
--        data_count => ackQDCArr(i)
--      );
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
      db_write => dbRAM
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

end Behavioral;

