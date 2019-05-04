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
           stateout : out STD_LOGIC_VECTOR(2 downto 0);
           router_id : out STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
           out1 : out STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
           dbd_outval : out STD_LOGIC := '0';
           lsr_outval : out STD_LOGIC := '0';
           dbd_rd_en : out STD_LOGIC := '0';
           dbd_rst : out STD_LOGIC := '0';
           numLSA : in STD_LOGIC_VECTOR(1 downto 0);
           dbd_out : in STD_LOGIC_VECTOR(7 downto 0);
           dbd_valid : in STD_LOGIC;
           dbd_empty : in STD_LOGIC;
           lsa_queue_wr_en : out STD_LOGIC := '0';
		   lsa_queue_dout : out STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
		   lsa_queue_rd_en : out STD_LOGIC := '0';
		   lsa_queue_din : in STD_LOGIC_VECTOR(7 downto 0);
		   lsa_queue_val : in STD_LOGIC;
		   lsa_queue_empty : in STD_LOGIC);
end helloActParse;

architecture Behavioral of helloActParse is
	type FSM is (ONE_WAY, DOWN, INIT, EXSTART, EXCHANGE_SENDING, EXCHANGE_LISTENING, LOADING, FULL);
	type DBD is (IDLE, LSA_WAIT, FETCHING_LSA1, FETCHING_LSA2, FETCHING_LSA3, SENDING_IP, SENDING_OSPFHEAD, SENDING_DBD);
	type DBD_READ is (IDLE_R, OPTIONS, SEQNUM, LSA_PART1, LSA_PART2, LSA_PART3, LSA_PART4, LSA_PART5);
	constant zero8 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	constant zero7 : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
	signal neighval_sig : STD_LOGIC;
	signal routid_sig : STD_LOGIC;
	signal dbd_val_sig : STD_LOGIC;

	signal p_state, n_state : FSM := DOWN;
	signal p_dbd : DBD := IDLE;
	signal p_read : DBD_READ := IDLE_R;
	--signal send, send_next : STD_LOGIC := '0';
	signal sending_complete : STD_LOGIC := '0';
	signal receiving_complete : STD_LOGIC := '1';

	signal dbd_out1 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal lsr_out1 : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal lsr_outval_sig : STD_LOGIC := '0';
	signal dbd_outval_sig : STD_LOGIC := '0';

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

	constant IPheader : STD_LOGIC_VECTOR(159 downto 0) := (others => '0');
	constant IPlength : STD_LOGIC_VECTOR(6 downto 0) := "0010011";


	signal ospfheader : STD_LOGIC_VECTOR(191 downto 0);

	constant ospflength : STD_LOGIC_VECTOR(6 downto 0) := "0010111";
	
	signal dbd_packet : STD_LOGIC_VECTOR(543 downto 0) ;
		-- first 32 : last three bits options
		-- next 32 : DD sequence number
		-- each of the next 160 bits (set of 3) are LSA_PARTs

	signal lsa_packet1 : STD_LOGIC_VECTOR(159 downto 0) := (others => '0');
	signal lsa_packet2 : STD_LOGIC_VECTOR(159 downto 0) := (others => '0');
	signal lsa_packet3 : STD_LOGIC_VECTOR(159 downto 0) := (others => '0');
	--signal next_enable : STD_LOGIC := '0';

	constant empty_dbd_length : STD_LOGIC_VECTOR(6 downto 0) := "0000111";
	signal dbd_length : STD_LOGIC_VECTOR(6 downto 0);

	signal temp_dbd_received : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

	signal master : STD_LOGIC := '1';
	signal more_sig : STD_LOGIC := '1';
	signal init_sig : STD_LOGIC := '1';
	signal neighbor_more : STD_LOGIC := '1';
	signal seqnum_error : STD_LOGIC := '0';
	signal lsa_left : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');

	constant receiving_begin : STD_LOGIC_VECTOR(6 downto 0) := "0010011";
	--signal receiving_lsa : STD_LOGIC_VECTOR(6 downto 0) := receiving_begin;

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
dbd_packet(479 downto 320) <= lsa_packet1;
dbd_packet(319 downto 160) <= lsa_packet2;
dbd_packet(159 downto 0) <= lsa_packet3;
more_sig <= not(dbd_empty);

SEQ1 : process(clk)
	variable msb : integer;
	variable lsb : integer;
	variable r_msb : integer;
	variable l_msb : integer;
begin
	if (clk = '1' and clk'event) then
		p_state <= n_state;
		curr_time <= next_time;
		if (n_state = DOWN) then
			master <= '1';
			init_sig <= '1';
			seqnum_error <= '0';
			curr_seqnum <= defaultseq;
			dbd_rst <= '1';
		else
			dbd_rst <= '0';
		end if ;
		if ((n_state = EXCHANGE_SENDING or n_state = EXSTART) and p_read = IDLE_R) then
			receiving_complete <= '0';
		end if ;

		if (ID_part = "00" and neighval_sig = '1') then
			old_neighbor <= active_neighbor;
		end if;
		
		if (lsa_queue_val = '1') then
			lsr_outval_sig <= '1';
			lsr_out1 <= lsa_queue_din;
		else
			lsr_outval_sig <= '0';
			lsr_out1 <= (others => '0');
		end if ;

		if (ID_part = "00" and routid_sig = '1') then
			router_id_sig <= neighbor_id;
		end if ;
		
		routid_sig <= routerid_val;
		neighval_sig <= neighbor_val;
		dbd_val_sig <= dbd_val;
		--case( n_dbd ) is
		--	when IDLE =>
		--		dbd_out1 <= (others => '0');
		--		dbd_outval_sig <= '0';

		--	when FETCHING_LSA =>
		--		dbd_out1 <= (others => '0');
		--		dbd_outval_sig <= '0';
		--		if (dbd_valid = '1') then
		--			r_msb := conv_integer(receiving_lsa)*8 + 7;
		--			l_msb := conv_integer(receiving_lsa)*8;
		--			dbd_packet(r_msb downto l_msb) <= dbd_out;
		--			receiving_lsa <= receiving_lsa - 1;
		--		end if;
		--	when SENDING_IP =>
		--		receiving_lsa <= receiving_begin;
		--		dbd_out1 <= IPheader(msb downto lsb);
		--		dbd_outval_sig <= '1';
		--	when SENDING_OSPFHEAD =>
		--		dbd_out1 <= ospfheader(msb downto lsb);
		--		dbd_outval_sig <= '1';
		--	when others => --SENDING_DBD
		--		dbd_out1 <= dbd_packet(msb downto lsb);
		--		dbd_outval_sig <= '1';
		--end case ;
		if (n_state = EXSTART) then
			if (p_read = LSA_PART1
				or p_read = LSA_PART2
				or p_read = LSA_PART5
				or p_read = LSA_PART3
				or p_read = LSA_PART4) then
				lsa_queue_wr_en <= '1';
				lsa_queue_dout <= in1;
			elsif (ID_part = "00" and dbd_val_sig = '1') then
				lsa_queue_wr_en <= '0';
				lsa_queue_dout <= (others => '0');
				if (p_read = OPTIONS) then
					neighbor_more <= temp_dbd_received(1);
					if (temp_dbd_received(2) = '1') then --INIT from their end
						if (router_id_sig > self) then
							master <= '0';
						else
							master <= '1';
						end if ;					
					end if ;
				elsif (p_read = SEQNUM) then
					receiving_complete <= '1';
					if (master = '1') then
						if (curr_seqnum /= temp_dbd_received and init_sig = '0') then
							seqnum_error <= '1';
						end if ;
					else
						curr_seqnum <= temp_dbd_received;
					end if ;
					init_sig <= '0';
				end if;
			else
				lsa_queue_wr_en <= '0';
				lsa_queue_dout <= (others => '0');
			end if ;
		elsif (n_state = EXCHANGE_LISTENING) then
			if (p_read = LSA_PART1
				or p_read = LSA_PART2
				or p_read = LSA_PART5
				or p_read = LSA_PART3
				or p_read = LSA_PART4) then
				lsa_queue_wr_en <= '1';
				lsa_queue_dout <= in1;
			elsif (ID_part = "00" and dbd_val_sig = '1') then
				lsa_queue_wr_en <= '0';
				lsa_queue_dout <= (others => '0');
				if (p_read = OPTIONS) then
					neighbor_more <= temp_dbd_received(1);
					if (temp_dbd_received(2) = '1') then --INIT from their end
						init_sig <= '0';
						if (router_id_sig > self) then
							master <= '0';
						else
							master <= '1';
						end if ;					
					end if ;
				elsif (p_read = SEQNUM) then
					receiving_complete <= '1';
					if (master = '1') then
						if (curr_seqnum /= temp_dbd_received and init_sig = '0') then
							seqnum_error <= '1';
						elsif (init_sig = '0') then
							curr_seqnum <= curr_seqnum + 1;
						end if ;
					else
						curr_seqnum <= temp_dbd_received;
					end if ;
					init_sig <= '0';
				end if;
			else
				lsa_queue_wr_en <= '0';
				lsa_queue_dout <= (others => '0');
			end if ;
		end if;
		--if (n_dbd = IDLE and (n_state = EXSTART or n_state = EXCHANGE_SENDING)) then
		--	sending_complete <= not(sending_complete);
		--end if ;
	end if;
end process;

-------- ORIGINAL STATE MACHINE --------
COMBSTATE : process(p_state, ID_part, old_neighbor, routerid_val,
							curr_time, hellogenin, self, dbd_val_sig, p_read,
							master, temp_dbd_received, dbd_length, curr_seqnum,
							curr_seqnum, dbd_length, sending_complete, 
							seqnum_error, neighbor_more, more_sig,
							init_sig, receiving_complete, lsa_queue_empty)
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
				if (ID_part = "00" and dbd_val_sig = '1') then
					next_time <= max_time;
					case( p_read ) is
						when IDLE_R =>
							--if (master = '1' and init_sig = '0') then
							--	n_state <= EXCHANGE_LISTENING;
							--elsif (master = '0' and init_sig = '0') then
							--	n_state <= EXCHANGE_SENDING;
							--else
							--	n_state <= p_state;
							--end if ;
							n_state <= p_state;
						when OPTIONS =>
							if (temp_dbd_received(2) = '0') then
								n_state <= DOWN;
							else
								n_state <= p_state;
							end if ;

						when SEQNUM =>
							if (master = '1' and curr_seqnum = temp_dbd_received) then
								n_state <= EXCHANGE_LISTENING;
							elsif (master = '1' and init_sig = '1') then
								n_state <= EXCHANGE_LISTENING;
							elsif (master = '1') then
								n_state <= DOWN;
							elsif (init_sig = '0') then
								n_state <= EXCHANGE_SENDING;
							else
								n_state <= DOWN;
							end if ;
						when LSA_PART1 =>
							n_state <= p_state;
						when LSA_PART2 =>
							n_state <= p_state;
						when LSA_PART3 =>
							n_state <= p_state;
						when LSA_PART4 =>
							n_state <= p_state;
						when others => --LSA_PART5
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
					next_time <= max_time;
				elsif (sending_complete = '1') then
					n_state <= EXCHANGE_LISTENING;
					next_time <= curr_time - 1;
				else
					n_state <= p_state;
					next_time <= curr_time - 1;
				end if ;
			end if ;

		when EXCHANGE_LISTENING =>
			if (curr_time = zero_time) then
				n_state <= DOWN;
				next_time <= zero_time;
			elsif (seqnum_error = '1') then
				n_state <= DOWN;
				next_time <= zero_time;
			elsif (master = '1') then
				if (receiving_complete = '1' and neighbor_more = '0' and more_sig = '0' and p_read = IDLE_R) then
					n_state <= LOADING;
					next_time <= max_time;
				elsif (receiving_complete = '1' and p_read = IDLE_R) then
					n_state <= EXCHANGE_SENDING;
					next_time <= max_time;
				elsif (ID_part = "00" and dbd_val_sig = '1') then
					next_time <= max_time;
					case( p_read ) is
						when IDLE_R =>
							n_state <= p_state;
						when OPTIONS =>
							if (temp_dbd_received(2) = '1') then
								n_state <= DOWN;
							else
								n_state <= p_state;
							end if ;

						when SEQNUM =>
							if (curr_seqnum = temp_dbd_received) then
								n_state <= p_state;
							elsif (init_sig = '1') then
								n_state <= p_state;
							else
								n_state <= DOWN;
							end if ;
						when LSA_PART1 =>
							n_state <= p_state;
						when LSA_PART2 =>
							n_state <= p_state;
						when LSA_PART3 =>
							n_state <= p_state;
						when LSA_PART4 =>
							n_state <= p_state;
						when others => --LSA_PART5
							n_state <= p_state;
					end case ;
				else
					n_state <= p_state;
					next_time <= curr_time - 1;
				end if ;
			else --SLAVE
				if (receiving_complete = '1' and p_read = IDLE_R) then
					n_state <= EXCHANGE_SENDING;
					next_time <= max_time;
				elsif (ID_part = "00" and dbd_val_sig = '1') then
					next_time <= max_time;
					case( p_read ) is
						when IDLE_R =>
							n_state <= p_state;
						when OPTIONS =>
							if (temp_dbd_received(2) = '1') then
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
						when LSA_PART1 =>
							n_state <= p_state;
						when LSA_PART2 =>
							n_state <= p_state;
						when LSA_PART3 =>
							n_state <= p_state;
						when LSA_PART4 =>
							n_state <= p_state;
						when others => --LSA_PART5
							n_state <= p_state;
					end case ;
				else
					n_state <= p_state;
					next_time <= curr_time - 1;
				end if ;
			end if ;

		when LOADING =>
			next_time <= max_time;
			if (lsa_queue_empty = '1') then
				lsa_queue_rd_en <= '0';
				n_state <= FULL;
			else
				lsa_queue_rd_en <= '1';
				n_state <= p_state;
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

SEQSEND : process(clk)
	variable msb : integer;
	variable lsb : integer;

begin
	if (clk = '1' and clk'event) then
		case( p_dbd ) is
			when IDLE =>
				if (p_state = EXSTART) then
					sending_complete <= '0';
					p_dbd <= SENDING_IP;
					msb := 0;
					lsb := 7;
					dbd_outval_sig <= '1';
					dbd_out1 <= IPheader(159 - msb downto 159 - lsb);
					sending_length <= (others => '0');
				elsif (p_state = EXCHANGE_SENDING and sending_complete = '0') then
					if (more_sig = '1') then
						p_dbd <= LSA_WAIT;
						dbd_rd_en <= '1';
						sending_length <= zero7;
						dbd_out1 <= (others => '0');
						dbd_outval_sig <= '0';
					else
						p_dbd <= SENDING_IP;
						msb := 0;
						lsb := 7;
						dbd_outval_sig <= '1';
						dbd_out1 <= IPheader(159 - msb downto 159 - lsb);
						sending_length <= zero7;
					end if;
				else
					p_dbd <= IDLE;
					sending_complete <= '0';
					sending_length <= zero7;
					dbd_out1 <= (others => '0');
					dbd_outval_sig <= '0';
				end if ;
			when LSA_WAIT =>
				if (dbd_valid <= '1') then
					dbd_rd_en <= '0';
					p_dbd <= FETCHING_LSA1;
					msb := 0;
					lsb := 7;
					sending_length <= zero7;
					lsa_packet1(159 - msb downto 159 - lsb) <= dbd_out;
				else
					p_dbd <= LSA_WAIT;
				end if ;
			when FETCHING_LSA1 =>
				if (sending_length = receiving_begin) then
					if (dbd_valid = '1') then
						p_dbd <= FETCHING_LSA2;
						msb := 0;
						lsb := 7;
						sending_length <= zero7;
						lsa_packet2(159 - msb downto 159 - lsb) <= dbd_out;
					else
						p_dbd <= SENDING_IP;
						msb := 0;
						lsb := 7;
						sending_length <= zero7;
						dbd_out1 <= IPheader(159 - msb downto 159 - lsb);
						dbd_outval_sig <= '1';
					end if ;
				else
					msb := conv_integer(sending_length + 1)*8;
					lsb := conv_integer(sending_length + 1)*8 + 7;
					sending_length <= sending_length + 1;
					p_dbd <= FETCHING_LSA1;
					lsa_packet1(159 - msb downto 159 - lsb) <= dbd_out;
				end if ;
			when FETCHING_LSA2 =>
				if (sending_length = receiving_begin) then
					if (dbd_valid = '1') then
						p_dbd <= FETCHING_LSA3;
						msb := 0;
						lsb := 7;
						sending_length <= zero7;
						lsa_packet3(159 - msb downto 159 - lsb) <= dbd_out;
					else
						p_dbd <= SENDING_IP;
						msb := 0;
						lsb := 7;
						sending_length <= zero7;
						dbd_out1 <= IPheader(159 - msb downto 159 - lsb);
						dbd_outval_sig <= '1';
					end if ;
				else
					msb := conv_integer(sending_length + 1)*8;
					lsb := conv_integer(sending_length + 1)*8 + 7;
					sending_length <= sending_length + 1;
					p_dbd <= FETCHING_LSA2;
					lsa_packet2(159 - msb downto 159 - lsb) <= dbd_out;
				end if ;
			when FETCHING_LSA3 =>
				if (sending_length = receiving_begin) then
					p_dbd <= SENDING_IP;
					msb := 0;
					lsb := 7;
					sending_length <= zero7;
					dbd_out1 <= IPheader(159 - msb downto 159 - lsb);
					dbd_outval_sig <= '1';
				else
					msb := conv_integer(sending_length + 1)*8;
					lsb := conv_integer(sending_length + 1)*8 + 7;
					sending_length <= sending_length + 1;
					p_dbd <= FETCHING_LSA3;
					lsa_packet3(159 - msb downto 159 - lsb) <= dbd_out;
				end if ;
			when SENDING_IP =>
				if (sending_length = IPlength) then
					p_dbd <= SENDING_OSPFHEAD;
					msb := 0;
					lsb := 7;
					sending_length <= zero7;
					dbd_out1 <= ospfheader(191 - msb downto 191 - lsb);
					dbd_outval_sig <= '1';
				else
					p_dbd <= SENDING_IP;
					msb := conv_integer(sending_length + 1)*8;
					lsb := conv_integer(sending_length + 1)*8 + 7;
					sending_length <= sending_length + 1;
					dbd_out1 <= IPheader(159 - msb downto 159 - lsb);
					dbd_outval_sig <= '1';
				end if ;
			when SENDING_OSPFHEAD =>
				if (sending_length = ospflength) then
					p_dbd <= SENDING_DBD;
					msb := 0;
					lsb := 7;
					sending_length <= zero7;
					dbd_out1 <= dbd_packet(543 - msb downto 543 - lsb);
					dbd_outval_sig <= '1';
				else
					p_dbd <= SENDING_OSPFHEAD;
					msb := conv_integer(sending_length + 1)*8;
					lsb := conv_integer(sending_length + 1)*8 + 7;
					sending_length <= sending_length + 1;
					dbd_out1 <= ospfheader(191 - msb downto 191 - lsb);
					dbd_outval_sig <= '1';
				end if ;
			when others => --SENDING_DBD
				if (sending_length = dbd_length) then
					p_dbd <= IDLE;
					dbd_out1 <= (others => '0');
					dbd_outval_sig <= '0';
					sending_complete <= '1';
				else
					p_dbd <= SENDING_DBD;
					msb := conv_integer(sending_length + 1)*8;
					lsb := conv_integer(sending_length + 1)*8 + 7;
					sending_length <= sending_length + 1;
					dbd_out1 <= dbd_packet(543 - msb downto 543 - lsb);
					dbd_outval_sig <= '1';
				end if ;

		end case ;
	end if ;
end process;
---------- SENDING DBD STATE MACHINE --------
--COMBDBD : process(p_state, p_dbd, sending_length, dbd_length)
--begin
--	case( p_dbd ) is
--		when IDLE =>
--			if (p_state = EXSTART) then
--				n_dbd <= SENDING_IP;
--				sending_len_next <= IPlength;
--				next_enable <= '0';
--			elsif (p_state = EXCHANGE_SENDING) then
--				if (more_sig = '1') then
--					n_dbd <= FETCHING_LSA;
--					next_enable <= '1';
--				else
--					n_dbd <= SENDING_IP;				
--					next_enable <= '0';
--				end if ;
--				sending_len_next <= zero7;
--			else
--				n_dbd <= p_dbd;
--				sending_len_next <= zero7;
--				next_enable <= '0';
--			end if ;
--		when FETCHING_LSA =>
--			if (receiving_lsa = receiving_begin) then
--				next_enable <= '1';
--				n_dbd <= FETCHING_LSA;
--			elsif (dbd_valid = '0') then
--				next_enable <= '1';
--				n_dbd <= SENDING_IP;
--			else
--				next_enable <= '0';
--				n_dbd <= FETCHING_LSA;
--			end if ;
--			--n_dbd <= SENDING_IP;
--			--sending_len_next <= IPlength;
--		when SENDING_IP =>
--			next_enable <= '0';
--			if (sending_length = zero7) then
--				n_dbd <= SENDING_OSPFHEAD;
--				sending_len_next <= ospflength;
--			else
--				n_dbd <= p_dbd;
--				sending_len_next <= sending_length - 1;
--			end if ;
--		when SENDING_OSPFHEAD =>
--			next_enable <= '0';
--			if (sending_length = zero7) then
--				n_dbd <= SENDING_DBD;
--				sending_len_next <= dbd_length;
--			else
--				n_dbd <= p_dbd;
--				sending_len_next <= sending_length - 1;
--			end if ;
--		when others => --SENDING_DBD
--			next_enable <= '0';
--			if (sending_length = zero7) then
--				n_dbd <= IDLE;
--				sending_len_next <= zero7;
--			else
--				n_dbd <= p_dbd;
--				sending_len_next <= sending_length - 1;
--			end if;
--	end case ;
--end process;
----------------------------------


-------- READING DBD STATE MACHINE --------
SEQREAD : process(clk)
begin
	if (clk = '1' and clk'event) then
		if (ID_part = "00" and dbd_val = '1') then
			case( p_read ) is
				when IDLE_R =>
					p_read <= OPTIONS;
				when OPTIONS =>
					p_read <= SEQNUM;
				when SEQNUM =>
					p_read <= LSA_PART1;
				when LSA_PART1 =>
					p_read <= LSA_PART2;
				when LSA_PART2 =>
					p_read <= LSA_PART3;
				when LSA_PART3 =>
					p_read <= LSA_PART4;
				when LSA_PART4 =>
					p_read <= LSA_PART5;
				when others =>
					p_read <= LSA_PART1;
			end case ;
		elsif (dbd_val = '0') then
			-- LET THE STATE MACHINE KNOW READING IS COMPLETE
			p_read <= IDLE_R;
		end if ;
	end if ;
end process;
----------------------------------------

stateout <= "000" when p_state = DOWN else
				"001" when p_state = INIT else
				"010" when p_state = ONE_WAY else
				"011" when p_state = EXSTART else
				"100" when p_state = EXCHANGE_LISTENING else
				"101" when p_state = EXCHANGE_SENDING else
				"110" when p_state = LOADING else
				"111";
out1 <= dbd_out1 when dbd_outval_sig = '1' else
		lsr_out1 when lsr_outval_sig = '1' else
		(others => '0');

lsr_outval <= lsr_outval_sig;
dbd_outval <= dbd_outval_sig;

end Behavioral;
