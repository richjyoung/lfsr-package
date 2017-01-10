library IEEE, LFSR;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use LFSR.lfsr.all;
--------------------------------------------------------------------------------
entity pulse is
    generic (
        G_lfsr_width    : natural := 17;
        G_period        : natural := 10000
    );
    port(
        CLK             : in  std_logic;
        RESET           : in  std_logic;
        PULSE           : out std_logic
    );
end pulse;
--------------------------------------------------------------------------------
architecture rtl of pulse is
    subtype T_LFSR          is std_logic_vector(G_lfsr_width-1 downto 0);
    constant C_ZERO         : T_LFSR := (others => '0');
    constant C_LFSR_RESET   : T_LFSR := lfsr_evaluate(G_lfsr_width, G_period-1);
    signal LFSR             : T_LFSR;
begin

    PULSE                   <= '1' when LFSR = C_ZERO else '0';

    lfsr_proc: process (CLK) is
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                LFSR        <= C_ZERO; -- XNOR LFSR requires zero reset
            else
                lfsr_advance(LFSR, C_LFSR_RESET);
            end if;
        end if;
    end process lfsr_proc;

end rtl;