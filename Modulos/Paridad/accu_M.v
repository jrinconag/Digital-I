module acc_M (clk , i, addi, rst);
  input clk;
  input addi;
  input rst;
  output reg [5:0] i;

always @(negedge clk) begin
  if (rst) begin
   i <= 0;
  end else begin
      if (addi)
        i <= i + 1;
  end
end
endmodule