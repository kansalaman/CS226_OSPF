----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:30:43 05/03/2019 
-- Design Name: 
-- Module Name:    LSAFetcher - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LSAFetcher is
	Generic
  	(
    ADDR_SIZE : integer := 12
  	);
    Port ( clk : in  STD_LOGIC;
           rd_en : in  STD_LOGIC;
           rst : in STD_LOGIC;
           num_lsa : out STD_LOGIC_VECTOR (1 downto 0);
           db_rd_en : out STD_LOGIC;
           db_addr : out STD_LOGIC_VECTOR(ADDR_SIZE - 1 downto 0);
           db_din : in  STD_LOGIC_VECTOR (7 downto 0);
           dout : out  STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
           db_busy : in STD_LOGIC;
           rd_val : out STD_LOGIC := '0';
           empty : out STD_LOGIC);
end LSAFetcher;

architecture Behavioral of LSAFetcher is
	signal total_lsas, total_next : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal dout_next : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	constant zero_addr : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
	signal next_rd_en : STD_LOGIC := '0';
	signal rd_next : STD_LOGIC := '0';
	signal next_data : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal curr_pointer, next_pointer : STD_LOGIC_VECTOR(ADDR_SIZE - 1 downto 0) := (ADDR_SIZE - 1 downto 1 => '0', others => '1');
	type FSM is (IDLE, R_BEGIN, LSAGE1, LSAGE2, OPTIONS, LSTYPE, LINK1, LINK2, LINK3, LINK4,
				ADV1, ADV2, ADV3, ADV4, SEQ1, SEQ2, SEQ3, SEQ4, CHECK1, CHECK2, LEN1, LEN2);
	signal n_state, p_state : FSM := IDLE;
	signal numlsa_sig : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal empty_sig, empty_next : STD_LOGIC := '0';
begin

SEQ : process(clk)
begin
	if (clk = '1' and clk'event) then
		p_state <= n_state;
		curr_pointer <= next_pointer;
		
		rd_val <= rd_next;

		if (n_state = LEN2) then
			numlsa_sig <= numlsa_sig + 1;
		end if;
		if (n_state = R_BEGIN) then
			numlsa_sig <= "00";
		end if ;
		dout <= dout_next;
		total_lsas <= total_next;
		empty_sig <= empty_next;
		--if (n_state = R_BEGIN) then
		--	total_lsas <= next_data;
		--	dout <= (others => '0');
		--else
		--	dout <= next_data;
		--end if ;
	end if ;
end process;

COMB : process(p_state, curr_pointer, db_din, db_busy, rd_en, total_lsas, rst, empty_sig, numlsa_sig)
	variable num_of_lsa : integer;
begin

	if (rst = '1') then
		n_state <= IDLE;
		next_pointer <= (ADDR_SIZE - 1 downto 1 => '0', others => '1');
		db_addr <= (ADDR_SIZE - 1 downto 1 => '0', others => '1');
		db_rd_en <= '0';
		empty_next <= '0';
		dout_next <= (others => '0');
		rd_next <= '0';
		total_next <= total_lsas;
	else
		
		case( p_state ) is
			when IDLE =>
				empty_next <= empty_sig;
				dout_next <= (others => '0');
				total_next <= total_lsas;
				rd_next <= '0';
				if (db_busy = '1') then
					n_state <= IDLE;
					next_pointer <= curr_pointer;
					db_addr <= curr_pointer;
					db_rd_en <= '0';
				elsif (rd_en = '1') then
					n_state <= R_BEGIN;
					next_pointer <= curr_pointer;
					db_addr <= zero_addr;
					db_rd_en <= '1';
				else
					n_state <= IDLE;
					next_pointer <= curr_pointer;
					db_addr <= curr_pointer;
					db_rd_en <= '0';
				end if ;
			when R_BEGIN =>
				empty_next <= empty_sig;
				rd_next <= '0';
				dout_next <= (others => '0');
				total_next <= db_din;
				n_state <= LSAGE1;
				next_pointer <= curr_pointer;
				db_addr <= curr_pointer;
				db_rd_en <= '1';
			when LSAGE1 =>
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= db_din;
				total_next <= total_lsas;
				n_state <= LSAGE2;
				next_pointer <= curr_pointer + 1;
				db_addr <= curr_pointer + 1;
				db_rd_en <= '1';
			when LSAGE2 =>
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= db_din;
				total_next <= total_lsas;
				n_state <= OPTIONS;
				next_pointer <= curr_pointer;
				db_addr <= curr_pointer;
				db_rd_en <= '1';
			when OPTIONS =>
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= (others => '0');
				total_next <= total_lsas;
				n_state <= LSTYPE;
				next_pointer <= curr_pointer;
				db_addr <= curr_pointer;
				db_rd_en <= '1';
			when LSTYPE =>
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= (others => '0');
				total_next <= total_lsas;
				n_state <= LINK1;
				next_pointer <= curr_pointer + 1;
				db_addr <= curr_pointer + 1;
				db_rd_en <= '1';
			when LINK1 =>
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= db_din;
				total_next <= total_lsas;
				n_state <= LINK2;
				next_pointer <= curr_pointer + 1;
				db_addr <= curr_pointer + 1;
				db_rd_en <= '1';
			when LINK2 =>
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= db_din;
				total_next <= total_lsas;
				n_state <= LINK3;
				next_pointer <= curr_pointer + 1;
				db_addr <= curr_pointer + 1;
				db_rd_en <= '1';
			when LINK3 =>
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= db_din;
				total_next <= total_lsas;
				n_state <= LINK4;
				next_pointer <= curr_pointer + 1;
				db_addr <= curr_pointer + 1;
				db_rd_en <= '1';
			when LINK4 => 
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= db_din;
				total_next <= total_lsas;
				n_state <= ADV1;
				next_pointer <= curr_pointer + 1;
				db_addr <= curr_pointer + 1;
				db_rd_en <= '1';
			when ADV1 =>
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= db_din;
				total_next <= total_lsas;
				n_state <= ADV2;
				next_pointer <= curr_pointer + 1;
				db_addr <= curr_pointer + 1;
				db_rd_en <= '1';
			when ADV2 =>
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= db_din;
				total_next <= total_lsas;
				n_state <= ADV3;
				next_pointer <= curr_pointer + 1;
				db_addr <= curr_pointer + 1;
				db_rd_en <= '1';
			when ADV3 =>
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= db_din;
				total_next <= total_lsas;
				n_state <= ADV4;
				next_pointer <= curr_pointer + 1;
				db_addr <= curr_pointer + 1;
				db_rd_en <= '1';
			when ADV4 =>
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= db_din;
				total_next <= total_lsas;
				n_state <= SEQ1;
				next_pointer <= curr_pointer + 1;
				db_addr <= curr_pointer + 1;
				db_rd_en <= '1';
			when SEQ1 =>
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= db_din;
				total_next <= total_lsas;
				n_state <= SEQ2;
				next_pointer <= curr_pointer + 1;
				db_addr <= curr_pointer + 1;
				db_rd_en <= '1';
			when SEQ2 =>
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= db_din;
				total_next <= total_lsas;
				n_state <= SEQ3;
				next_pointer <= curr_pointer + 1;
				db_addr <= curr_pointer + 1;
				db_rd_en <= '1';
			when SEQ3 =>
				empty_next <= empty_sig;
				dout_next <= db_din;
				rd_next <= '1';
				total_next <= total_lsas;
				n_state <= SEQ4;
				next_pointer <= curr_pointer + 1;
				db_addr <= curr_pointer + 1;
				db_rd_en <= '1';
			when SEQ4 =>
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= db_din;
				total_next <= total_lsas;
				n_state <= CHECK1;
				next_pointer <= curr_pointer;
				db_addr <= curr_pointer;
				db_rd_en <= '1';
			when CHECK1 =>
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= (others => '0');
				total_next <= total_lsas;
				n_state <= CHECK2;
				next_pointer <= curr_pointer;
				db_addr <= curr_pointer;
				db_rd_en <= '1';
			when CHECK2 =>
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= (others => '0');
				total_next <= total_lsas;
				n_state <= LEN1;
				next_pointer <= curr_pointer + 1;
				db_addr <= curr_pointer + 1;
				db_rd_en <= '1';
			when LEN1 =>
				empty_next <= empty_sig;
				rd_next <= '1';
				dout_next <= db_din;
				total_next <= total_lsas;
				n_state <= LEN2;
				next_pointer <= curr_pointer + 1;
				db_addr <= curr_pointer + 1;
				db_rd_en <= '1';
			when others => --LEN2
				rd_next <= '1';
				dout_next <= db_din;
				total_next <= total_lsas;
				num_of_lsa := conv_integer(curr_pointer - 16)/114 + 1;
				if (num_of_lsa = conv_integer(total_lsas)) then
					empty_next <= '1';
					n_state <= IDLE;
					db_rd_en <= '0';
					next_pointer <= curr_pointer;
					db_addr <= curr_pointer;
				elsif (numlsa_sig = "11") then
					empty_next <= '0';
					n_state <= IDLE;
					db_rd_en <= '0';
					next_pointer <= curr_pointer + 99;
					db_addr <= curr_pointer + 99;
				else
					empty_next <= '0';
					n_state <= LSAGE1;
					db_rd_en <= '1';
					next_pointer <= curr_pointer + 99;
					db_addr <= curr_pointer + 99;
				end if ;
		end case ;
	end if;
end process;
num_lsa <= numlsa_sig;
empty <= empty_sig;

end Behavioral;
