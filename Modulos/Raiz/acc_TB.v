`timescale 1ns / 1ps
`define SIMULATION

module acc_TB;

   reg clk;
   reg addi;
   reg rst;
   wire w_C;
   wire [5:0]i;

   acc uut( .clk(clk) , .i(i) , .addi(addi) , .rst(rst)  , .c(w_C));

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
      rst = 0; addi = 0; 
   end

   reg [3:0] k;
   initial begin // Reset the system, Start the image capture process
        #20 rst = 1;
        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        @ (posedge clk);
        @ (negedge clk);
        addi = 1;
       for(k=0; k<10; k=k+1) begin
         @ (posedge clk);
       end
   end


   initial begin: TEST_CASE
     $dumpfile("acc_TB.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
   end
endmodule
