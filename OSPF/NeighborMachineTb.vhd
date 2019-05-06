-- TestBench Template 

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

  ENTITY NMtestbench IS
  END NMtestbench;

  ARCHITECTURE behavior OF NMtestbench IS 

  -- Component Declaration
          COMPONENT NeighborMachine
          GENERIC (
            self : std_logic_vector(31 downto 0) := "00000100000001010000011000000111"
            );
          PORT(
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
          signal clk : STD_LOGIC := '0';
          signal neighbor_val : std_logic := '0';
          signal routerid_val : std_logic := '0';
          signal dbd_val : std_logic := '0';
          signal in1 : std_logic_vector(7 downto 0) := (others => '0');
          signal hellogenin : std_logic := '0';
          signal stateout : std_logic_vector(2 downto 0);
          signal router_id : std_logic_vector(31 downto 0);
          signal out1 : std_logic_vector(7 downto 0);
          signal dbd_outval : std_logic;
          signal lsr_outval : std_logic;
          signal db_rd_en : std_logic;
          signal db_addr : std_logic_vector(11 downto 0);
          signal db_din : std_logic_vector(7 downto 0);
          signal db_busy : std_logic := '0';
          constant clk_period : time := 10 ns;

  BEGIN
          
  -- Component Instantiation
          uut: NeighborMachine PORT MAP(
                  clk => clk,
                  neighbor_val => neighbor_val,
                  routerid_val => routerid_val,
                  dbd_val => dbd_val,
                  in1 => in1,
                  hellogenin => hellogenin,
                  stateout => stateout,
                  router_id => router_id,
                  out1 => out1,
                  dbd_outval => dbd_outval,
                  lsr_outval => lsr_outval,
                  db_rd_en => db_rd_en,
                  db_addr => db_addr,
                  db_din => db_din,
                  db_busy => db_busy
          );
          ram : RAMDB PORT MAP(
          clka => clk,
          ena => '1',
          wea => "0",
          addra => db_addr,
          dina => (others => '0'),
          douta => db_din
         );
  --  Test Bench Statements
      clk_process :process
     begin
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
     end process;
   
     tb : PROCESS
     BEGIN

        wait for 100 ns; -- wait until global set/reset completes
        wait for 100 ns;  

      wait for clk_period*10.5;
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
        -- Add user defined stimulus here

        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;
