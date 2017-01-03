library IEEE, LFSR, STD;
use IEEE.std_logic_1164.all;
use LFSR.components.all;
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

        write(JLINE, string'("<?xml version=""1.0"" encoding=""UTF-8"" ?>"));
        writeline(JFILE, JLINE);

        if (FINISHED-STARTED) /= C_EXPECTED_TIME then
            assert false report "[FAIL] Incorrect pulse period" severity failure;
            write(JLINE, string'("<testsuites id=""pulse_tb"" name=""Pulse TB"" tests=""1"" failures=""1"">"));
            writeline(JFILE, JLINE);
        else
            assert false report "[PASS]" severity note;
            write(JLINE, string'("<testsuites id=""main"" name=""Main"" tests=""1"" failures=""0"">"));
            writeline(JFILE, JLINE);
            write(JLINE, string'("<testsuite id=""pulse_tb"" name=""Pulse TB"" tests=""1"" failures=""0"">"));
            writeline(JFILE, JLINE);
            write(JLINE, string'("<testcase id=""period"" name=""Period"">"));
            writeline(JFILE, JLINE);
            write(JLINE, string'("</testcase>"));
            writeline(JFILE, JLINE);
            write(JLINE, string'("</testsuite>"));
            writeline(JFILE, JLINE);
            write(JLINE, string'("</testsuites>"));
            writeline(JFILE, JLINE);
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