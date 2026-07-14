`timescale 1ns / 1ps
`define SIMULATION

module shiftL_32_raiz_TB;

  reg clk;
  reg rst;

  reg [15:0] in_RES;
  reg [15:0] in_A;
  wire [31:0] s_A;
  
  reg sh;
  reg ld;

   shiftL_32_raiz uut(.clk(clk) , .in_A(in_A) , .in_RES(in_RES) , .s_A(s_A) , .ld(ld) , .sh(sh) , .rst(rst));

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

   initial begin  // Initialize Inputs
      in_RES = 16'd15; in_A = 32'd20; sh = 0; ld = 0; rst = 1;
   end

   reg [2:0] i;
   initial begin // Reset the system, Start the image capture process
        
        @ (posedge clk);
        @ (negedge clk);
        rst = 0;
        @ (posedge clk);
        ld = 1;
        @ (negedge clk);
        @ (posedge clk);
        @ (negedge clk);
        ld = 0;
        @ (posedge clk);
        @ (negedge clk);
        sh = 1;
        @ (posedge clk);
        @ (negedge clk);
        @ (posedge clk);
        @ (negedge clk);
        sh = 0;
        @ (posedge clk);
        @ (negedge clk);
        ld = 1;
       @ (posedge clk);
        @ (negedge clk);
        ld = 0;

       for(i=0; i<20; i=i+1) begin
         @ (posedge clk);
       end
   end

   initial begin: TEST_CASE
     $dumpfile("shiftL_32_raiz_TB.vcd");
     $dumpvars(-1, uut);
     #(200) $finish;
   end
endmodule