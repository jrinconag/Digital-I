module shiftL_spi(clk , A , num , sh , rst);
  input clk;
  input rst;

  input A;
  output reg [11:0] num;

  input sh;

  always @(negedge clk) begin
    if (rst) begin
        num <= 12'd0;
    end
    else begin
        if (sh) begin
            num[11:0] <= {num[10:0], A };
        end
            else begin
              num <= num;
            end
        
    end
end

endmodule