----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:12:57 04/25/2019 
-- Design Name: 
-- Module Name:    helloActParse - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity helloActParse is
    Port ( clk : in  STD_LOGIC;
    	   neighbor_val : in  STD_LOGIC;
    	   self : in STD_LOGIC_VECTOR(31 downto 0);
		   routerid_val : in STD_LOGIC;
		   dbd_val : in STD_LOGIC;
           in1 : in  STD_LOGIC_VECTOR (7 downto 0);
           hellogenin : in  STD_LOGIC;
           stateout : out STD_LOGIC_VECTOR(1 downto 0);
           router_id : out STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
           out1 : out STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
           outval : out STD_LOGIC := '0');
end helloActParse;

architecture Behavioral of helloActParse is
	type FSM is (ONE_WAY, DOWN, INIT, EXSTART, EXCHANGE_SENDING, EXCHANGE_LISTENING, LOADING, FULL);
	type DBD is (IDLE, FETCHING_LSA, SENDING_IP, SENDING_OSPFHEAD, SENDING_DBD);
	type DBD_READ is (IDLE_R, OPTIONS, SEQNUM, LSA1, LSA2, LSA3, LSA4, LSA5);
	constant zero8 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	constant zero7 : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');

	signal p_state, n_state : FSM := DOWN;
	signal p_dbd, n_dbd : DBD := IDLE;
	signal p_read : DBD_READ := IDLE_R;
	--signal send, send_next : STD_LOGIC := '0';
	signal sending_complete : STD_LOGIC := '1';


	signal router_id_sig : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal sending_length, sending_len_next: STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
	signal neighbor_id : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal old_neighbor : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal active_neighbor : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal ID_part : STD_LOGIC_VECTOR(1 downto 0) := "00";
	signal in_index : STD_LOGIC_VECTOR(1 downto 0) := (others => '1');
	signal curr_time, next_time : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
	constant zero_time : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
	constant max_time : STD_LOGIC_VECTOR(9 downto 0) := (others => '1');
	constant defaultseq : STD_LOGIC_VECTOR(31 downto 0) := (31 downto 16 => '0', others => '1');
	signal curr_seqnum : STD_LOGIC_VECTOR(31 downto 0) := defaultseq;

	signal numLSA : STD_LOGIC_VECTOR(1 downto 0) := (others => '1');
	constant IPheader : STD_LOGIC_VECTOR(159 downto 0) := (others => '0');
	constant IPlength : STD_LOGIC_VECTOR(6 downto 0) := "0010011";


	signal ospfheader : STD_LOGIC_VECTOR(191 downto 0);

	constant ospflength : STD_LOGIC_VECTOR(6 downto 0) := "0010111";
	
	signal dbd_packet : STD_LOGIC_VECTOR(543 downto 0) ;
		-- first 32 : last three bits options
		-- next 32 : DD sequence number
		-- each of the next 160 bits (set of 3) are LSAs

	constant empty_dbd_length : STD_LOGIC_VECTOR(6 downto 0) := "0000111";
	signal dbd_length : STD_LOGIC_VECTOR(6 downto 0);

	signal temp_dbd_received : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

	signal master : STD_LOGIC := '1';
	signal more_sig : STD_LOGIC := '1';
	signal init_sig : STD_LOGIC := '1';
	signal neighbor_more : STD_LOGIC := '1';

	   -- 0                   1                   2                   3
       -- 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
       --+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       --|   Version #   |       2       |         Packet length         |
       --+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       --|                          Router ID                            |
       --+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       --|                           Area ID                             |
       --+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       --|           Checksum            |             AuType            |
       --+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       --|                       Authentication                          |
       --+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       --|                       Authentication                          |
       --+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       --|       0       |       0       |    Options    |0|0|0|0|0|I|M|MS
       --+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       --|                     DD sequence number                        |
       --+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       --|                                                               |
       --+-                                                             -+
       --|                             A                                 |
       --+-                 Link State Advertisement                    -+
       --|                           Header                              |
       --+-                                                             -+
       --|                                                               |
       --+-                                                             -+
       --|                                                               |
       --+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
       --|                              ...                              |
begin

router_id <= router_id_sig;
ospfheader(191 downto 176) <= "0000001000000010";
ospfheader(175 downto 160) <= conv_std_logic_vector(20*conv_integer(numLSA) + 31, 16);
ospfheader(159 downto 128) <= self;
ospfheader(127 downto 0) <= (others =>'0');
dbd_length <= conv_std_logic_vector(20*conv_integer(numLSA) + 7, 7);

dbd_packet(543 downto 515) <= (others => '0');
dbd_packet(514) <= init_sig;
dbd_packet(513) <= more_sig;
dbd_packet(512) <= master;
dbd_packet(511 downto 480) <= defaultseq;


SEQ1 : process(clk)
	variable msb : integer;
	variable lsb : integer;

begin
	if (clk = '1' and clk'event) then
		p_state <= n_state;
		curr_time <= next_time;

		p_dbd <= n_dbd;
		sending_length <= sending_len_next;

		msb := conv_integer(sending_len_next)*8 + 7;
		lsb := conv_integer(sending_len_next)*8;

		if (ID_part = "00" and neighbor_val = '1') then
			old_neighbor <= active_neighbor;
		end if;
		

		if (ID_part = "00" and routerid_val = '1') then
			router_id_sig <= neighbor_id;
		end if ;

		case( n_dbd ) is
			when IDLE =>
				out1 <= (others => '0');
				outval <= '0';
			when SENDING_IP =>
				out1 <= IPheader(msb downto lsb);
				outval <= '1';
			when SENDING_OSPFHEAD =>
				out1 <= ospfheader(msb downto lsb);
				outval <= '1';
			when others => --SENDING_DBD
				out1 <= dbd_packet(msb downto lsb);
				outval <= '1';
		end case ;

		--if (ID_part = "00" and dbd_val = '1') then
		--	case( p_read ) is
		--		when OPTIONS =>
		--			if (temp_dbd_received(2) = '1') then --INIT from their end
		--				init_sig <= '0';
		--				if (router_id_sig > self) then
		--					master <= '0';
		--				else
		--					master <= '1';
		--				end if ;
		--			else
		--				if(master = '0') then
		--					--slave actions
		--				else
		--					--master actions
		--				end if;
		--			end if ;
		--		when SEQNUM =>
		--			if (master = '1') then
						
		--			else
						
		--			end if ;
		--		when others =>

		--	end case ;
		--end if ;
		if (n_dbd = IDLE and (n_state = EXSTART or n_state = EXCHANGE_SENDING)) then
			sending_complete <= not(sending_complete);
		end if ;
	end if;
end process;

-------- ORIGINAL STATE MACHINE --------
COMBSTATE : process(p_state, ID_part, old_neighbor, routerid_val, curr_time, hellogenin, self, dbd_val, p_read, master, temp_dbd_received, dbd_length)
begin
	case( p_state ) is
	
		when DOWN =>
			if (hellogenin = '1') then
				n_state <= INIT;
				next_time <= max_time;
			elsif (routerid_val = '1') then
				n_state <= ONE_WAY;
				next_time <= max_time;
			else
				n_state <= p_state;
				next_time <= zero_time;
			end if ;
		when INIT =>
			if (curr_time = zero_time) then
				n_state <= DOWN;
				next_time <= zero_time;
			elsif (routerid_val = '1') then
				n_state <= ONE_WAY;
				next_time <= max_time;
			else
				n_state <= p_state;
				next_time <= curr_time - 1;
			end if;
		when ONE_WAY =>
			if (curr_time = zero_time) then
				n_state <= DOWN;
				next_time <= zero_time;
			elsif (old_neighbor = self) then
				n_state <= EXSTART;
				next_time <= max_time;
			else
				n_state <= p_state;
				next_time <= curr_time - 1;
			end if ;
		when EXSTART =>
			if (curr_time = zero_time) then
				n_state <= DOWN;
				next_time <= zero_time;
			else
				if (ID_part = "00" and dbd_val = '1') then
					next_time <= max_time;
					case( p_read ) is
						when IDLE_R =>
							if (master = '1') then
								n_state <= EXCHANGE_LISTENING;
							else
								n_state <= EXCHANGE_SENDING;
							end if ;
						when OPTIONS =>
							if (temp_dbd_received(2) = '0') then
								n_state <= DOWN;
							else
								n_state <= p_state;
							end if ;

						when SEQNUM =>
							if (master = '1' and curr_seqnum = temp_dbd_received) then
								n_state <= p_state;
							elsif (master = '1') then
								n_state <= DOWN;
							else
								n_state <= p_state;
							end if ;
						when LSA1 =>
							n_state <= p_state;
						when LSA2 =>
							n_state <= p_state;
						when LSA3 =>
							n_state <= p_state;
						when LSA4 =>
							n_state <= p_state;
						when others => --LSA5
							n_state <= p_state;
					end case ;
				else
					n_state <= p_state;
					next_time <= curr_time - 1;
				end if ;
			end if ;

		when EXCHANGE_SENDING =>
			if (master = '1') then
				if (sending_complete = '1') then
					n_state <= EXCHANGE_LISTENING;
					next_time <= curr_time - 1;
				else
					n_state <= p_state;
					next_time <= curr_time - 1;
				end if ;
			else
				if (neighbor_more = '0' and more_sig = '0' and sending_complete = '1') then
					n_state <= LOADING;
				elsif (sending_complete = '1') then
					n_state <= EXCHANGE_LISTENING;
				else
					n_state <= p_state;
					next_time <= curr_time - 1;
				end if ;
			end if ;

		when EXCHANGE_LISTENING =>
			if (curr_time = zero_time) then
				n_state <= DOWN;
				next_time <= zero_time;
			elsif (master = '1') then
				n_state <= p_state;
				next_time <= curr_time - 1;
			else
				n_state <= p_state;
				next_time <= curr_time - 1;
			end if ;

		when others => --FULL
			if (curr_time = zero_time) then
				n_state <= DOWN;
				next_time <= zero_time;
			else
				n_state <= p_state;
				next_time <= curr_time - 1;
			end if;
	end case ;
end process;
----------------------------------------

-------- READING ALL KINDS OF PACKETS --------
SEQUPDATE : process(clk)
	variable msb : integer;
	variable lsb : integer;
begin
	if (clk = '1' and clk'event) then
		if(neighbor_val = '1') then
			msb := conv_integer(in_index)*8 + 7;
			lsb := conv_integer(in_index)*8;
			case( ID_part ) is
				when "00" =>
					active_neighbor(msb downto lsb) <= in1;
					in_index <= in_index - 1;
					ID_part <= "01";
				when "01" =>
					active_neighbor(msb downto lsb) <= in1;
					in_index <= in_index - 1;
					ID_part <= "10";
				when "10" =>
					active_neighbor(msb downto lsb) <= in1;
					in_index <= in_index - 1;
					ID_part <= "11";
				when others =>
					active_neighbor(msb downto lsb) <= in1;
					ID_part <= "00";
					in_index <= (others => '1');
			end case;
		elsif (routerid_val = '1') then
			msb := conv_integer(in_index)*8 + 7;
			lsb := conv_integer(in_index)*8;
			case( ID_part ) is
				when "00" =>
					neighbor_id(msb downto lsb) <= in1;
					in_index <= in_index - 1;
					ID_part <= "01";
				when "01" =>
					neighbor_id(msb downto lsb) <= in1;
					in_index <= in_index - 1;
					ID_part <= "10";
				when "10" =>
					neighbor_id(msb downto lsb) <= in1;
					in_index <= in_index - 1;
					ID_part <= "11";
				when others =>
					neighbor_id(msb downto lsb) <= in1;
					ID_part <= "00";
					in_index <= (others => '1');
			end case;
		elsif (dbd_val = '1') then
			msb := conv_integer(in_index)*8 + 7;
			lsb := conv_integer(in_index)*8;
			case( ID_part ) is
				when "00" =>
					temp_dbd_received(msb downto lsb) <= in1;
					in_index <= in_index - 1;
					ID_part <= "01";
				when "01" =>
					temp_dbd_received(msb downto lsb) <= in1;
					in_index <= in_index - 1;
					ID_part <= "10";
				when "10" =>
					temp_dbd_received(msb downto lsb) <= in1;
					in_index <= in_index - 1;
					ID_part <= "11";
				when others =>
					temp_dbd_received(msb downto lsb) <= in1;
					ID_part <= "00";
					in_index <= (others => '1');
			end case;
		else
			in_index <= (others => '1');
			ID_part <= (others => '0');
		end if ;
	end if ;	
end process;
--------------------------------

-------- SENDING DBD STATE MACHINE --------
COMBDBD : process(p_state, p_dbd, sending_length)
begin
	case( p_dbd ) is
		when IDLE =>
			if (p_state = EXSTART or p_state = EXCHANGE_SENDING) then
				n_dbd <= SENDING_IP;
				sending_len_next <= IPlength;
			else
				n_dbd <= p_dbd;
				sending_len_next <= zero7;
			end if ;
		when SENDING_IP =>
			if (sending_length = zero7) then
				n_dbd <= SENDING_OSPFHEAD;
				sending_len_next <= ospflength;
			else
				n_dbd <= p_dbd;
				sending_len_next <= sending_length - 1;
			end if ;
		when SENDING_OSPFHEAD =>
			if (sending_length = zero7) then
				n_dbd <= SENDING_DBD;
				sending_len_next <= dbd_length;
			else
				n_dbd <= p_dbd;
				sending_len_next <= sending_length - 1;
			end if ;
		when others => --SENDING_DBD
			if (sending_length = zero7) then
				n_dbd <= IDLE;
				sending_len_next <= zero7;
			else
				n_dbd <= p_dbd;
				sending_len_next <= sending_length - 1;
			end if;
	end case ;
end process;
--------------------------------

---------- SENDING DBD PACKET --------
--SEQOUT : process(clk)
--	variable msb : integer;
--	variable lsb : integer;
--begin
--	if (clk = '1' and  clk'event) then
--		p_dbd <= n_dbd;
--		msb := conv_integer(sending_length)*8 + 7;
--		lsb := conv_integer(sending_length)*8;

--		case( n_dbd ) is
--			when IDLE =>
--				outval <= '0';
--				out1 <= (others => '0');
--				if (n_state = EXSTART or n_state = EXCHANGE_SENDING) then
--					sending_length <= IPlength;
--				end if;
--			when SENDING_IP =>
--				if (sending_length = zero7) then
--					out1 <= IPheader(msb downto lsb);
--					outval <= '1';
--					sending_length <= ospflength;
--				else
--					out1 <= IPheader(msb downto lsb);
--					outval <= '1';
--					sending_length <= sending_length - 1;
--				end if ;
--			when SENDING_OSPFHEAD =>
--				if (sending_length = zero7) then
--					out1 <= ospfheader(msb downto lsb);
--					outval <= '1';
--					sending_length <= dbd_length;
--				else
--					out1 <= ospfheader(msb downto lsb);
--					outval <= '1';
--					sending_length <= sending_length - 1;
--				end if ;
--			when others => --SENDING_DBD
--				if (sending_length = zero7) then
--					out1 <= dbd_packet(msb downto lsb);
--					outval <= '1';
--					sending_length <= zero7;
--				else
--					out1 <= dbd_packet(msb downto lsb);
--					outval <= '1';
--					sending_length <= sending_length - 1;
--				end if ;
				
--		end case ;
--	end if;
--end process;
------------------------------------------


-------- READING DBD STATE MACHINE --------
SEQREAD : process(clk)
begin
	if (clk = '1' and clk'event) then
		if (ID_part = "01" and dbd_val = '1') then
			case( p_read ) is
				when IDLE_R =>
					p_read <= OPTIONS;
				when OPTIONS =>
					p_read <= SEQNUM;
				when SEQNUM =>
					p_read <= LSA1;
				when LSA1 =>
					p_read <= LSA2;
				when LSA2 =>
					p_read <= LSA3;
				when LSA3 =>
					p_read <= LSA4;
				when LSA4 =>
					p_read <= LSA5;
				when others =>
					p_read <= LSA1;
			end case ;
		elsif (dbd_val = '0') then
			-- LET THE STATE MACHINE KNOW READING IS COMPLETE
			p_read <= IDLE_R;
		end if ;
	end if ;
end process;

----------------------------------------


stateout <= "00" when p_state = DOWN else
				"01" when p_state = INIT else
				"10" when p_state = ONE_WAY else
				"11";

end Behavioral;
