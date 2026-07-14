module acc (clk , i, addi, rst , c);
  input clk;
  input addi;
  input rst;
  output reg c;
  output reg [5:0] i;

always @(negedge clk) begin
  if (rst) begin
   c <= 0;
   i <= 0;
  end else begin
      if (addi)
        i <= i + 1;
      if (i == 8)
          c <= 1;
  end
end
endmodule