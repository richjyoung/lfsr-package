library IEEE, LFSR;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use LFSR.lfsr.all;
--------------------------------------------------------------------------------
entity pulse_shreg is
    generic (
        G_period        : natural := 10000
    );
    port(
        CLK             : in  std_logic;
        RESET           : in  std_logic;
        PULSE           : out std_logic
    );
end pulse_shreg;
--------------------------------------------------------------------------------
architecture rtl of pulse_shreg is
    subtype T_SHIFTREG      is std_logic_vector(G_period-1 downto 0);
    constant C_ZERO         : T_SHIFTREG := (0 => '1', others => '0');
    signal SHIFTREG         : T_SHIFTREG;
begin

    PULSE                   <= '1' when SHIFTREG = C_ZERO else '0';

    shreg_proc: process (CLK) is
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                SHIFTREG    <= C_ZERO;
            else
                SHIFTREG    <= SHIFTREG(G_period-2 downto 0) & SHIFTREG(G_period-1);
            end if;
        end if;
    end process shreg_proc;

end rtl;