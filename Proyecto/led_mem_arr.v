module led_mem_arr(clk , addr, ld , RGB, in_RGB, w_addr, addr2, addr3, win, lose);

   input  clk;
   input  ld; //señal de control para escritura
   input  addr;
 
   output reg [23:0] RGB;

   //entradas para escritura caballo
   //input  [23:0] in_RGB;

   //input  [8:0] w_addr;
   //input  [8:0] addr2;
   //input  [8:0] addr3;

   //señales para win/lose
   input win;
   input lose;

   reg [23:0] memoria [0:255];

    initial begin
        $readmemh("./display.hex",memoria);
    end

    always @(negedge clk) begin 


        if(win)begin
            $readmemh("./display_win.hex",memoria);
        end

        if(lose)begin
            $readmemh("./display_lose.hex",memoria);
        end
       
        if(ld)begin
        //memoria[addr2 + w_addr + w_addr ]           <= in_RGB;
        //memoria[addr2 + w_addr + w_addr + 1]        <= in_RGB;
        //memoria[addr2 + w_addr + w_addr + addr3]    <= in_RGB;
        //memoria[addr2 + w_addr + w_addr + addr3 +1] <= in_RGB;
        end

        else begin
        RGB <= memoria[addr];
        end
    end


  //rojo:  FF0000
  //azul:  0000FF
  //verde: 00FF00

endmodule