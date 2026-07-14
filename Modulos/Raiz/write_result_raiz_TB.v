`timescale 1ns / 1ps
`define SIMULATION

module write_result_raiz_TB;

   reg clk;
   reg sh;
   reg rst;
   reg ld;

   wire [31:0] result;

   write_result_raiz uut(clk , sh , ld , rst , result);

   parameter PERIOD          = 20;
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
      rst = 0; sh = 0; ld = 0; 
   end

   reg [2:0] i;
   initial begin // Reset the system, Start the image capture process
        rst = 1;
        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        ld = 1;
        @ (posedge clk);
        ld = 0;
        @ (negedge clk);
        sh = 1;
       for(i=0; i<4; i=i+1) begin
         @ (posedge clk);
       end
   end


   initial begin: TEST_CASE
     $dumpfile("write_result_raiz_TB.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
   end
endmodule