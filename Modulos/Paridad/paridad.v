module paridad(clk, rst, init, done, A, pp);
    input rst;
    input clk;
    input init;
    input [6:0]A;
    output [7:0]pp;
    output done;

    //Aqui depronto falta el A_LSB, que deberia hacer el bit menos significativo de A igual a 1
    wire w_sh;
    wire w_reset;
    wire w_addi;

    wire w_C;
    wire [6:0]w_A;
    wire [5:0] i;

    assign pp = {A[6:0],i[0]};

    accp accp0 (.clk(clk), .i(i) , .addi(w_addi) , .rst(w_reset));

    shiftR_7 shiftR_70 (.clk(clk) , .rst(w_reset) , .in_A(A) , .s_A(w_A) , .sh(w_sh));

    control_paridad control_paridad0 (.clk(clk) , .rst(rst) , .init(init) , .c(w_C) , .lsb(w_A[0])  , .reset(w_reset) , .sh(w_sh) , .addi(w_addi) , .done(done) );

endmodule