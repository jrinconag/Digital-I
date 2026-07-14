module load_mult (clk , A, RTA, ld, rst);
  input clk;
  input ld;
  input rst;

  input [15:0]A;
  output reg [31:0]RTA;

always @(negedge clk) begin
  if (rst) begin
   RTA = 31'd0;
  end else begin
      if (ld) begin
        RTA = RTA + A;
      end
  end
end
endmodule