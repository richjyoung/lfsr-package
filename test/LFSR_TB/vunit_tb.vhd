library IEEE, LFSR, STD, vunit_lib;
context vunit_lib.vunit_context;
use IEEE.std_logic_1164.all;
use LFSR.lfsr.all;
use STD.textio.all;
--------------------------------------------------------------------------------
entity vunit_tb is
    generic (runner_cfg : string);
end vunit_tb;
--------------------------------------------------------------------------------
architecture tb of vunit_tb is

    signal clk : std_logic := '0';

    type t_max_ints is array(3 to 31) of natural;
    constant c_max_ints : t_max_ints := (
        7, 15, 31, 63,
        127, 255, 511, 1023,
        2047, 4095, 8191, 16383,
        32767, 65535, 131071, 262143,
        524287, 1048575, 2097151, 4194303,
        8388607, 16777215, 33554431, 67108863,
        134217727, 268435455, 536870911, 1073741823,
        2147483647
    );
    
    signal lfsr_3 : std_logic_vector(2 downto 0) := (others => '0');

begin

    clk <= not clk after 5 ns;


    vunit_proc: process
        variable v_iterations: natural := 0;
        variable v_lfsr_3_check : std_logic_vector(2 downto 0) := (others => '0');
    begin
        test_runner_setup(runner, runner_cfg);
        logger_init(display_format => level);

            while test_suite loop
                if run("lfsr_maximum") then

                    for I in 3 to 30 loop
                        check_equal(lfsr_maximum(I), c_max_ints(I), "Checking " & integer'image(I) & "-bit LFSR Max");
                        debug("Max cycles for bit width " & integer'image(I) & ": " & integer'image(lfsr_maximum(I)));
                    end loop;

                elsif run("sequence_3_bit") then
                    while v_iterations < lfsr_maximum(3) loop
                        wait until rising_edge(clk);
                        check_equal(lfsr_3, v_lfsr_3_check, "3-bit LFSR sequence check");
                        v_lfsr_3_check := v_lfsr_3_check(1 downto 0) & (v_lfsr_3_check(2) xnor v_lfsr_3_check(1));
                        lfsr_advance(lfsr_3);
                    end loop;
                end if;
            end loop;

        test_runner_cleanup(runner);
    end process vunit_proc;

end tb;