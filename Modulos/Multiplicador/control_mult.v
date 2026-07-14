module control_mult( clk , rst , init , done , c , lsb  , reset , sh , ld  );

 input clk;
 input rst;
 input init;

// Estos son las señales entrada del Bloque de control:
 input lsb;
 input c;

//Estos son las señales de salida del bloque de control:
 output reg reset;
 output reg sh;
 output reg ld;

 output reg done;

 parameter START         = 3'b000;
 parameter B_CHECK       = 3'b001;
 parameter LSB_CHECK     = 3'b010;
 parameter SHIFT         = 3'b011;
 parameter SUM           = 3'b100;
 parameter FINISH        = 3'b101;

 reg [2:0] state;

 initial begin
  sh = 0;
  ld   = 0; 
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
        ld      <= 0; 
        done    <= 0;
        reset   <= 1;
        if(init)
          state <= B_CHECK;
        else
          state <= START;
      end

     B_CHECK: begin
        sh    <= 0;
        ld    <= 0; 
        done  <= 0;
        reset <= 0;
      if(c)
        state <= FINISH;
      else
        state <= LSB_CHECK;
     end

     LSB_CHECK: begin
        sh    <= 0;
        ld    <= 0; 
        done  <= 0;
        reset <= 0;
      if (lsb)
        state <= SUM;
      else
        state <= SHIFT;
     end

     SUM: begin
        sh    <= 0;
        ld    <= 1; 
        done  <= 0;
        reset <= 0;
        state <= SHIFT;
     end

     SHIFT: begin
        sh    <= 1;
        ld    <= 0; 
        done  <= 0;
        reset <= 0;
        state <= B_CHECK;
     end

    
     FINISH:begin
        done  <= 1;
        sh    <= 0;
        ld    <= 0; 
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
    B_CHECK    : state_name = "B_CHECK";
    LSB_CHECK    : state_name = "LSB_CHECK";
    SHIFT    : state_name = "SHIFT";
    SUM      : state_name = "SUM";
    FINISH      : state_name = "FINISH";
  endcase
end
`endif



endmodule