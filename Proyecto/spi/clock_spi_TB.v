`timescale 1ns / 1ps
`define SIMULATION

module clock_spi_TB;

   reg clk;
   reg rst;
   wire [5:0]i;
   wire frec;

   clock_spi uut( .clk(clk) , .i(i) , .rst(rst), .frec(frec));

   parameter PERIOD          = 40;
   parameter real DUTY_CYCLE = 0.5;
   parameter OFFSET          = 0;

   initial  begin  // Process for clk
     #OFFSET;
     forever
       begin
         clk = 1'b0;
         #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
         #(PERIOD*DUTY_CYCLE);
       end
   end

   initial begin // Reset the system, Start the image capture process
      rst = 0; 
   end

   reg [3:0] k;
   initial begin // Reset the system, Start the image capture process
        #40 rst = 1;
        @ (posedge clk);
        @ (negedge clk);
        rst = 0; 
        @ (posedge clk);
        @ (negedge clk);
      for(k=0; k<10; k=k+1) begin
         @ (posedge clk);
       end

   end


   initial begin: TEST_CASE
     $dumpfile("clock_spi_TB.vcd");
     $dumpvars(-1, uut);
     #(5000) $finish;
   end
endmodule
