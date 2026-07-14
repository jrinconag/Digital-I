module comp(clk, A, aux, res, z );
  input clk;
  input [15:0]A;
  input [15:0]aux;
  output reg [15:0]res;
  output reg z;

  reg [15:0]x;
  always@(*) begin
  x = A + ~(aux + 1)+1;

    if (x[15])begin
     res <= A;
     z = 0;
    end
    else begin
     res <=  A + ~(aux + 1)+1;
     z = 1;
    end
 end
endmodule