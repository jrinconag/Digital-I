module shiftL_div(clk , in_A , o_A, sh , rst, ld, RTA, B, r);
  input clk;
  input rst;
  input sh;
  input ld;
  input r;
  
  input [15:0]B;
  input [15:0]in_A;
  
  output reg [31:0]o_A;
  output reg [15:0]RTA;


  reg [15:0]x;

  always @(negedge clk) begin
    RTA = o_A[15:0];
    //x = temp - B;

    if (rst) begin
        o_A[31:0] <= {16'd0,in_A[15:0]};
        RTA[15:0] <= 16'd0;
    end
    else begin

        if (sh) begin
            o_A[31:0] <= {o_A[30:0], 1'b0 };   
        end
            else begin
              o_A   <= o_A;
            end

        if(r)begin
        o_A[31:16] <= o_A[31:16] + (~B+1);
        end

        if (ld) begin

         o_A[31:0] <= {o_A[30:0], 1'b1};
        end
        
    end
end

endmodule