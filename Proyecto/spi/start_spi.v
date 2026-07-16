module start_spi (clk , i, in_init , out_init, cs);
  input clk;
  input in_init;
  output reg out_init;
  output reg [18:0] i;
  output reg cs;

always @(negedge clk) begin
 
  if (i>0)
  out_init = out_init;
  else if (in_init) begin
   i    <= 0;
   out_init <= 0;
   cs <= 1;
 end 

      if (i == 1)begin
         out_init <= 0;
         cs <=0;
      end 
      if (i == 18) begin
        cs <= 1;
      end
                    begin
         i = i +1;
      end
      if (i == 50000)begin
          out_init <= 1;
          i <= 1;
      end 

end
endmodule
