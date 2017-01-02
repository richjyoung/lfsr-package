library IEEE;
use IEEE.std_logic_1164.all;
--------------------------------------------------------------------------------
package LFSR is

    type t_taptable is array(3 to 8, 1 to 4);
    constant C_TAPTABLE : t_taptable := (
        (3, 2, 0, 0),
        (4, 3, 0, 0),
        (5, 3, 0, 0),
        (6, 5, 0, 0),
        (7, 6, 0, 0),
        (8, 6, 5, 4)
    );

    procedure lfsr_adv (variable reg : inout std_logic_vector);
    procedure lfsr_adv (
        variable reg : inout std_logic_vector;
        constant stopval : in std_logic_vector
    );
    function lfsr_val (
        constant size : natural;
        constant val : natural
    ) return std_logic_vector;

end LFSR;
--------------------------------------------------------------------------------