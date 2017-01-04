library IEEE;
use IEEE.std_logic_1164.all;
--------------------------------------------------------------------------------
package body main_tb_pkg is

    function done (
        RESULTS : T_TESTRESULTS
    ) return std_logic is
        variable T : std_logic := '1';
    begin
        for I in RESULTS'range loop
            T := T and RESULTS(I).DONE;
        end loop;
        return T;
    end function done;


    function failures (
        RESULTS : T_TESTRESULTS
    ) return natural is
        variable C : natural := 0;
    begin
        for I in RESULTS'range loop
            if RESULTS(I).PASS_nFAIL = '0' then
                C := C + 1;
            end if;
        end loop;
        return C;
    end function failures;

end main_tb_pkg;