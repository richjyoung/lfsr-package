library IEEE, LFSR;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use LFSR.lfsr.all;
--------------------------------------------------------------------------------
entity pulse is
    generic (
        G_lfsr_width : natural := 3;
        G_period : natural := 6
    );
    port(
        CLK     : in  std_logic;
        RESET   : in  std_logic;
        PULSE   : out std_logic
    );
end pulse;
--------------------------------------------------------------------------------
architecture rtl of pulse is
    constant C_ZERO : std_logic_vector(G_lfsr_width-1 downto 0) := (others => '0');
    constant C_LFSR_RESET : std_logic_vector(G_lfsr_width-1 downto 0) := lfsr_eval(G_lfsr_width, G_period-1);
    signal LFSR : std_logic_vector(G_lfsr_width-1 downto 0);
begin

    PULSE <= '1' when LFSR = C_ZERO else '0';

    pulse_proc: process (CLK) is
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                LFSR        <= (others => '0');
            else
                lfsr_adv(LFSR, C_LFSR_RESET);
            end if;
        end if;
    end process pulse_proc;

end rtl;