VHDL LFSR Package
=================

[![CircleCI](https://circleci.com/gh/richjyoung/lfsr-package/tree/master.svg?style=svg)](https://circleci.com/gh/richjyoung/lfsr-package/tree/master)

Package of simple functions and procedures to implement any Linear Feedback
Shift Register between 3 and 168 bits.

LFSR registers are declared as `std_logic_vector` signals using `downto` ranges.
Variables can be used, although are not recommended.

> Uses tap values from Table 3 in [Xilinx XAPP 052 v1.1](https://www.xilinx.com/support/documentation/application_notes/xapp052.pdf).

## Usage
Import the package files into a library of your choice, then include via the
necessary `library` and `use` statements.

### Simple Example (3-bit, free running)
```
architecture rtl of example is
    signal LFSR         : std_logic_vector(2 downto 0);
begin
    lfsr_proc: process(CLK) is
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                LFSR    <= (others => '0');
            else
                lfsr_advance(LFSR);
            end if;
        end if;
    end process lfsr_proc;
end rtl;
```