// Luis Pedro Molina Velásquez - Carné 18822
// Electrónica Digital 1 - Sección 12
// Proyecto 1 - Máquinas de Estados Finitos

// Máquina seleccionadora de menú con dispensador de bebida incluido

// TESTBENCH

module testbench();

reg clk, reset, set,  ON, CONT; 
reg [1:0]SELE;
wire TIME;
wire [2:0]A;
wire [2:0]F;
wire [2:0]DISP;
wire [2:0]MENU;
wire ENABLE;

FSM_BIENVENIDA FSM(clk, reset, F, A, ON, CONT, TIME, SELE, DISP, MENU, ENABLE);
Timer TIM(ENABLE, TIME);
initial begin
    clk=1;
    forever #5 clk = ~clk;
end

    initial begin
    
        #1 
        $display (" ");
        $display(" Proyecto 1 - FSM");
        $display("    A     ON    CONT   TIME    SELE | F      MENU     DISP   ENABLE ");
        $display(" --------------------------------| ---------------------------- ");
        $monitor(" %b    %b      %b      %b       %b | %b     %b     %b      %b  ", A, ON, CONT, TIME, SELE, F, MENU, DISP, ENABLE);

            reset = 0 ; ON = 0 ; CONT = 0; SELE = 2'b00; 
        #1  reset = 1 ;
        #1  reset = 0 ; 

        // Prueba de que la Interfaz de Bienvenida (Seleccionador de menús) solo se activa con "ON = 1"
        #7   ON = 0 ; CONT = 0 ; SELE = 2'b00 ; 
        #10  ON = 0 ; CONT = 1 ; SELE = 2'b00 ; 
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b01 ; 
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b10 ;  
        #10  ON = 1 ; CONT = 0 ; SELE = 2'b00 ;
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b11 ;    

        #5  reset = 1 ;
        #5  reset = 0 ;

        // Prueba de que el timer funciona correctamente.

        #0   ON = 1 ; CONT = 0 ; SELE = 2'b00 ;
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b01 ;
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b11 ;

        #5  reset = 1 ;
        #5  reset = 0 ; 
        
        // Probando elección de Menú 1 - Platos Fuertes
        #0   ON = 1 ; CONT = 0 ; SELE = 2'b00 ;
        #10  ON = 0 ; CONT = 1 ; SELE = 2'b00 ;
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b01 ;
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; 
    
        #5  reset = 1 ;
        #5  reset = 0 ;

        // Probando elección de Menú 2 - Guarniciones 
        #0   ON = 1 ; CONT = 0 ; SELE = 2'b00 ;
        #10  ON = 0 ; CONT = 1 ; SELE = 2'b00 ;
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b10 ;
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; 

        #5  reset = 1 ;
        #5  reset = 0 ;

        // Probando elección de Menú 3 - Bebidas
        #0   ON = 1 ; CONT = 0 ; SELE = 2'b00 ;
        #10  ON = 0 ; CONT = 1 ; SELE = 2'b00 ;
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b11 ;
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; 

        #5  reset = 1 ;
        #5  reset = 0 ;





        // Prueba de transción a Menú 1 - Platos Fuertes

       /* #10  ON = 1 ; CONT = 0 ; SELE = 2'b00 ;
        #10  ON = 0 ; CONT = 1 ; SELE = 2'b00 ;
        #10  ON = 0 ; CONT = 0 ; SELE = 2'b01 ;
/*
        // Prueba de transición a Menú 2 - Guarniciones
        #10 ON = 1 ; CONT = 0 ; SELE = 2'b00 ; 
        #10 ON = 0 ; CONT = 1 ; SELE = 2'b00 ;
        #10 ON = 0 ; CONT = 0 ; SELE = 2'b10 ;

        // Prueba de transición a Menú 3 - Bebidas
        #10 ON = 1 ; CONT = 0 ; SELE = 2'b00 ;
        #10 ON = 0 ; CONT = 1 ; SELE = 2'b00 ;
        #10 ON = 0 ; CONT = 1 ; SELE = 2'b11 ; 

        
        #16  ON = 0 ; CONT = 1 ; TIME = 0 ; SELE = 2'b00 ;
        #26  ON = 0 ; CONT = 0 ; TIME = 1 ; SELE = 2'b00 ;
        #36  ON = 0 ; CONT = 0 ; TIME = 0 ; SELE = 2'b00 ;
        #46  ON = 0 ; CONT = 0 ; TIME = 0 ; SELE = 2'b01 ;
        #56  ON = 0 ; CONT = 0 ; TIME = 0 ; SELE = 2'b10 ;
        #66  ON = 0 ; CONT = 0 ; TIME = 0 ; SELE = 2'b11 ;

        // Prueba de que el timer funciona, regresa de S0 a SR si "CONT = 0" y "TIME = 1" 
        #76  ON = 0 ; CONT = 0 ; TIME = 0 ; SELE = 2'b00 ;  // S0
        #86  ON = 0 ; CONT = 0 ; TIME = 1 ; SELE = 2'b00 ;  // SR

        // Probando selección de menú 1 - Platos fuertes
        #96  ON = 1 ; CONT = 0 ; TIME = 0 ; SELE = 2'b00 ; // S0 
        #106 ON = 0 ; CONT = 1 ; TIME = 0 ; SELE = 2'b00 ; // S1 
        #116 ON = 0 ; CONT = 0 ; TIME = 0 ; SELE = 2'b01 ; // S2 - Menú 1 y regresa a SR 

        // Probando selección de menú 2 - Guarniciones
        #126 ON = 1 ; CONT = 0 ; TIME = 0 ; SELE = 2'b00; // S0
        #136 ON = 0 ; CONT = 1 ; TIME = 0 ; SELE = 2'b00; // S1
        #146 ON = 0 ; CONT = 0 ; TIME = 0 ; SELE = 2'b10; // S2 - Menú 2
        
        // Probando selección de menú 3 - Bebidas 
        #156 ON = 1 ; CONT = 0 ; TIME = 0 ; SELE = 2'b00; // S0
        #166 ON = 0 ; CONT = 1 ; TIME = 0 ; SELE = 2'b00; // S1
        #176 ON = 0 ; CONT = 0 ; TIME = 0 ; SELE = 2'b11; // S3 - Menú 3
*/





        /*
        #6  ON = 0 ; CONT = 0 ; SELE = 2'b01 ; // SR
        #6  ON = 0 ; CONT = 0 ; SELE = 2'b10 ; // SR
        #6  ON = 0 ; CONT = 0 ; SELE = 2'b11 ; // SR*/

/*
        // Prueba de que el timer funciona, regresa de S0 a SR si "CONT = 0" y "TIME = 1" 
        #6  ON = 1 ; CONT = 0 ; SELE = 2'b00 ; // S0
        #6  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; // S0
        #6  ON = 0 ; CONT = 0 ; SELE = 2'b00 ; // SR

        // Probando selección de menú 1 - Platos fuertes
        #6 ON = 1 ; CONT = 0 ; SELE = 2'b00 ; // S0 
        #6 ON = 0 ; CONT = 1 ; SELE = 2'b00 ; // S1 
        #6 ON = 0 ; CONT = 0 ; SELE = 2'b01 ; // S2 - Menú 1 y regresa a SR 

        // Probando selección de menú 2 - Guarniciones
        #6 ON = 1 ; CONT = 0 ; SELE = 2'b00; // S0
        #6 ON = 0 ; CONT = 1 ; SELE = 2'b00; // S1
        #6 ON = 0 ; CONT = 0 ; SELE = 2'b10; // S2 - Menú 2
        
        // Probando selección de menú 3 - Bebidas 
        #6 ON = 1 ; CONT = 0 ; SELE = 2'b00; // S0
        #6 ON = 0 ; CONT = 1 ; SELE = 2'b00; // S1
        #6 ON = 0 ; CONT = 0 ; SELE = 2'b11; // S3 - Menú 3

*/
    end

    initial
    #250  $finish;

initial
    begin
        $dumpfile("FSM_tb.vcd");
        $dumpvars(0, testbench);
    end
endmodule





