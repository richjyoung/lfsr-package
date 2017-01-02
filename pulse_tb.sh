CURR_DIR=$(pwd)

if [ -d "working" ]; then
    rm -rf working
fi

mkdir working
cd working

ghdl -i --work=LFSR ../src/LFSR/*.vhd
ghdl -i --work=LFSR_TB ../test/LFSR_TB/*.vhd
ghdl -m --work=LFSR_TB pulse_tb

echo "Running Simulation..."
ghdl -r pulse_tb --vcd=pulse_tb.vcd
echo "Simulation Complete."

gtkwave pulse_tb.vcd

cd $CURR_DIR