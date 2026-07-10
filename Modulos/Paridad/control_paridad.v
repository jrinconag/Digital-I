module control_paridad( clk , rst , init , c , lsb  , reset , sh , addi , done );

 input clk;
 input rst;
 input init;

// Estos son las señales entrada del Bloque de control:
 input c;
 input lsb;

//Estos son las señales de salida del bloque de control:
 output reg reset;
 output reg sh;
 output reg addi;
 output reg done;


 parameter START  = 3'b000;
 parameter A_CHECK = 3'b001;
 parameter ADD  = 3'b010;
 parameter SHIFT  = 3'b011;
 parameter FIN_CHECK   = 3'b100;
 parameter FINISH    = 3'b101;

 reg [2:0] state;

 initial begin
  sh = 0;
  addi   = 0; 
  done  = 0;
  reset = 0;
  state = 0;
 end

 // Este es el que hace esperar en finish para que en el programa alcance a leer el DONE.
 reg [4:0] count; /////////////////////////

always @(posedge clk) begin
    if (rst) begin
      count = 0;
      state = START;
    end else begin
    case(state)

      START:begin
        sh      <= 0;
        addi    <= 0; 
        done    <= 0;
        reset   <= 1;
        if(init)
          state <= A_CHECK;
        else
          state <= START;
      end

     A_CHECK: begin
        sh = 0;
        addi  = 0; 
        done  = 0;
        reset = 0;
      if(lsb)
        state <= ADD;
      else
        state <= SHIFT;
      end

     ADD: begin
      sh      <= 0;
      addi    <= 1; 
      done    <= 0;
      reset   <= 0;
      state <= SHIFT;
     end

     SHIFT: begin
        sh = 1;
        addi   = 0; 
        done  = 0;
        reset = 0;
      state = FIN_CHECK;
     end

     FIN_CHECK: begin
        sh = 0;
        addi   = 0; 
        done  = 0;
        reset = 0;
      if (c)
        state <= FINISH;
      else
        state <= A_CHECK;
     end
    
     FINISH:begin
        done  <= 1;
        sh      <= 0;
        addi    <= 0; 
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
    A_CHECK    : state_name = "A_CHECK";
    ADD    : state_name = "ADD";
    SHIFT    : state_name = "SHIFT";
    FIN_CHECK      : state_name = "FIN_CHECK";
    FINISH      : state_name = "FINISH";
  endcase
end
`endif



endmodule