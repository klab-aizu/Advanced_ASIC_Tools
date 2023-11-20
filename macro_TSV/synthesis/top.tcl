######################################################
# Script for Cadence RTL Compiler synthesis      
# Erik Brunvand, 2008
# Use with syn-rtl -f rtl-script
# Replace items inside <> with your own information
######################################################

# Set the search paths to the libraries and the HDL files
# Remember that "." means your current directory. Add more directories
# after the . if you like.  
set_attribute hdl_search_path {../rtl/} 
set_attribute lib_search_path {/home/lib/}
set_attribute library [list typical.lib TSV_lib/TSV.lib]
set_attribute information_level 6 

set myFiles [list top.v]         ;# All HDL files
set basename top	         ;# name of top level module
set myClk clk                    ;# clock name
set myPeriod_ps 2400             ;# Clock period in ps
set myInDelay_ns 0.1             ;# delay from clock to inputs valid
set myOutDelay_ns 0.1            ;# delay from clock to output valid
set runname net                  ;# name appended to output files

#*********************************************************
#*   below here shouldn't need to be changed...          *
#*********************************************************

# Analyze and Elaborate the HDL files
# set_attribute hdl_language vhdl
read_hdl ${myFiles}
elaborate ${basename}

# Apply Constraints and generate clocks
set clock [define_clock -period ${myPeriod_ps} -name ${myClk} [clock_port]]	
external_delay -input $myInDelay_ns -clock ${myClk} [find / -port ports_in/*]
external_delay -output $myOutDelay_ns -clock ${myClk} [find / -port ports_out/*]

# Sets transition to default values for Synopsys SDC format, 
# fall/rise 400ps
dc::set_clock_transition .4 $myClk

# check that the design is OK so far
check_design -unresolved
report timing -lint

# Synthesize the design to the target library
synthesize -to_mapped

# Write out the reports
report timing > ./reports/${basename}_${runname}_timing.rep
report gates  > ./reports/${basename}_${runname}_cell.rep
report power  > ./reports/${basename}_${runname}_power.rep

# Write out the structural Verilog and sdc files
write_hdl -mapped >  ./output_files/${basename}_${runname}.v
write_sdc >  ./output_files/${basename}_${runname}.sdc
