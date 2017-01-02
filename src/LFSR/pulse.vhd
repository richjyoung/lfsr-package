library IEEE, LFSR;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use LFSR.lfsr.all;
--------------------------------------------------------------------------------
entity pulse is
    generic (
        G_lfsr_width : natural := 3;
        G_stop : natural := 2
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
    constant C_STOP : std_logic_vector(G_lfsr_width-1 downto 0) := lfsr_val(G_lfsr_width, G_stop);
begin

    pulse_proc: process (CLK) is
        variable LFSR : std_logic_vector(G_lfsr_width-1 downto 0);
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                PULSE       <= '0';
                LFSR        := (others => '0');
            else
                if LFSR = C_STOP then
                    PULSE   <= '1';
                else
                    PULSE   <= '0';
                end if;
                lfsr_adv(LFSR, C_STOP);
            end if;
        end if;
    end process pulse_proc;

end rtl;