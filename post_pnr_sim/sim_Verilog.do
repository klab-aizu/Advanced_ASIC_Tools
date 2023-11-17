vlib work
vmap work work

# compile
vlog /home/lib/cells.v
vlog ./verilog_files/detector110_tester.v
vlog ./verilog_files/detector110.v

# simulate

vsim -t 1ps -voptargs="+acc" -sdfmax /UUT=./verilog_files/detector110.sdf -sdfnoerror -L work +no_neg_tcheck  detector110_tester

# add wave to the view
add wave /*

# run the simulation
run -all
