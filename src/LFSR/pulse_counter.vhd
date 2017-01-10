library IEEE, LFSR;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--------------------------------------------------------------------------------
entity pulse_counter is
    generic (
        G_counter_width : natural := 17;
        G_period        : natural := 10000
    );
    port(
        CLK             : in  std_logic;
        RESET           : in  std_logic;
        PULSE           : out std_logic
    );
end pulse_counter;
--------------------------------------------------------------------------------
architecture rtl of pulse_counter is
    subtype T_COUNTER       is unsigned(G_counter_width-1 downto 0);
    constant C_ZERO         : T_COUNTER := (others => '0');
    signal COUNTER          : T_COUNTER;
begin

    PULSE                   <= '1' when COUNTER = C_ZERO else '0';

    counter_proc: process (CLK) is
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                COUNTER     <= C_ZERO;
            else
                if to_integer(COUNTER) = G_period-1 then
                    COUNTER     <= C_ZERO;
                else
                    COUNTER     <= COUNTER + 1;
                end if;
            end if;
        end if;
    end process counter_proc;

end rtl;