library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;

entity Parser is
    Port ( in1 : in  STD_LOGIC_VECTOR (7 downto 0);
           validity : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           out1 : out  STD_LOGIC_VECTOR (7 downto 0);
           hello_out : out  STD_LOGIC;
           ls_out : out  STD_LOGIC;
           telling_lsu : out std_logic;
           telling_dd : out std_logic;
           telling_plen : out std_logic;
        --    packet_len_valid: out STD_LOGIC;
           telling_rid: out std_logic;
           telling_lsr : out std_logic;
           telling_neighbour: out std_logic;
           full_size_len: out std_logic_vector(15 downto 0));
end Parser;

architecture Behavioral of Parser is
signal typePacket : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal packet_length : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal packet_length_int : integer := 0;
signal processed_bytes : integer := 0;
signal p_counter, n_counter : INTEGER := 0;
type states is (IDLE, IP_STRIP, OSPF_STRIP, HELLO, DD,LSR,LSU,LS);
signal p_state, n_state : states := IDLE;
begin
packet_length_int <= to_integer(unsigned(packet_length));
full_size_len <= packet_length;
process(clk)
    variable current_byte_no : INTEGER;
    variable current_state : states; 
begin
    if (clk'event and clk = '1') then
        out1 <= in1;
        current_byte_no := n_counter;
        current_state := n_state;
        p_counter <= n_counter;
        p_state <= n_state;

        -- if(current_state=)
        if(current_state=OSPF_STRIP or current_state=LSU) then
            telling_lsu <= '1';
        else
            telling_lsu <= '0';
        end if;

        
        if(current_state=LSR) then
            telling_lsr <= '1';
        else
            telling_lsr <= '0';
        end if;
            
        if(current_state=DD) then
            telling_dd <= '1';
        else
            telling_dd <= '0';
        end if;


        if(current_state=IDLE or current_state=IP_STRIP) then
            processed_bytes <= 0;
        else
            processed_bytes <= processed_bytes+1;
        end if;

        if(current_state=HELLO and current_byte_no>=21 and current_byte_no<=24) then
            telling_neighbour <= '1';
        else
            telling_neighbour <= '0';
        end if;

        if(current_state=OSPF_STRIP and current_byte_no>=5 and current_byte_no<=8) then
            telling_rid <= '1';
        else
            telling_rid <= '0';
        end if;

        if(current_state=OSPF_STRIP and current_byte_no=2) then
            typePacket <= in1;
        end if;



        if(current_state=OSPF_STRIP and current_byte_no=3) then
            packet_length(15 downto 8) <= in1;
            if(typePacket="00000011") then
                telling_plen <= '0';
            else
                telling_plen <= '0';
            end if;
                
            -- packet_length_int <= to_integer(unsigned(pac))
        elsif(current_state=OSPF_STRIP and current_byte_no=4) then
            packet_length(7 downto 0) <= in1;
            if(typePacket="00000011") then
                telling_plen <= '1';
            else
                telling_plen <= '0';
            end if;
        else
            telling_plen <= '0';
        end if;

        

        if(current_state = HELLO) then
            hello_out <= '1';
        else
            hello_out <= '0';
        end if;
        
        if (current_state = LS) then
            ls_out <= '1';
        else
            ls_out <= '0';
        end if;
    end if;
end process;


COMB: process(validity, p_state, in1, p_counter, typepacket, packet_length,processed_bytes,packet_length_int)

begin
    case p_state is
        when IDLE =>
            if(validity = '1') then
                n_state <= IP_STRIP;
                n_counter <= 1;
            else
                n_state <= IDLE;
                n_counter <= 0;
            end if;
        
        when IP_STRIP =>
            if (p_counter = 20) then
                n_state <= OSPF_STRIP;
                n_counter <= 1;
            else
                n_state <= IP_STRIP;
                n_counter <= p_counter + 1;
            end if;
            
        when OSPF_STRIP =>
            -- if(p_counter=24) then

                if (typePacket = "00000001" and p_counter = 24) then
                    n_state <= HELLO;
                    n_counter <= 1;
                
                elsif(typePacket = "00000010" and p_counter = 24) then
                    n_state <= DD;
                    n_counter <= 1;
                
                elsif(typePacket = "00000011" and p_counter = 24) then
                    n_state <= LSR;
                    n_counter <= 1;

                elsif (typePacket = "00000100" and p_counter=28) then
                    n_state <= LSU;
                    n_counter <= 1;

                elsif(typePacket = "00000101" and p_counter=24) then
                    n_state <= LS;
                    n_counter <= 1;
                else
                    n_state <= p_state;
                    n_counter<= p_counter+1;
                end if;

        
        when HELLO =>
                    if(validity = '0') then
                        n_state <= IDLE;
                        n_counter <= 0;
                    elsif(processed_bytes = packet_length_int) then
                        n_state <= IP_STRIP;
                        n_counter <= 1;
                    elsif(p_counter=24) then
                        n_state <= p_state;
                        n_counter <= 21;
                    else
                        n_state <= p_state;
                        n_counter <= p_counter+1;
                    end if;

        when DD =>
                    if(validity = '0') then
                        n_state <= IDLE;
                        n_counter <= 0;
                    elsif(processed_bytes = packet_length_int) then
                        n_state <= IP_STRIP;
                        n_counter <= 1;
                    else
                        n_state <= p_state;
                        n_counter <= p_counter+1;
                    end if;
        when LSR =>
                    if(validity = '0') then
                        n_state <= IDLE;
                        n_counter <= 0;
                    elsif(processed_bytes = packet_length_int) then
                        n_state <= IP_STRIP;
                        n_counter <= 1;
                    else
                        n_state <= p_state;
                        n_counter <= p_counter+1;
                    end if;
        when LSU =>
                    if(validity = '0') then
                        n_state <= IDLE;
                        n_counter <= 0;
                    elsif(processed_bytes = packet_length_int) then
                        n_state <= IP_STRIP;
                        n_counter <= 1;
                    else
                        n_state <= p_state;
                        n_counter <= p_counter+1;
                    end if;
        when LS =>
                    if(validity = '0') then
                        n_state <= IDLE;
                        n_counter <= 0;
                    elsif(processed_bytes = packet_length_int) then
                        n_state <= IP_STRIP;
                        n_counter <= 1;
                    else
                        n_state <= p_state;
                        n_counter <= p_counter+1;
                    end if;
    end case;
end process;



end Behavioral;

        
        