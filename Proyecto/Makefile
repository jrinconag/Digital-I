TARGET = ws2812_array
##OBJS   = ${TARGET}.v
OBJS =  ws2812_led/ws2812/comp_ws.v 
		ws2812_led/ws2812/control_ws.v 
		ws2812_led/ws2812/count_ws.v 
		ws2812_led/ws2812/ws2812.v 
		ws2812_led/ws2812/multiplexor_ws.v 

		ws2812_led/shift_wsl.v 
		ws2812_led/count_wsl.v 
		ws2812_led/control_wsl.v 
		ws2812_led/ws2812_led.v

		comp_arr.v
		control_arr.v
		count_arr.v
		led_mem_arr.v
		ws2812_array.v
		
##OBJS = main_process.v
ICE40_SIM_CELLS=$(shell yosys-config --datdir/ecp5/cells_sim.v)

sim:
	rm -f a.out *.vcd
	iverilog -g2012 -DBENCH $(TARGET)_TB.v $(OBJS)
	vvp a.out
	gtkwave $(TARGET)_TB.vcd $(TARGET).gtkw
sim_post_syn:
	yosys -v3 -l synth.log -p 'synth_ecp5 -top $(TARGET) -json $(TARGET).json; write_verilog -attr2comment $(TARGET)_synth.v' $(OBJS)
	iverilog  $(TARGET)_TB.v $(TARGET)_synth.v $(ICE40_SIM_CELLS) 
	vvp a.out
	gtkwave $(TARGET)_TB.vcd $(TARGET).gtkw
svg: $(OBJS)
	rm -rf *svg *out *dot
	yosys -p "prep -top ${TARGET}; memoryap; opt; opt_expr; techmap; abc -g AND,OR,XOR; write_json ${TARGET}.json" ${OBJS}
	yosys -p "read_verilog ${TARGET}.v; proc; memoryap; opt; opt_expr; techmap; abc -g AND,OR,XOR; show -format dot -prefix ${TARGET}_out"
	netlistsvg ${TARGET}.json -o ${TARGET}.svg
	google-chrome ${TARGET}.svg
clean:
	rm -rf *svg *out *dot a.out *.vcd *json *_synth.v *log