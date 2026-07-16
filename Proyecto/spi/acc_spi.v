module acc_spi (clk , i, inc, rst , c , z);
  input clk;
  input inc;
  input rst;
  output reg c;
  output reg z;
  output reg [5:0] i;

always @(negedge clk) begin
  if (rst) begin
   c <= 0;
   z <= 0;
   i <= 0;
  end else begin
      if (inc) begin
        i <= i + 1;
      end
      if (i == 10)begin
          c <= 1;
      end 
      else if (i == 13)begin
          z <= 1;
      end
  end
end
endmodule