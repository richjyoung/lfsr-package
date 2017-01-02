library IEEE;
use IEEE.std_logic_1164.all;
--------------------------------------------------------------------------------
package body LFSR is

    procedure lfsr_adv (variable reg : inout std_logic_vector) is
    begin
        case reg'length is
            when 3 =>
                reg := reg(reg'high-1 downto 0) & (reg(2) xnor reg(1));
            when 4 =>
                reg := reg(reg'high-1 downto 0) & (reg(3) xnor reg(2));
            when 5 =>
                reg := reg(reg'high-1 downto 0) & (reg(4) xnor reg(2));
            when 6 =>
                reg := reg(reg'high-1 downto 0) & (reg(5) xnor reg(4));
            when 7 =>
                reg := reg(reg'high-1 downto 0) & (reg(6) xnor reg(5));
            when others =>
                assert false
                    report "LFSR size not supported"
                    severity failure;
        end case;
    end procedure lfsr_adv;

    procedure lfsr_adv (
        variable reg : inout std_logic_vector;
        constant stopval : in std_logic_vector
    ) is
    begin
        if reg = stopval then
            reg     := (reg'range => '0');
        else
            lfsr_adv(reg);
        end if;
    end procedure lfsr_adv;

    function lfsr_val (
        constant size : natural;
        constant val : natural
    ) return std_logic_vector is
        variable reg : std_logic_vector(size-1 downto 0) := (others => '0');
    begin
        if val > 0 then
            for I in 1 to val loop
                lfsr_adv(reg);
            end loop;
        end if;
        return reg;
    end function lfsr_val;

end LFSR;