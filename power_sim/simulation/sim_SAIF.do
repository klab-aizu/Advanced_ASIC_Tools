vlib work
vmap work work

# compile
vlog /home/lib/cells.v
vlog ./verilog_files/detector110_tester.v
vlog ./verilog_files/detector110_net.v

# simulate

vsim -t 1ps -voptargs="+acc" -sdfmax /UUT=./verilog_files/detector110_net.sdf -sdfnoerror -L work +no_neg_tcheck -g_QUIT=0 -g_DUMPVCD=0 detector110_tester
#vsim -t 1ps -voptargs="+acc" -sdfmax /UUT=./verilog_files/detector110_net.sdf -sdfnoerror -L work +no_neg_tcheck -g_QUIT=1 -g_DUMPVCD=0 -g_NOACTI=1 detector110_tester

power add /detector110_tester/UUT/*

# add wave to the view
add wave /*

run -all
power report -all -bsaif detector110.saif

exit
