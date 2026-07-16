module divisor(clk, rst, init, done, A, B, pp);
    input rst;
    input clk;
    input init;
    input  [15:0]A;
    input  [15:0]B;
    output [15:0]pp;
    output done;

    wire w_sh;
    wire w_reset;
    wire w_addi;
    wire w_ld;
    wire w_r;

    wire w_c;
    wire w_z;

    wire [31:0]w_A;
    wire [5:0] i;




    acc_div acc_div00 (.clk(clk) , .rst(w_reset), .addi(w_addi) , .z(w_z));

    shiftL_div shiftDIV0 (.clk(clk) , .rst(w_reset) , .in_A(A) , .o_A(w_A) , .sh(w_sh), .ld(w_ld), .RTA(pp), .B(B), .r(w_r));

    comp_div comp_div00 (.clk(clk) , .B(B) , .temp(w_A[31:16]), .c(w_c), .rst(w_reset));

    control_div control_div000 (.clk(clk), .rst(rst) , .init(init) , .done(done) , .z(w_z) , .c(w_c), .reset(w_reset) , .sh(w_sh) , .addi(w_addi) , .ld(w_ld), .r(w_r));

endmodule