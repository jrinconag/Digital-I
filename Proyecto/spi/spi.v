module spi(clk, rst, init, done, A, pp, cs, sck);
    input rst;
    input clk;
    input init;
    input A;
    output [11:0]pp;
    output cs;
    output sck;
    output done;

    wire w_sh;
    wire w_reset;
    wire w_inc;

    wire w_c;
    wire w_z;
    wire w_init;

    wire [5:0] i;

    //wire w_a; //PARA SIMULAR SENSOR

    //sensor sensor0 (.clk(sck), .cs(cs) , .so(w_a) ); //SIMULAR SENSOR

    start_spi start0 (.clk(sck)  , .in_init(rst) , .out_init(w_init) , .cs(cs));

    clock_spi clock_spi0 (.clk(clk) , .i(i) , .rst(rst) , .frec(sck));

    acc_spi accp0 (.clk(sck), .i(i) , .inc(w_inc) , .rst(w_reset), .c(w_c) , .z(w_z));

    //CAMBIAR A POR w_a PARA SIMULAR
    shiftL_spi shift0 (.clk(sck) , .rst(w_reset) , .A(A) , .num(pp) , .sh(w_sh));

    control_spi control_spi0 (.clk(sck), .rst(rst) , .init(w_init) , .c(w_c) , .z(w_z)  , .reset(w_reset) , .sh(w_sh) , .inc(w_inc) , .done(done) );

endmodule