# place and route script
# version : 1.0
global env

#set OSU_FREEPDK $env(FREEPDK45)/osu_soc
set model_name "top"

win

source $model_name.globals

set init_mmmc_file $model_name.view

init_design
set_ccopt_property buffer_cells  "CLKBUF_X1 CLKBUF_X2 CLKBUF_X3"
setDesignMode -process 45
      
setFPlanRowSpacingAndType 2 2
setIoFlowFlag 0
floorPlan -r 1.2 0.6  15 15 15 15

#addHaloToBlock 0.5 0.5 0.5 0.5 -allBlock



createPGPin VDD -net VDD
createPGPin VSS -net VSS
globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose


addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -center 1 -stacked_via_top_layer TM -type core_rings -jog_distance 1.0 -threshold 1.0 -nets {VSS VDD} -follow core -stacked_via_bottom_layer metal1 -layer {bottom metal10 top metal10 right metal9 left metal9} -width 4 -spacing 2
#addStripe -skip_via_on_wire_shape Noshape -block_ring_top_layer_limit metal9 -max_same_layer_jog_length 1.6 -padcore_ring_bottom_layer_limit metal7 -set_to_set_distance 50 -skip_via_on_pin Standardcell -stacked_via_top_layer TM -padcore_ring_top_layer_limit metal9 -spacing 2 -xleft_offset 35 -merge_stripes_value 1.0 -layer metal8 -block_ring_bottom_layer_limit metal7 -width 4 -nets {VSS VDD} -stacked_via_bottom_layer metal1

placeDesign


sroute -connect {corePin} -nets VDD
sroute -connect {corePin} -nets VSS
#sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { metal1 TM } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { metal1 TM } -nets { VSS VDD } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { metal1 TM }

setCTSMode -engine ccopt
create_ccopt_clock_tree -name MY_CLK -source clk
ccopt_design
report_ccopt_clock_trees -file ./reports/clock_trees.rpt
report_ccopt_skew_groups -file ./reports/skew_groups.rpt
report_timing -unconstrained -delay_limit 20 > ./reports/timing_report_postCCopt.rpt 

routeDesign -globalDetail

addFiller -prefix FILLER -cell FILLCELL_X1 FILLCELL_X2 FILLCELL_X4

verifyConnectivity -type all -error 1000 -warning 50 -report ./reports/top.connect
verifyGeometry -report ./reports/top.geo
verify_drc   -report ./reports/top_soc.drc

defOut -floorplan -netlist -routing ./output_files/$model_name.def
write_sdf -interconn all -setuphold split ./output_files/$model_name.sdf
rcOut -spef ./output_files/$model_name.spef
saveNetlist ./output_files/$model_name.v

puts "Finish!!!"
