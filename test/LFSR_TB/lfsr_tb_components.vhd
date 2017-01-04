library IEEE;
use IEEE.std_logic_1164.all;
--------------------------------------------------------------------------------
package lfsr_tb_components is

    component pulse_tester is
        generic (
            G_lfsr_width    : natural := 3;
            G_period        : natural := 7;
            G_expected      : time    := 70 ns
        );
        port(
            CLK             : in  std_logic;
            RESET           : in  std_logic;
            GO              : in  std_logic;
            DONE            : out std_logic;
            PASS_nFAIL      : out std_logic;
            RUNTIME         : out time
        );
    end component;

end lfsr_tb_components;