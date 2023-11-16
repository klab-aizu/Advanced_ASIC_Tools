vlib work
vmap work work

# compile
vlog /home/lib/cells.v
vlog ./verilog_files/detector110_tester.v
vlog ./verilog_files/detector110_net.v

# simulate

vsim -voptargs="+acc" work.detector110_tester

# add wave to the view
add wave /*

# run the simulation
run -all
