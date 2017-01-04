library IEEE;
use IEEE.std_logic_1164.all;
--------------------------------------------------------------------------------
package main_tb_pkg is

    ----------------------------------------------------------------------------
    -- Types & Constants
    ----------------------------------------------------------------------------
    constant C_MAX_STRING_LENGTH    : natural := 50;
    constant C_TESTCASES            : natural := 6;

    type T_TESTCASE is record
        NAME        : string(1 to C_MAX_STRING_LENGTH);
        L_NAME      : natural;
        BITS        : natural;
        PERIOD      : natural;
        EXPECTED    : time;
    end record;

    type T_TESTSUITE is array (0 to C_TESTCASES-1) of T_TESTCASE;

    type T_TESTRESULT is record
        PASS_nFAIL  : std_logic;
        DONE        : std_logic;
        RUNTIME     : time;
    end record;

    type T_TESTRESULTS is array (0 to C_TESTCASES-1) of T_TESTRESULT;

    function done (
        RESULTS : T_TESTRESULTS
    ) return std_logic;

    function failures (
        RESULTS : T_TESTRESULTS
    ) return natural;

end main_tb_pkg;