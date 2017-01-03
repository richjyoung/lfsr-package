library IEEE, STD;
use IEEE.std_logic_1164.all;
--------------------------------------------------------------------------------
package body lfsr is

    ----------------------------------------------------------------------------
    -- Procedure: LFSR Advance
    ----------------------------------------------------------------------------
    procedure lfsr_adv (signal REG : inout std_logic_vector) is
        variable TEMP       : std_logic_vector(REG'range);
    begin
        TEMP                := REG;
        lfsr_adv_var(TEMP);
        REG                 <= TEMP;
    end procedure lfsr_adv;

    ----------------------------------------------------------------------------
    -- Procedure: LFSR Advance
    ----------------------------------------------------------------------------
    procedure lfsr_adv (
        signal REG          : inout std_logic_vector;
        constant RESET      : in std_logic_vector
    ) is
        variable TEMP       : std_logic_vector(REG'range);
    begin
        TEMP                := REG;
        lfsr_adv_var(TEMP, RESET);
        REG                 <= TEMP;
    end procedure lfsr_adv;

    ----------------------------------------------------------------------------
    -- Procedure: LFSR Advance (Variable)
    ----------------------------------------------------------------------------
    procedure lfsr_adv_var (variable REG : inout std_logic_vector) is
        variable INDEX      : integer;
        variable FEEDBACK   : std_logic;
    begin
        INDEX               := REG'length;
        FEEDBACK            := REG(C_TAPTABLE(INDEX, 0) - 1); -- Start with first tap value
        for I in 1 to C_TAPTABLE_WIDTH-1 loop -- Iterate over all taps
            if C_TAPTABLE(INDEX, I) /= 0 then -- Mask invalid taps
                FEEDBACK    := FEEDBACK xnor REG(C_TAPTABLE(INDEX, I) - 1); -- XNOR next tap value
            end if;
        end loop;
        REG                 := REG(REG'high-1 downto 0) & FEEDBACK; -- Shift LFSR register and append feedback value
    end procedure lfsr_adv_var;

    ----------------------------------------------------------------------------
    -- Procedure: LFSR Advance (Variable)
    ----------------------------------------------------------------------------
    procedure lfsr_adv_var (
        variable REG    : inout std_logic_vector;
        constant RESET  : in std_logic_vector
    ) is
    begin
        if REG = RESET then
            REG         := (REG'range => '0');
        else
            lfsr_adv_var(REG);
        end if;
    end procedure lfsr_adv_var;

    ----------------------------------------------------------------------------
    -- Function: LFSR Evaluate
    ----------------------------------------------------------------------------
    function lfsr_eval (
        constant SIZE : natural;
        constant VALUE : natural
    ) return std_logic_vector is
        variable REG : std_logic_vector(SIZE-1 downto 0) := (others => '0');
    begin
        if VALUE > 0 then
            for I in 1 to VALUE loop
                lfsr_adv_var(REG);
            end loop;
        end if;
        return REG;
    end function lfsr_eval;

    ----------------------------------------------------------------------------
    -- Function: LFSR Maximum
    ----------------------------------------------------------------------------
    function lfsr_max (constant SIZE : natural) return natural is
    begin
        return 2**SIZE - 1;
    end function lfsr_max;

end lfsr;