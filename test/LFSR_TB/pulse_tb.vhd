library IEEE, JUNIT_TB, LFSR, STD;
use IEEE.std_logic_1164.all;
use JUNIT_TB.junit.all;
use LFSR.lfsr_components.all;
use STD.textio.all;
--------------------------------------------------------------------------------
entity pulse_tb is
end pulse_tb;
--------------------------------------------------------------------------------
architecture tb of pulse_tb is

    constant C_PERIOD           : time      := 10 ns;
    constant C_EXPECTED         : natural   := 7;
    constant C_EXPECTED_TIME    : time      := C_PERIOD * C_EXPECTED;

    signal CLK                  : std_logic;
    signal RESET                : std_logic;
    signal P                    : std_logic;

begin

    stim_proc: process
        variable STARTED  : time;
        variable FINISHED : time;
        variable OUTLINE  : line;
        variable RUNTIME : real;
        file JFILE   : text open write_mode is "junit.xml";
        variable JLINE  : line;
    begin
        write(OUTLINE, string'("[+] Asserting Reset"));
        writeline(OUTPUT, OUTLINE);
        RESET       <= '1';

        wait for C_PERIOD * 10;
        write(OUTLINE, string'("[+] Releasing Reset"));
        writeline(OUTPUT, OUTLINE);
        RESET       <= '0';

        wait until rising_edge(P);
        write(OUTLINE, string'("[+] ("));
        write(OUTLINE, now);
        write(OUTLINE, string'(") First rising edge"));
        writeline(OUTPUT, OUTLINE);
        STARTED     := now;

        wait until rising_edge(P);
        write(OUTLINE, string'("[+] ("));
        write(OUTLINE, now);
        write(OUTLINE, string'(") Second rising edge"));
        writeline(OUTPUT, OUTLINE);
        FINISHED    := now;
        write(OUTLINE, string'("[+] ("));
        write(OUTLINE, FINISHED-STARTED);
        write(OUTLINE, string'(") Measured duration"));
        writeline(OUTPUT, OUTLINE);

        junit_xml_declaration(JFILE);

        if (FINISHED-STARTED) /= C_EXPECTED_TIME then
            assert false report "[FAIL] Incorrect pulse period" severity failure;
        else
            assert false report "[PASS]" severity note;

            RUNTIME := real((FINISHED-STARTED)/(1 fs)) / 1.0e15;
            --RUNTIME := 0.000000070;
            write(OUTLINE, RUNTIME);
            writeline(OUTPUT, OUTLINE);
            junit_start_testsuites(JFILE, "main", "Main", 1, 0, RUNTIME);
            junit_start_testsuite(JFILE, "pulse_tb", "Pulse TB", 1, 0, RUNTIME);
            junit_testcase(JFILE, "period", "Period", RUNTIME);
            junit_end_testsuite(JFILE);
            junit_end_testsuites(JFILE);
        end if;

        wait for C_PERIOD * 10;

        file_close(JFILE);

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
        G_period        => 7
    )
    port map (
        CLK             => CLK,
        RESET           => RESET,
        PULSE           => P
    );

end tb;