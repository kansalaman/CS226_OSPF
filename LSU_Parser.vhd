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

entity LSU_Parser is
    Generic
    (
        PORT_NO : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
        router_id : std_logic_vector(31 downto 0) := "11110011000000000000000000000000"
    );
    Port ( state_in : in  STD_LOGIC_VECTOR (3 downto 0);
           data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           data_valid : in  STD_LOGIC;
		   clk : in std_logic;
           write_to_q : out  STD_LOGIC;
           qout : out  STD_LOGIC_VECTOR (7 downto 0);
           ack_q_out : out STD_LOGIC_VECTOR(7 downto 0);
           ack_q_val : out std_logic);
end LSU_Parser;

architecture Behavioral of LSU_Parser is
type states is (IDLE,LSU_strip,sendLSA,dumpLSU,dumpLSA);
signal state_in_int : integer:=0;
signal p_state,n_state : states := IDLE;
signal p_counter,n_counter : integer:= 0;
signal processed_bytes : integer := 0;
signal packet_length_int : integer := 0;
signal data_to_LSAq : std_logic_vector(7 downto 0) := (others => '0');
signal write_to_LSAq : std_logic := '0';
signal ack_data_out : std_logic_vector(7 downto 0) := (others => '0');
signal write_ack : std_logic := '0';
signal lsa_length : std_logic_vector(15 downto 0) := (others => '1');
signal ospf_header : std_logic_vector(191 downto 0);
signal lsa_length_int : integer := 0;
--signal ack_packet_length : std_logic_vector(15 downto 0) := (others => '0');
--signal ack_packet_length_int : integer;
signal packet_length : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
begin
--ospf_header(191 downto 184) <= '0';
ospf_header(183 downto 176) <= "00000101";
--ospf_header(175 downto 160) <= conv_std_logic_vector(ack_packet_length_int*20+24,16);
ospf_header(159 downto 128) <= router_id;
--ospf_header(127 downto 0) <= '0';


--ack_packet_length_int <= conv_integer(ack_packet_length);
state_in_int <= conv_integer(state_in);
packet_length_int <= conv_integer(packet_length);
lsa_length_int <= conv_integer(lsa_length);
process(clk)
    variable current_byte_no : integer;
    variable current_state : states;
begin
    if(clk'event and clk='1') then
        current_byte_no := n_counter;
        current_state := n_state;
        p_counter <= n_counter;
        p_state <= n_state;

        

        -- if(current_state=LSU_strip and current_byte_no=25) then
        --     ack_packet_length(31 downto 24) <= data_in;
        --     write_ack <= '1';
        --     ack_data_out <= data_in;
        -- elsif(current_state=LSU_strip and current_byte_no=26) then
        --     ack_packet_length(23 downto 16) <= data_in;
        --     write_ack <= '1';
        --     ack_data_out <=data_in;
        -- elsif(current_state=LSU_strip and current_byte_no=27) then
        --     ack_packet_length(15 downto 8) <= data_in;
        --     write_ack <= '1';
        --     ack_data_out <= data_in;
        -- elsif(current_state=LSU_strip and current_byte_no=28) then
        --     ack_data_out <= data_in;
        --     write_ack <= '1';
        --     ack_packet_length(7 downto 0) <= data_in;
        -- else
        --     write_ack<='0';
        --     ack_data_out <= "00000000"
        -- end if;
            
        -- if(current_state=sendLSA and current_byte_no>=1 and current_byte_no<=20) then
        --     ack_data_out <= data_

        --code here writes to LSAq

        --just remove an or here
        if((current_state=sendLSA and current_byte_no>=1 and current_byte_no<=20)) then
            write_ack <= '1';
            ack_data_out <= data_in;
        else
            write_ack<='0';
            ack_data_out <= "00000000";
        end if;


        --code here sends out LSA in a q
        if(current_state=sendLSA and current_byte_no/=3) then
            data_to_LSAq <= data_in;
            write_to_LSAq <= '1';
        elsif(current_state=sendLSA and current_byte_no=3) then
            data_to_LSAq <= PORT_NO;
            write_to_LSAq <= '1';
        else
            data_to_LSAq <= "00000000";
            write_to_LSAq <= '0';
        end if;
        
        --code here judges lsa_length
        if(current_state=sendLSA and current_byte_no=19) then
            lsa_length(15 downto 8) <= data_in;
        elsif(current_state=sendLSA and current_byte_no=20) then
            lsa_length(7 downto 0) <= data_in;
        
        end if;

        --calculating processed bytes
        if(current_state=IDLE) then
            processed_bytes <= 0;
        elsif((current_state=LSU_strip or current_state=dumpLSU) and current_byte_no=1) then
            processed_bytes <= 1;
        else
            processed_bytes <= processed_bytes+1;
        end if;

        --calculating complete ospf packet length
        if((current_state=LSU_strip or current_state=dumpLSU) and current_byte_no=3) then
            packet_length(15 downto 8) <= data_in;
        elsif((current_state=LSU_strip or current_state=dumpLSU) and current_byte_no=4) then
            packet_length(7 downto 0) <= data_in;
        end if;
    end if;
end process;


COMB2: process(write_ack,ack_data_out)
begin
    ack_q_out <= ack_data_out;
    ack_q_val <= write_ack;
end process;


COMB1:process(write_to_LSAq,data_to_LSAq)
begin
    write_to_q <= write_to_LSAq;
    qout <= data_to_LSAq;
end process;

COMB:process(data_valid,p_state,state_in_int,p_counter,processed_bytes,packet_length_int,lsa_length_int)
begin
    case p_state is
        when IDLE =>
            if(data_valid = '1' and state_in_int>=4 and state_in_int<=7) then
                n_state <= LSU_strip;
                n_counter <= 1;
            elsif (data_valid = '1') then
                n_state <= dumpLSU;
                n_counter <= 1;
            else
                n_state <= IDLE;
                n_counter <= 0;
            end if;
        
        when dumpLSU =>

        if(data_valid <= '0') then
            n_state <= IDLE;
            n_counter <= 0;
        else

            if(p_counter=28) then
                n_state <= dumpLSA;
                n_counter <= 1;
            else
                n_state <= p_state;
                n_counter <= p_counter+1;
            end if;
        end if;

        when dumpLSA =>
            if(processed_bytes = packet_length_int or data_valid='0') then
                if(data_valid = '1' and state_in_int>=4 and state_in_int<=7) then
                    n_state <= LSU_strip;
                    n_counter <= 1;
                elsif(data_valid = '1') then
                    n_state <= dumpLSU;
                    n_counter <= 1;
                else
                    n_state <= IDLE;
                    n_counter <= 0;
                end if;
            -- elsif(p_counter=lsa_length_int) then
            --     n_state <= p_state;
            --     n_counter <= 1;
            else
                n_state <= p_state;
                n_counter <= p_counter+1;
            end if;
            
        when LSU_strip =>
            if(data_valid <= '0') then
                n_state <= IDLE;
                n_counter <= 0;
            else
                if(p_counter=28) then
                    n_state <= sendLSA;
                    n_counter <= 1;
                else
                    n_state <= p_state;
                    n_counter <= p_counter+1;
                end if;
            end if;
        when sendLSA =>
            
            if(processed_bytes = packet_length_int or data_valid='0') then
                if(data_valid = '1' and state_in_int>=4 and state_in_int<=7) then
                    n_state <= LSU_strip;
                    n_counter <= 1;
                elsif(data_valid='1') then
                    n_state <= dumpLSU;
                    n_counter <= 1;
                else
                    n_state <= IDLE;
                    n_counter <= 0;
                end if;
            elsif(p_counter=lsa_length_int) then
                n_state <= p_state;
                n_counter <= 1;
            else
                n_state <= p_state;
                n_counter <= p_counter+1;
            end if;

        when others =>
                null;
        end case;
end process;






end Behavioral;

