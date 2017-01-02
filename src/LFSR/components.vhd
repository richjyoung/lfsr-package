library IEEE;
use IEEE.std_logic_1164.all;
--------------------------------------------------------------------------------
package components is

    component pulse is
        port(
            CLK     : in  std_logic;
            RESET   : in  std_logic;
            PULSE   : out std_logic
        );
    end component;

end components;
--------------------------------------------------------------------------------
--package body components is
--end components;