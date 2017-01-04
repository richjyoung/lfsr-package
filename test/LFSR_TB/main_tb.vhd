library IEEE, JUNIT_TB, LFSR, LFSR_TB, STD;
use IEEE.std_logic_1164.all;
use JUNIT_TB.junit.all;
use LFSR.lfsr_components.all;
use LFSR.lfsr.all;
use LFSR_TB.lfsr_tb_components.all;
use LFSR_TB.main_tb_pkg.all;
use STD.textio.all;
--------------------------------------------------------------------------------
entity main_tb is
end main_tb;
--------------------------------------------------------------------------------
architecture tb of main_tb is

    constant C_PERIOD           : time      := 10 ns;
    constant TESTSUITE          : T_TESTSUITE := (
        0 => (
            NAME        => "3 bit max period                                  ",
            L_NAME      => 16,
            BITS        => 3,
            PERIOD      => lfsr_maximum(3),
            EXPECTED    => 70 ns
        ),
        1 => (
            NAME        => "3 bit period 2                                    ",
            L_NAME      => 14,
            BITS        => 3,
            PERIOD      => 2,
            EXPECTED    => 20 ns
        ),
        2 => (
            NAME        => "3 bit max-1 period                                ",
            L_NAME      => 18,
            BITS        => 3,
            PERIOD      => lfsr_maximum(3)-1,
            EXPECTED    => 60 ns
        ),
        3 => (
            NAME        => "4 bit max period                                  ",
            L_NAME      => 16,
            BITS        => 4,
            PERIOD      => lfsr_maximum(4),
            EXPECTED    => 150 ns
        ),
        4 => (
            NAME        => "4 bit period 2                                    ",
            L_NAME      => 14,
            BITS        => 4,
            PERIOD      => 2,
            EXPECTED    => 20 ns
        ),
        5 => (
            NAME        => "4 bit max-1 period                                ",
            L_NAME      => 18,
            BITS        => 4,
            PERIOD      => lfsr_maximum(4)-1,
            EXPECTED    => 140 ns
        )
    );
    signal RESULTS              : T_TESTRESULTS;
    signal CLK                  : std_logic;
    signal RESET                : std_logic := '1';
    signal FINISHED             : std_logic;
    signal GO                   : std_logic := '0';
begin

    FINISHED                <= done(RESULTS);

    stim_proc: process
        file JFILE   : text open write_mode is "main_tb_junit.xml";
        variable JLINE  : line;
        variable V_STARTED      : time;
        variable V_FINISHED     : time;
    begin
        RESET       <= '1';
        GO          <= '0';
        wait until rising_edge(CLK);
        wait until rising_edge(CLK);
        wait until rising_edge(CLK);
        wait until rising_edge(CLK);
        wait until rising_edge(CLK);
        RESET       <= '0';
        wait until rising_edge(CLK);
        GO          <= '1';
        V_STARTED   := now;

        wait until FINISHED = '1';
        V_FINISHED  := now;

        junit_xml_declaration(JFILE);
        junit_start_testsuites(JFILE, "main", "Main", C_TESTCASES, failures(RESULTS), real((V_FINISHED-V_STARTED)/(1 fs)) / 1.0e15);
        junit_start_testsuite(JFILE, "main_tb", "Main TB", 1, 0, real((V_FINISHED-V_STARTED)/(1 fs)) / 1.0e15);

        for I in TESTSUITE'range loop
            junit_start_testcase(JFILE, integer'image(I), TESTSUITE(I).NAME(1 to TESTSUITE(I).L_NAME), real((RESULTS(I).RUNTIME)/(1 fs)) / 1.0e15);
            if RESULTS(I).PASS_nFAIL = '0' then
                junit_failure(JFILE, "period_error", time'image(RESULTS(I).RUNTIME));
            end if;
            junit_end_testcase(JFILE);
        end loop;

        junit_end_testsuite(JFILE);
        junit_end_testsuites(JFILE);

        wait for C_PERIOD * 10;
        assert false report "SIMULATION FINISHED" severity failure;
        wait;
    end process stim_proc;


    G_UUT: for I in 0 to C_TESTCASES-1 generate
        U_UUT: pulse_tester
        generic map (
            G_lfsr_width    => TESTSUITE(I).BITS,
            G_period        => TESTSUITE(I).PERIOD,
            G_expected      => TESTSUITE(I).EXPECTED
        )
        port map (
            CLK             => CLK,
            RESET           => RESET,
            GO              => GO,
            DONE            => RESULTS(I).DONE,
            PASS_nFAIL      => RESULTS(I).PASS_nFAIL,
            RUNTIME         => RESULTS(I).RUNTIME
        );
    end generate;


    clk_proc: process
    begin
        CLK     <= '0';
        wait for C_PERIOD / 2;
        CLK     <= '1';
        wait for C_PERIOD / 2;
    end process clk_proc;

end tb;