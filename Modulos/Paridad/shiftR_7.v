module shiftR_7 (clk , sh, rst, in_A, s_A);
  input clk;
  input sh;
  input rst;
  input [6:0] in_A;
  output reg [6:0] s_A;

always @(negedge clk)
  if (rst)
   s_A <= {in_A};
  else
     begin
      if (sh)
        s_A <= {1'b0, s_A[6:1]};
      else
        s_A <= s_A;
     end
endmodule