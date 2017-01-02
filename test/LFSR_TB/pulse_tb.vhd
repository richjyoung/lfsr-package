library IEEE, LFSR;
use IEEE.std_logic_1164.all;
use LFSR.components.all;
--------------------------------------------------------------------------------
entity pulse_tb is
end pulse_tb;
--------------------------------------------------------------------------------
architecture tb of pulse_tb is

    constant C_PERIOD : time := 10 ns;

    signal CLK  : std_logic;
    signal RESET  : std_logic;
    signal P  : std_logic;

begin

    stim_proc: process
    begin
        RESET <= '1';
        wait until rising_edge(CLK);
        wait for C_PERIOD * 10;
        RESET <= '0';
        wait until rising_edge(P);
        assert false report "Pulse Rising Edge" severity note;
        wait until rising_edge(P);
        assert false report "Pulse Rising Edge" severity note;
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
    port map (
        CLK     => CLK,
        RESET   => RESET,
        PULSE   => P
    );

end tb;