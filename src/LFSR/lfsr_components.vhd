library IEEE;
use IEEE.std_logic_1164.all;
--------------------------------------------------------------------------------
package lfsr_components is

    component pulse is
        generic (
            G_lfsr_width    : natural := 3;
            G_period        : natural := 7
        );
        port(
            CLK             : in  std_logic;
            RESET           : in  std_logic;
            PULSE           : out std_logic
        );
    end component;

end lfsr_components;
--------------------------------------------------------------------------------
--package body components is
--end components;