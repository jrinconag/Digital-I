module control_raiz( clk , rst , init , c , msb  , reset , sh ,  sh2, addi , ld  , done );

 input clk;
 input rst;
 input init;

// Estos son las señales entrada del Bloque de control:
 input c;
 input msb;

//Estos son las señales de salida del bloque de control:
 output reg reset;
 output reg sh;
 output reg sh2;
 output reg addi;
 output reg ld;
 output reg done;


 parameter START  = 3'b000;
 parameter RCI = 3'b001;
 parameter RCI2 = 3'b010;
 parameter CHECKSB  = 3'b011;
 parameter WRITE_RTA  = 3'b100; 
 parameter CHECK_I   = 3'b101;
 parameter FINISH    = 3'b110;

 reg [2:0] state;


 initial begin
  sh = 0;
  sh2 = 0;
  ld = 0;
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
        sh2      <= 0;   
        ld <= 0;
        addi    <= 0; 
        done    <= 0;
        reset   <= 1;
        if(init)
          state <= RCI;
        else
          state <= START;
      end

      RCI: begin
      sh      <= 1;
      sh2      <= 0;
      ld <= 0;
      addi    <= 1; 
      done    <= 0;
      reset   <= 0;
      state = RCI2;
      end

      RCI2: begin
      sh      <= 0;
      sh2      <= 1;
      ld <= 0;
      addi    <= 0; 
      done    <= 0;
      reset   <= 0;
      state <= CHECKSB;
      end


     CHECKSB: begin
      sh      <= 0;
      sh2      <= 0;   
      ld <= 0;
      addi    <= 0; 
      done    <= 0;
      reset   <= 0;

      if(msb)
        state <= CHECK_I;
      else
        state <= WRITE_RTA;

     end

     WRITE_RTA: begin
      sh      <= 0;
      sh2      <= 0;
      ld <= 1;
      addi    <= 0; 
      done    <= 0;
      reset   <= 0;
      state = CHECK_I;
     end

     CHECK_I: begin
      sh      <= 0;
      sh2      <= 0;
      ld <= 0;
      addi    <= 0; 
      done    <= 0;
      reset   <= 0;
      if (c)
        state <= FINISH;
      else
        state <= RCI;
     end
    
     FINISH:begin
        done  <= 1;
        sh      <= 0;
        sh2      <= 0;
        ld <= 0;
        addi    <= 0; 
        reset   <= 0;
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
    RCI    : state_name = "RCI";
    RCI2    : state_name = "RCI2";
    CHECKSB    : state_name = "CHECKSB";
    WRITE_RTA    : state_name = "WRITE_RTA";
    CHECK_I      : state_name = "CHECK_I";
    FINISH      : state_name = "FINISH";
  endcase
end
`endif



endmodule