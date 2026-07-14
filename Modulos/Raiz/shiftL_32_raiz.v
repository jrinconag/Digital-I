module shiftL_32_raiz(clk , in_A , in_RES , aux, s_aux, s_A , ld , sh, sh2, rst);
  input clk;
  input rst;
 

  input [15:0] in_RES;
  input [15:0] in_A;
  input [31:0] aux;
  output reg [15:0] s_A;
  output reg [15:0] s_aux;

  input sh;
  input ld;
  input sh2;
  always @(negedge clk) begin
    if (rst) begin
        s_A <= 16'd0;
        s_A[15:0] <= in_A;
    end
    else begin
        if (sh) begin
            s_A[31:0] <= {s_A[30:0],1'b0};
        end
        else if (sh2) begin
            s_A[31:0] <= {s_A[30:0],1'b0};
            s_aux[15:0] <= {aux[14:0],1'b0};
        end
        else begin
            if (ld)
              s_A[31:16] <= in_RES[15:0];
            else 
              s_A <= s_A;
        end
    end
end

endmodule