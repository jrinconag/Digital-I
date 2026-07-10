`timescale 1ns / 1ps
`define SIMULATION

module shiftR_7_TB_M;

   reg clk;
   reg sh;
   reg rst;
   reg [6:0]A;
   wire [6:0] out_A;

   shiftR_7_M uut( .clk(clk) , .sh(~sh) , .rst(rst) , .in_A(A) , .s_A(out_A) );

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
      rst = 0; sh = 0; A = 7'd22;
   end

   reg [2:0] i;
   initial begin // Reset the system, Start the image capture process
        rst = 1;
        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        @ (posedge clk);
        @ (negedge clk);
        sh = 1;
       for(i=0; i<4; i=i+1) begin
         @ (posedge clk);
       end
   end


   initial begin: TEST_CASE
     $dumpfile("shiftR_7_TB_M.vcd");
     $dumpvars(-1, uut);
     #(1000) $finish;
   end
endmodule