`timescale 1ns / 1ps
`define SIMULATION

module divisor_TB;

 reg clk;
 reg rst;
 reg init;
 reg [15:0]A;
 reg [15:0]B;
 
 wire done;
 wire [15:0]result;

 divisor uut( .clk(clk), .rst(rst), .init(init), .done(done) , .A(A), .B(B) , .pp(result) );

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
      rst = 0;init = 0; A = 16'd100; B = 16'd5;
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
     $dumpfile("divisor_TB.vcd");
     $dumpvars(-1, uut);
     #(10000) $finish;
   end
endmodule