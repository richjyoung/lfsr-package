library IEEE, LFSR;
use IEEE.std_logic_1164.all;
use LFSR.components.all;
--------------------------------------------------------------------------------
entity pulse_tb is
end pulse_tb;
--------------------------------------------------------------------------------
architecture tb of pulse_tb is

    constant C_PERIOD : time := 10 ns;
    constant C_EXPECTED : natural := 7;
    constant C_EXPECTED_TIME : time := C_PERIOD * C_EXPECTED;

    signal CLK  : std_logic;
    signal RESET  : std_logic;
    signal P  : std_logic;

begin

    stim_proc: process
        variable STARTED  : time;
        variable FINISHED : time;
    begin
        RESET <= '1';
        wait for C_PERIOD * 10;
        RESET <= '0';

        wait until rising_edge(P);
        STARTED := now;

        wait until rising_edge(P);
        FINISHED := now;
        if (FINISHED-STARTED) /= C_EXPECTED_TIME then
            assert false report "[FAIL] Incorrect pulse period" severity failure;
        else
            assert false report "[PASS]" severity note;
        end if;

        wait for C_PERIOD * 10;
        assert false report "SIMULATION FINISHED" severity failure;

        wait;
    end process stim_proc;

    clk_proc: process
    begin
        CLK     <= '0';
        wait for C_PERIOD / 2;
        CLK     <= '1';
        wait for C_PERIOD / 2;
    end process clk_proc;

    U_UUT: pulse
    generic map (
        G_lfsr_width    => 3,
        G_period        => 1
    )
    port map (
        CLK             => CLK,
        RESET           => RESET,
        PULSE           => P
    );

end tb;