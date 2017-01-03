library IEEE;
use IEEE.std_logic_1164.all;
--------------------------------------------------------------------------------
package lfsr is

    ----------------------------------------------------------------------------
    -- Types & Constants
    ----------------------------------------------------------------------------
    constant C_TAPTABLE_WIDTH : natural := 4;
    constant C_TAPTABLE_MIN   : natural := 3;
    constant C_TAPTABLE_MAX   : natural := 8;
    type t_taptable is array(C_TAPTABLE_MIN to C_TAPTABLE_MAX, 0 to C_TAPTABLE_WIDTH-1) of natural;

    -- Xilinx XAPP 052 v1.1 (July 7, 1996)
    -- Taps are 1-based such that zero denotes the tap is not required.
    constant C_TAPTABLE : t_taptable := (
        (3, 2, 0, 0),
        (4, 3, 0, 0),
        (5, 3, 0, 0),
        (6, 5, 0, 0),
        (7, 6, 0, 0),
        (8, 6, 5, 4)
    );

    ----------------------------------------------------------------------------
    -- Procedure: LFSR Advance
    -- * Advances LFSR register by one.
    -- * Size is inferred from the input arguments.
    ----------------------------------------------------------------------------
    procedure lfsr_adv (
        signal REG : inout std_logic_vector
    );

    ----------------------------------------------------------------------------
    -- Procedure: LFSR Advance
    -- * Advances LFSR register by one, up to a desired reset value.
    -- * LFSR resets after the reset value is reached.
    -- * Size is inferred from the input arguments.
    ----------------------------------------------------------------------------
    procedure lfsr_adv (
        signal REG : inout std_logic_vector;
        constant RESET : in std_logic_vector
    );

    ----------------------------------------------------------------------------
    -- Procedure: LFSR Advance (Variable)
    -- * Advances LFSR variable by one.
    -- * Size is inferred from the input arguments.
    ----------------------------------------------------------------------------
    procedure lfsr_adv_var (
        variable REG : inout std_logic_vector
    );

    ----------------------------------------------------------------------------
    -- Procedure: LFSR Advance (Variable)
    -- * Advances LFSR variable by one, up to a desired reset value.
    -- * LFSR resets after the reset value is reached.
    -- * Size is inferred from the input arguments.
    ----------------------------------------------------------------------------
    procedure lfsr_adv_var (
        variable REG : inout std_logic_vector;
        constant RESET : in std_logic_vector
    );

    ----------------------------------------------------------------------------
    -- Function: LFSR Evaluate
    -- * Calculate the LFSR register value reached after a chosen number of
    --   iterations.
    -- * Size must be given as it cannot be inferred from the input arguments.
    ----------------------------------------------------------------------------
    function lfsr_eval (
        constant SIZE : natural;
        constant VALUE : natural
    ) return std_logic_vector;

    ----------------------------------------------------------------------------
    -- Function: LFSR Maximum
    -- * Calculate the maximum sequence length for a chosen LFSR size.
    -- * Size must be given as it cannot be inferred from the input arguments.
    ----------------------------------------------------------------------------
    function lfsr_max (constant SIZE : natural) return natural;

end lfsr;
--------------------------------------------------------------------------------