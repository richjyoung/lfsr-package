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
ghdl -r pulse_tb --wave=pulse_tb.ghw
echo "Simulation Complete."

gtkwave pulse_tb.ghw &

cd $CURR_DIR