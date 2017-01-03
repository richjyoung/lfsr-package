CURR_DIR=$(pwd)
LIBRARY=$1
UUT=$2

echo "==== Simulating $LIBRARY/$UUT ===="

if [ -d "working" ]; then
    rm -rf working
fi
mkdir working
cd working

echo "Importing sources..."
ghdl -i --work=LFSR ../src/LFSR/*.vhd
ghdl -i --work=LFSR_TB ../test/LFSR_TB/*.vhd
ghdl -m --work=$LIBRARY $UUT | tee make.log

echo "Running simulation..."
ghdl -r $UUT --wave=$UUT.ghw 2>&1 | tee sim.log
echo "==== Simulation complete ===="

#gtkwave $UUT.ghw &

cd $CURR_DIR