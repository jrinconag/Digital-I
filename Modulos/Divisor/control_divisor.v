module control_div( clk , rst , init , done , z , c, reset , sh , addi , ld, r );

 input clk;
 input rst;
 input init;

// Estos son las señales entrada del Bloque de control:
 input z;
 input c;

//Estos son las señales de salida del bloque de control:
 output reg reset;
 output reg sh;
 output reg addi;
 output reg ld;
 output reg r;

 output reg done;

 parameter START          = 3'b000;
 parameter SHIFT          = 3'b001;
 parameter TEMP_CHECK     = 3'b010;
 parameter LOAD           = 3'b011;
 parameter FIN_CHECK      = 3'b100;
 parameter FINISH         = 3'b101;
 parameter R = 3'b111;

 reg [2:0] state;

 initial begin
  sh = 0;
  addi  = 0; 
  done  = 0;
  reset = 0;
  state = 0;
  ld = 0;
  r = 0;
 end

 // Este es el que hace esperar en finish para que en el programa alcance a leer el DONE.
 reg [4:0] count; /////////////////////////
 reg [4:0] count2;

always @(posedge clk) begin
    if (rst) begin
      count = 0;
      count2 = 0;
      state = START;
    end else begin
    case(state)

      START:begin
        sh = 0;
        addi  = 0; 
        done  = 0;
        reset = 1;
        ld = 0;
        if(init)
          state <= SHIFT;
        else
          state <= START;
      end

      SHIFT: begin
        sh = 1;
        addi  = 1; 
        done  = 0;
        reset = 0;

        state <= TEMP_CHECK;
     end

     TEMP_CHECK: begin
        sh = 0;
        addi  = 0; 
        done  = 0;
        reset = 0;
        count2 = count2 + 1;
        if(count2==3)begin
        if(c)
          state <= R;
        else
          state <= FIN_CHECK;
        end
     end


    R: begin
        sh = 0;
        r = 1;
        addi  = 0; 
        done  = 0;
        reset = 0;
        ld    = 0;
        state <= LOAD;
     end

    LOAD: begin
        sh = 0;
        r = 0;
        addi  = 0; 
        done  = 0;
        reset = 0;
        ld    = 1;
        state <= FIN_CHECK;
     end

     FIN_CHECK: begin
        sh = 0;
        addi  = 0; 
        done  = 0;
        reset = 0;
        ld = 0;
        if(z)
          state <= FINISH;
        else
          state <= SHIFT;
     end
    
     FINISH:begin
        sh = 0;
        addi  = 0; 
        done  = 1;
        reset = 0;
        count = count + 1;
		state = (count>29) ? START : FINISH ;  // hace falta de 10 ciclos de reloj, para que lea el done y luego cargue el resultado
     end

     default: state = START;
   endcase
  end
end

`ifdef BENCH
reg [8*40:1] state_name;
always @(*) begin
  case(state)
    START    : state_name = "START";
    SHIFT    : state_name = "SHIFT";
    TEMP_CHECK    : state_name = "TEMP_CHECK";
    LOAD    : state_name = "LOAD";
    FIN_CHECK    : state_name = "FIN_CHECK";
    FINISH      : state_name = "FINISH";
  endcase
end
`endif




endmodule