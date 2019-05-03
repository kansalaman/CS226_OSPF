----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:48:48 05/03/2019 
-- Design Name: 
-- Module Name:    ACK_generator - Behavioral 
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
USE ieee.numeric_std.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ACK_generator is
    Port ( 
           clk : in std_logic;
           qwrite : in  STD_LOGIC;
           qdata : in  STD_LOGIC_VECTOR (7 downto 0);
           ackvalid : out  STD_LOGIC;
           ackout : out  STD_LOGIC_VECTOR (7 downto 0));
end ACK_generator;

architecture Behavioral of ACK_generator is

COMPONENT FIFOACK
PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    data_count : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
    );
END COMPONENT;

type states is (idle,getLSAcount,sendHeader,sendLSA);
signal p_state,n_state : states := idle;
signal p_counter,n_counter : integer := 0;
signal empty : std_logic;
signal rd_en,srst,full : std_logic;
signal data_count : STD_LOGIC_VECTOR(10 downto 0);

begin
qu1 : FIFOACK
    PORT MAP (
      clk => clk,
      srst => srst,
      din => qdata,
      wr_en => qwrite,
      rd_en => rd_en,
      dout => ackout,
      full => full,
      empty => empty,
      data_count => data_count
    );

process(clk)
begin
    if(clk='1' and clk'event) then
        p_state <= n_state;
        p_counter <= n_counter;
        

        


end Behavioral;

