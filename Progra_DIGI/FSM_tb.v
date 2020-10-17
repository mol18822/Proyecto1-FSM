// Luis Pedro Molina Velásquez - Carné 18822
// Electrónica Digital 1 - Sección 12
// Proyecto 1 - Máquinas de Estados Finitos

// Máquina seleccionadora de menú con dispensador de bebida incluido

// TESTBENCH

module testbench();

reg clk, reset, set,  ON, CONT, CONTm1, CONTm2, CONTm3;

wire TIME;       wire TIME2; 
reg [1:0]SELE;   reg [2:0]SELEm1;   reg [2:0]SELEm2;    reg [2:0]SELEm3;        reg [1:0]SELEB1;        reg [1:0]SELEB2;        reg [1:0]SELEB3;        reg [1:0]SELEB4;        reg M1;
wire [2:0]A;     wire [2:0]Am1;     wire [2:0]Am2;      wire [2:0]Am3;          wire [2:0]AB1;          wire [2:0]AB2;          wire [2:0]AB3;          wire [2:0]AB4;          wire [2:0]AF1;
wire [2:0]F;     wire [2:0]Fm1;     wire [2:0]Fm2;      wire [2:0]Fm3;          wire [2:0]FB1;          wire [2:0]FB2;          wire [2:0]FB3;          wire [2:0]FB4;          wire [2:0]FF1;
wire [2:0]MENU;  wire [3:0]OP;      wire [3:0]G;        wire [3:0]B;            wire [1:0]SB1;          wire [1:0]SB2;          wire [1:0]SB3;          wire [1:0]SB4;          wire DONE;
wire ENABLE;     wire ENABLE1;


FSM_BIENVENIDA FSM0 (clk, reset, F, A, ON, CONT, TIME, SELE, MENU, ENABLE);
FSM_MENU1 FSM1 (clk, reset, Fm1, Am1, MENU, CONTm1, TIME, SELEm1, OP, ENABLE);
FSM_MENU2 FSM2 (clk, reset, Fm2, Am2, OP, CONTm2, TIME, SELEm2, G, ENABLE);
FSM_MENU3 FMS3 (clk, reset, Fm3, Am3, G, CONTm3, TIME, SELEm3, B, ENABLE);
FSM_B1 B1 (clk, reset, FB1, AB1, B, SELEB1, SB1);
FSM_B2 B2 (clk, reset, FB2, AB2, B, SELEB2, SB2);
FSM_B3 B3 (clk, reset, FB3, AB3, B, SELEB3, SB3);
FSM_B4 B4 (clk, reset, FB4, AB4, B, SELEB4, SB4);
FSM_LLENADOB1 B_1 (clk, reset, FF1, AF1, TIME, TIME2, SB1, M1, DONE, ENABLE1);

Timer TIM(ENABLE, TIME);
Timer2 TIM2(ENABLE1, TIME2);


initial begin
    clk=1;
    forever #5 clk = ~clk;
end

    initial begin
    
        #1 
        $display (" ");
        $display("Proyecto 1 - FSM");
        $display("");
        $display(" ON  CONT  CONTm1  CONTm2  CONTm3  SELE  SELEm1  SELEm2  SELEm3  SELEB1  SELEB2  SELEB3  SELEB4  MENU   OP     G      B    SB1  SB2  SB3  SB4  M1 | DONE  ");
        $display(" -------------------------------------------------------------------------------------------------------------------------------------------------|-------");
        $monitor(" %b    %b      %b       %b       %b      %b     %b     %b    %b      %b      %b      %b      %b    %b   %b   %b   %b   %b   %b   %b   %b   %b |   %b     ", ON, CONT, CONTm1, CONTm2, CONTm3, SELE, SELEm1, SELEm2, SELEm3, SELEB1, SELEB2, SELEB3, SELEB4, MENU, OP, G, B, SB1, SB2, SB3, SB4, M1, DONE);
       
            reset = 0 ; ON = 0 ; CONT = 0; SELE = 2'b00; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ;
        #1  reset = 1 ;
        #1  reset = 0 ; 

       
        // Prueba de que la Interfaz de Bienvenida (Seleccionador de menús) solo se activa con "ON = 1"

        #7   ON = 0 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ;
        #10  ON = 0 ; CONT = 1 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ;
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b01 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ;
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b10 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ;
        #10  ON = 1 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ;  // Máquina encendida
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b11 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ;

        $display("");
        #5  reset = 1 ;
        #5  reset = 0 ;
        
        // Prueba de que el timer funciona correctamente.

        #0   ON = 1 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ;  // Máquina encendida
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b01 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ;
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b11 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ;

        $display("");
        #5  reset = 1 ;
        #5  reset = 0 ; 

        // Probando funcionamiento completo de la máquina:

        #7   ON = 1 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ; // Encendido de máquina
        #10  ON = 0 ; CONT = 1 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ; // Continuar a selección de menús
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b01 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ; // Elección de Menú 1 - Platos Fuertes

        #10  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ; // Transición

        #10  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 1 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ; // Continuar a selección de Platos Fuertes 
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b011 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ;// Elección de Plato Fuerte #3 - Lasagna 

        #10  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ; // Transición

        #10  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 1 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ; // Continuar a selección de Guarniciones
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b100 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ; // Elección de Guarnición #4 - Ensalada y pure de papa

        #10  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ; // Transición

        #10  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 1 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ; // Continuar a selección de Bebidas
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b001 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ; // Elección de Bebida #1

        #10  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ; // Transición 

        #10  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b10 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ; // Seleccionando tamaño pequeño

        #10  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ; // Transición 

        #10  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 1 ; // Encendido de motor para llenado de bebida

        #10  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; CONTm1 = 0 ; SELEm1 = 3'b000 ; CONTm2 = 0 ; SELEm2 = 3'b000 ; CONTm3 = 0 ; SELEm3 = 3'b000 ; SELEB1 = 2'b00 ; SELEB2 = 2'b00 ; SELEB3 = 2'b00 ; SELEB4 = 2'b00 ; M1 = 0 ; // Transición  


        $display("");
        #5  reset = 1 ;
        #5  reset = 0 ;

    end

    initial
    #200  $finish;

initial
    begin
        $dumpfile("FSM_tb.vcd");
        $dumpvars(0, testbench);
    end
endmodule