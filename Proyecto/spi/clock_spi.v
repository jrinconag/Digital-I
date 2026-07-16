module clock_spi (clk , i, rst , frec);
  input clk;
  input rst;
  output reg frec;
  output reg [5:0] i;

always @(negedge clk) begin
  if (rst) begin
   i    <= 0;
   frec <= 0;
   //cada ciclo dura 40ns, solo ajustar el i== 

  end else begin 
      begin
        i <= i + 1;
      end
      if (i == 5 && frec == 0)begin
          frec <= 1;
          i <= 0;
      end 
      if (i == 5 && frec == 1)begin
          frec <= 0;
          i <= 0;
      end 
  end
end
endmodule
