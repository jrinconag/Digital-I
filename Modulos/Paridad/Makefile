TARGET = paridad
##OBJS   = ${TARGET}.v
OBJS = shiftR_7_M.v acc_M.v control_paridad_M.v paridad_M.v 
##OBJS 
ICE40_SIM_CELLS=$(shell yosys-config --datdir/ecp5/cells_sim.v)

sim:
	rm -f a.out *.vcd
	iverilog -g2012 -DBENCH $(TARGET)_TB_M.v $(OBJS)
	vvp a.out
	gtkwave $(TARGET)_TB_M.vcd $(TARGET)_M.gtkw
sim_post_syn:
	yosys -v3 -l synth.log -p 'synth_ecp5 -top $(TARGET)_M -json $(TARGET)_M.json; write_verilog -attr2comment $(TARGET)_synth.v' $(OBJS)
	iverilog  $(TARGET)_TB_M.v $(TARGET)_synth.v $(ICE40_SIM_CELLS) 
	vvp a.out
	gtkwave $(TARGET)_TB_M.vcd $(TARGET)_M.gtkw
svg: $(OBJS)
	rm -rf *svg *out *dot
	yosys -p "prep -top ${TARGET}_M; memory_map; opt; opt_expr; techmap; abc -g AND,OR,XOR; write_json ${TARGET}_M.json" ${OBJS}
	yosys -p "read_verilog ${TARGET}_M.v; proc; memory_map; opt; opt_expr; techmap; abc -g AND,OR,XOR; show -format dot -prefix ${TARGET}_M_out"
	netlistsvg ${TARGET}_M.json -o ${TARGET}_M.svg
	google-chrome ${TARGET}_M.svg
clean:
	rm -rf *svg *out *dot a.out *.vcd *json *_synth.v *log