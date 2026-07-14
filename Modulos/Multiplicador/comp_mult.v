module comp_mult (clk , B, c, rst);
  input clk;
  input rst;
  input [15:0]B;
  output reg c;

always @(negedge clk) begin

    if (rst) begin
        c = 0;
    end
      if (B == 0) begin
        c <= 1;
      end
end
endmodule