module acc_div (clk , i, addi, rst, z);
  input clk;
  input addi;
  input rst;
  output reg [5:0] i;
  output reg z;

always @(negedge clk) begin
  if (rst) begin
   i <= 0;
   z <= 0;
  end else begin
      if (addi) begin
        i <= i + 1;
      end
      if(i==15)begin
        z <= 1;
      end

  end
end
endmodule