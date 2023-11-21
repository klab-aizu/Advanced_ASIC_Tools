#
# Your design
#
set design_name "detector110"
set model_name "net"
set base_name "${design_name}_${model_name}"
set vnet_file "${design_name}_${model_name}.v"
set sdc_file  "${design_name}_${model_name}.sdc"
set sdf_file  "${design_name}_${model_name}.sdf"
set spef_file "${design_name}_${model_name}.spef"
set saif_file "${design_name}.saif"
set vcd_file "${design_name}_dump.vcd"

#
# Libraries
#
set target_library "~/lib/slow.db"
set synthetic_library "~/lib/dw_foundation.sldb"
set link_library [concat "*" $target_library $synthetic_library]
set symbol_library "~/lib/generic.sdb"

set power_enable_analysis "true"
set report_default_significant_digit 6

#
# Read post-layout netlist
#

read_file -format verilog ./input_files/$vnet_file
current_design $design_name
link


#
# Delay and RC information
#
read_sdc ./input_files/$sdc_file
read_sdf ./input_files/$sdf_file
read_parasitics ./input_files/$spef_file



#
# Read switching activity information
#
#read_saif ./input_files/$saif_file -strip_path "detector110_tester/UUT"
#report_saif -hier -missing > ./report/missing_${base_name}.txt
read_vcd ./input_files/$vcd_file -strip_path "detector110_tester/UUT"


report_timing > ./report/timing_report_${base_name}.txt
#report_reference -hier > ./report/reference_report_${base_name}.txt
report_power -hier > ./report/power_report_${base_name}.txt
quit

