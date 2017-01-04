library IEEE, JUNIT_TB, LFSR, STD;
use IEEE.std_logic_1164.all;
use JUNIT_TB.junit.all;
use LFSR.lfsr_components.all;
use STD.textio.all;
--------------------------------------------------------------------------------
entity pulse_tester is
    generic (
        G_lfsr_width    : natural := 3;
        G_period        : natural := 7;
        G_expected      : time    := 70 ns
    );
    port(
        CLK             : in  std_logic;
        RESET           : in  std_logic;
        GO              : in  std_logic;
        DONE            : out std_logic;
        PASS_nFAIL      : out std_logic;
        RUNTIME         : out time
    );
end pulse_tester;
--------------------------------------------------------------------------------
architecture tb of pulse_tester is

    signal P            : std_logic;

begin

    stim_proc: process
        variable V_STARTED      : time;
        variable V_FINISHED     : time;
        variable V_RUNTIME      : time;
    begin
        DONE            <= '0';
        PASS_nFAIL      <= '0';
        wait until GO = '1';

        wait until rising_edge(P);
        V_STARTED       := now;

        wait until rising_edge(P);
        V_FINISHED      := now;

        V_RUNTIME       := V_FINISHED - V_STARTED;
        RUNTIME         <= V_RUNTIME;

        if V_RUNTIME = G_expected then
            PASS_nFAIL  <= '1';
        end if;

        DONE            <= '1';
        wait;

    end process stim_proc;

    U_UUT: pulse
    generic map (
        G_lfsr_width    => G_lfsr_width,
        G_period        => G_period
    )
    port map (
        CLK             => CLK,
        RESET           => RESET,
        PULSE           => P
    );

end tb;