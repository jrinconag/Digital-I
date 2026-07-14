module shiftL_mult(clk , in_A , o_A, sh , rst);
  input clk;
  input rst;
  input sh;

  input [15:0]in_A;
  
  output reg [15:0]o_A;

  always @(negedge clk) begin
    if (rst) begin
        o_A[15:0] <= in_A[15:0];
    end
    else begin
        if (sh) begin
            o_A[15:0] <= {o_A[14:0], 1'b0 };
        end
            else begin
              o_A   <= o_A;
            end
        
    end
end

endmodule