syn:
	mkdir -p reports
	mkdir -p output_files
	genus -legacy_ui -no_gui -execute "source top.tcl; exit" 2>&1 | \
	tee run_syn.top.`date +%Y-%m-%d-%H%M%S`.log


clean:
	rm -rf WORK reports results *.log genus.* output_files *~ fv output_files_pw reports_pw
.PHONY: clean
