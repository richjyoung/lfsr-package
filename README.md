VHDL LFSR Package
=================

[![CircleCI](https://circleci.com/gh/richjyoung/lfsr-package/tree/master.svg?style=svg)](https://circleci.com/gh/richjyoung/lfsr-package/tree/master)

Package of simple functions and procedures to implement any Linear Feedback
Shift Register between 3 and 168 bits.

LFSR registers are declared as `std_logic_vector` signals using `downto` ranges.
Variables can be used, although are not recommended.

> Uses tap values from Table 3 in [Xilinx XAPP 052 v1.1](https://www.xilinx.com/support/documentation/application_notes/xapp052.pdf).

## Repository Structure

```
+- src         - Synthesis/Simulation files
   +- <LIB>      Organised by library
+- test        - Simulation only code
   +- <LIB>_TB   Organised by library
+- utils       - Supporting code/documentation
```

## Usage
Import the package files into a library of your choice, then include via the
necessary `library` and `use` statements.

* `lfsr_evaluate` - Calculate the register value of a given width LFSR after a
number of iterations.
* `lfsr_advance` - Advances an LFSR register by one, optionally resetting after
a certain value is reached.
* `lfsr_maximum` - Calculate the maximum pattern length for a given number of
LFSR bits.

### Optional Reset Behaviour
Example - 3 bit LFSR, reset after 3 iterations

Reset value given by `lfsr_evaluate(3, 3) = "110"`. LFSR incremented using
`lfsr_advance(LFSR, "110")`.  Resulting pattern:
```
    +- Reset released
... | 000 | 001 | 011 | 110 | 000 | ...
                            +- Sequence repeats
```
Therefore the time period of a free-running LFSR using a reset value is one
clock cycle greater than the count used to evaluate the final reset value.

### Example (3-bit, free running)
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

### Example (8-bit, free running, resets after 200)
Same as above, except uses a larger LFSR register and specifies the count after
which the LFSR is reset.  This count is converted by `lfsr_evaluate` to give the
equivalent LFSR register value.
```
architecture rtl of example is
    constant C_LFSR_RESET   : T_LFSR := lfsr_evaluate(8, 200);
    signal LFSR             : std_logic_vector(7 downto 0);
begin
    lfsr_proc: process (CLK) is
    begin
        if rising_edge(CLK) then
            if RESET = '1' then
                LFSR    <= (others => '0');
            else
                lfsr_advance(LFSR, C_LFSR_RESET);
            end if;
        end if;
    end process lfsr_proc;
end rtl;
```