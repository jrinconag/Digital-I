module raiz_32(clk, rst, init, done, A, pp);
    input rst;
    input clk;
    input init;
    input [15:0]A;
    output [15:0]pp;
    output done;

    wire w_sh;
    wire w_sh2;
    wire w_ld;
    wire w_reset;
    wire w_addi;

    wire w_C;
    wire w_z;

    wire [31:0]w_A;
    wire [15:0]res;
    wire [15:0]aux;
    wire [5:0] i;
    

    acc acc0 (.clk(clk), .i(i) , .addi(w_addi) , .rst(w_reset) , .c(w_C));

    shiftL_32_raiz shiftL_32_raiz0 (.clk(clk) , .in_A(A) , .in_RES(res) , .s_A(w_A) , .aux(pp) , .s_aux(aux) ,.ld(w_ld) , .sh(w_sh), .sh2(w_sh2), .rst(rst)  );

    comp comp0 (.clk(clk), .A(w_A[31:16]), .aux(aux), .res(res), .z(w_z));

    write_result_raiz write_result_raiz0 (.clk(clk) , .sh(w_sh) , .ld(w_ld) , .rst(rst) , .result(pp));

    control_raiz control_raiz0 (.clk(clk) , .rst(rst) , .init(init) , .c(w_C) , .msb(~w_z)  , .reset(w_reset) , .sh(w_sh) , .sh2(w_sh2) , .addi(w_addi) , .ld(w_ld)  , .done(done) );

endmodule