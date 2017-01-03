CURR_DIR=$(pwd)
LIBRARY=$1
UUT=$2

if [ -d "working" ]; then
    rm -rf working
fi

mkdir working
cd working

ghdl -i --work=LFSR ../src/LFSR/*.vhd
ghdl -i --work=LFSR_TB ../test/LFSR_TB/*.vhd
ghdl -m --work=$LIBRARY $UUT

echo "Running Simulation..."
ghdl -r $UUT --wave=$UUT.ghw
echo "Simulation Complete."

gtkwave $UUT.ghw &

cd $CURR_DIR