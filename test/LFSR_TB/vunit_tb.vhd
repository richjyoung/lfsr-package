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

begin

    main: process
    begin   test_runner_setup(runner, runn_cfg);
    report "Hello World!";
    test_runner_cleanup(runner);

end tb;