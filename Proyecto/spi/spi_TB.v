`timescale 1ns / 1ps
`define SIMULATION

module spi_TB;

 reg clk;
 reg rst;
 reg init;
 reg A;

 wire cs;
 wire sck;
 wire done;
 wire [11:0]result;

 spi uut( .clk(clk), .rst(rst), .init(init), .done(done) , .A(A) , .pp(result), .cs(cs) , .sck(sck) );

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
      rst = 0;init = 0; A = 0;
   end

   initial begin // Reset the system, Start the image capture process
        @ (posedge clk);
        rst = 1;
        @ (posedge clk);
        rst = 0;
        @ (negedge clk);

        init = 1;
        @ (posedge clk);

        init = 0;
        @ (posedge clk);
        @ (negedge clk);
        @ (posedge clk);
        @ (negedge clk);
        A = 1;
       end

   initial begin: TEST_CASE
     $dumpfile("spi_TB.vcd");
     $dumpvars(-1, uut);
     #(100000000) $finish;
   end
endmodule