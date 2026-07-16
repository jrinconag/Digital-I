module comp_div (clk ,temp, B, c, rst);
  input clk;
  input rst;
  input [15:0]B;
  input [15:0]temp;
  output reg c;

  reg [15:0]x;
always @(*) begin

    x = temp - B;

    if (rst) begin
        c = 0;
    end

      if (x[15]) begin
        c <= 0;
      end
      else begin
        c <= 1;
      end
end
endmodule