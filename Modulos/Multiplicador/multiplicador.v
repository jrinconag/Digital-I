module multiplicador(clk, rst, init, done, A, B, pp);
    input rst;
    input clk;
    input init;
    input  [15:0]A;
    input  [15:0]B;
    output [31:0]pp;
    output done;

    wire w_sh;
    wire w_reset;
    wire w_ld;

    wire w_c;

    wire [15:0]w_A;
    wire [15:0]w_B;


    load_mult load_mult00 (.clk(clk), .ld(w_ld) , .rst(w_reset), .A(w_A) , .RTA(pp));

    shiftL_mult shiftA00 (.clk(clk) , .rst(w_reset) , .in_A(A) , .o_A(w_A) , .sh(w_sh));

    shiftR_mult shiftB00 (.clk(clk) , .rst(w_reset) , .in_B(B) , .o_B(w_B) , .sh(w_sh));

    comp_mult comp_mult00 (.clk(clk) , .B(w_B) , .c(w_c), .rst(w_reset));

    control_mult control_mult00 (.clk(clk), .rst(rst) , .init(init) , .done(done) , .c(w_c) , .lsb(w_B[0]), .reset(w_reset) , .sh(w_sh) , .ld(w_ld) );

endmodule