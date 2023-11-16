VERILOG_DIR := ./verilog_files/
SIM_DIR := ./
PS_MODULE := detector110_net.v
TB := detector110_tester.v
STD_CELL_LIB =  /home/lib/cells.v

init:
	vlib work
	vlog $(VERILOG_DIR)/detector110_net.v   
	vlog $(VERILOG_DIR)/detector110_tester.v
	vsim -voptargs="+acc" -wlf detector110.wlf detector110_tester \
		-c -do "log -r *; run -a; add wave *; exit"


clean:
	rm -rf $(SIM_DIR)/modelsim.ini \
		$(SIM_DIR)/transcript $(SIM_DIR)/work/ $(SIM_DIR)/vsim* $(SIM_DIR)/*\~ $(SIM_DIR)/*.wlf
