module write_result_raiz (clk , sh , ld , rst , result);
  input clk;
  input sh;
  input rst;
  input ld;

  output reg [7:0] result;

always @(negedge clk) begin
    if (rst) begin
        result <= 16'b0;
    end
    else begin
        if (sh) begin
            result <= {result[15:0],1'b0};
        end
        else begin
            if (ld)
              result[0] <= 1'b1;
            else 
              result <= result;
        end
    end
end
endmodule