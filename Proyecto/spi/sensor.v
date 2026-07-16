module sensor (clk , cs , so);
  input clk;
  input cs;
  output reg so;

always @(posedge clk) begin
  if (cs) begin
   so = 0;
  end 
    else begin 
        if(so == 0)
        so <= 1;
        else if (so == 1)
        so <= 0;
    end
    end
endmodule