module ws2812_array(clk, INIT_M, RST_CMD, DOUT, DONE_M );
    input RST_CMD;
    input clk;
    input INIT_M;

    output DONE_M;
    output DOUT;
   
    wire [23:0]w_RGB;


    wire w_done_led;
    wire w_z;

    wire [8:0]w_addr;

    wire w_done;
    wire w_init_led;
    wire w_reset;
    wire w_inc;

    


    ws2812_LED ws2812_LED00(.clk(clk), .rst(rst), .RGB(w_RGB), .RESET_CMD(0), .INIT(w_init_led), .DOUT(DOUT), .DONE(w_done_led));

    led_mem_arr LEDMEM00 (.clk(clk), .addr(w_addr), .RGB(w_RGB));

    count_arr countLED00 (.clk(clk) , .inc(w_inc), .rst(w_reset), .addr(w_addr));

    comp_arr shiftLED00(.clk(clk) , .addr(w_addr) , .z(w_z));

    control_arr control_wLED00( .clk(clk) , .INIT_M(INIT_M) , .rst(rst), .z(w_z) , .DONE(DONE_M)  , .DONE_LED(w_done_led) ,  .INIT_LED(w_init_led) , .reset(w_reset), .inc (w_inc)  );

endmodule