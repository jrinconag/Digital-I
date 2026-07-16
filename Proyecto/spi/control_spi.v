module control_spi( clk , rst , init , c , z  , reset , sh , inc , done );

 input clk;
 input rst;
 input init;

// Estos son las señales entrada del Bloque de control:
 input c;
 input z;

//Estos son las señales de salida del bloque de control:
 output reg reset;
 output reg sh;
 output reg inc;
 output reg done;


 parameter START       = 3'b000;
 parameter RCI         = 3'b001;
 parameter CHECK_I     = 3'b010;
 parameter ADD         = 3'b011;
 parameter FIN_CHECK   = 3'b100;
 parameter FINISH      = 3'b101;

 reg [2:0] state;

 initial begin
  sh = 0;
  inc   = 0; 
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
        inc    <= 0; 
        done    <= 0;
        reset   <= 1;
        if(init)
          state <= RCI;
        else
          state <= START;
      end

     RCI: begin
        sh    <= 1;
        inc   <= 1; 
        done  <= 0;
        reset <= 0;
      if(c)
        state <= ADD;
      else
        state <= RCI;
     end

     ADD: begin
        sh    <= 0;
        inc   <= 1; 
        done  <= 0;
        reset <= 0;
      if (z)
        state <= FINISH;
      else
        state <= ADD;
     end

    
     FINISH:begin
        done  <= 1;
        sh      <= 0;
        inc    <= 0; 
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
    CHECK_I    : state_name = "CHECK_I";
    ADD    : state_name = "ADD";
    FIN_CHECK      : state_name = "FIN_CHECK";
    FINISH      : state_name = "FINISH";
  endcase
end
`endif



endmodule