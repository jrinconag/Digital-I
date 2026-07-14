module shiftR_mult(clk , in_B , o_B, sh , rst);
  input clk;
  input rst;
  input sh;

  input [15:0]in_B;
  
  output reg [15:0]o_B;

  always @(negedge clk) begin
    if (rst) begin
        o_B[15:0] <= in_B[15:0];
    end
    else begin
        if (sh) begin
            o_B[15:0] <= { 1'b0, o_B[15:1] };
        end
            else begin
              o_B  <= o_B;
            end
        
    end
end

endmodule