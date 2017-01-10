VHDL LFSR Package
=================

[![CircleCI](https://circleci.com/gh/richjyoung/lfsr-package/tree/master.svg?style=svg)](https://circleci.com/gh/richjyoung/lfsr-package/tree/master)

Package of simple functions and procedures to implement any Linear Feedback
Shift Register between 3 and 168 bits.

LFSR registers are declared as `std_logic_vector` signals, and are implemented
with the feedback path input the the right-hand side of the register after a
left shift.

Variables can be used, although are not recommended.

> Uses tap values from [Xilinx XAPP 052 v1.1 Table 3](https://www.xilinx.com/support/documentation/application_notes/xapp052.pdf).

## Background

Mechanisms for achieving multi-cycle delays in FPGA designs tend to suffer from
increasing area utilisation as the delay length increases.  Standard 'one-hot'
shift registers can be used for small delays, however are the most inefficient.
Counters are more efficient in terms of register utilisation, however the adder
logic to calculate the next state is still fairly large.

Linear-Feedback Shift Registers are a class of shift register for which the
input depends on the current state, and can be configured to give a sequence
length which is close to that of an equivalent-sized counter.  LFSRs comprise a
set of registers for each bit, and simple combinational logic to perform the
feedback function meaning that they are very efficient in terms of space
utilisation.

VHDL designs which implement LFSR counters typically rely on pre-computing a
register value which maps to an equivalent count, such that the delay achieved
is accurate to the design requirements.  This may rely on a script in another
language which is rarely under source control, a gargantuan multi-megabyte
spreadsheet of entire patterns bloating a network drive, or simply running a
tediously slow simulation until the desired value is observed.  Issues with
register value calculation aside, the magic numbers that end up in the codebase
do not stand up to code review scrutiny, nor do they stand the test of time when
encountered by an unfamiliar developer changing or extending a design.

## Project Aims
* Simple dependency-free library for implementing LFSRs.
* Use STD_LOGIC_1164 types only.
* Limited set of procedures and functions, overloaded where necessary such that
purpose is clear.
* VHDL '93 or above.

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