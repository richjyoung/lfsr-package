library IEEE;
use IEEE.std_logic_1164.all;
--------------------------------------------------------------------------------
package lfsr is

    constant C_TAPTABLE_WIDTH : natural := 4;
    type t_taptable is array(3 to 8, 1 to C_TAPTABLE_WIDTH) of natural;
    constant C_TAPTABLE : t_taptable := (
        (3, 2, 0, 0),
        (4, 3, 0, 0),
        (5, 3, 0, 0),
        (6, 5, 0, 0),
        (7, 6, 0, 0),
        (8, 6, 5, 4)
    );

    procedure lfsr_adv (
        signal REG : inout std_logic_vector
    );
    procedure lfsr_adv (
        signal REG : inout std_logic_vector;
        constant RESET : in std_logic_vector
    );
    procedure lfsr_adv_var (
        variable REG : inout std_logic_vector
    );
    procedure lfsr_adv_var (
        variable REG : inout std_logic_vector;
        constant RESET : in std_logic_vector
    );
    function lfsr_eval (
        constant SIZE : natural;
        constant VALUE : natural
    ) return std_logic_vector;
    function lfsr_max (constant SIZE : natural) return natural;

end lfsr;
--------------------------------------------------------------------------------