`timescale 1ns / 1ps
`define SIMULATION

module paridad_TB;

 reg clk;
 reg rst;
 reg init;
 reg [6:0]A;

 wire done;
 wire [7:0]result;

 paridad uut( .clk(clk), .rst(rst), .init(init), .done(done) , .A(A) , .pp(result) );

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
      rst = 0;init = 0; A = 7'b1111110;
   end


   reg [2:0] i;
   initial begin // Reset the system, Start the image capture process
        @ (posedge clk);
        rst = 1;
        @ (posedge clk);
        rst = 0;
        @ (negedge clk);

        init = 1;
        @ (negedge clk);
        init = 0;
        @ (posedge clk);
        @(posedge clk);
        @ (posedge clk);
        @ (negedge clk);
        

       end

   initial begin: TEST_CASE
     $dumpfile("paridad_TB.vcd");
     $dumpvars(-1, uut);
     #(10000) $finish;
   end
endmodule