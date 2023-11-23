###################################################################

# Created by write_sdc on Thu Nov 23 22:11:12 2023

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_wire_load_model -name 5K_hvratio_1_1 -library NangateOpenCellLibrary
create_clock [get_ports clk]  -period 2  -waveform {0 1}
set_clock_uncertainty 0.004  [get_clocks clk]
set_input_delay -clock clk  0.1  [get_ports a]
set_input_delay -clock clk  0.1  [get_ports reset]
set_output_delay -clock clk  0.1  [get_ports w]
