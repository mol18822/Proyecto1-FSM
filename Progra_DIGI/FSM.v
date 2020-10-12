// Luis Pedro Molina Velásquez - Carné 18822
// Electrónica Digital 1 - Sección 12
// Proyecto 1 - Máquinas de Estados Finitos

// Máquina seleccionadora de menú con dispensador de bebida incluido

// FlipFlop tipo D de 3 bits

module FlipFloptipoD3Bits(input wire [2:0] D, input wire clk, input wire reset, output [2:0] Q);
reg Q;
    always @(posedge clk or posedge reset)
        if(reset)
            Q <= 3'b000;
    else begin
            Q <= D; 
    end
    
endmodule

// Timer 1 

module Timer (input wire ENABLE, output reg TIME);
    always @ (ENABLE) begin
        if (ENABLE == 0) begin
            TIME = 0;
        end while(ENABLE) begin
            TIME = 0;
            #5 TIME = 1;
            #5 TIME = 0;
        end
        
    end
endmodule

module FSM_BIENVENIDA (input wire clk, reset, output wire [2:0]F, output wire [2:0]A, input wire ON, input wire CONT, input wire TIME, input wire [1:0]SELE, output wire [2:0]DISP, output wire [2:0]MENU, output wire ENABLE);

    FlipFloptipoD3Bits U1(F, clk, reset, A); 

// INTERFAZ DE BIENVENIDA - SELECCIÓN DE MENÚS 

    assign F[2]    = (~A[2] & A[1] & ~A[0] & SELE[1]) | (~A[2] & A[1] & ~A[0] & SELE[0]);
    assign F[1]    = (~A[2] & ~A[1] & A[0] & CONT) | (~A[2] & A[1] & ~A[0] & SELE[1] & SELE[0]) | (~A[2] & A[1] & ~A[0] & ~SELE[1] & ~SELE[0]);
    assign F[0]    = (~A[2] & ~A[1] & ~A[0] & ON) | (~A[2] & ~A[1] & A[0] & ~CONT & ~TIME) | (~A[2] & A[1] & ~A[0] & SELE[1] & ~SELE[0]);
    assign MENU[2] = (A[2] & ~A[1] & ~A[0]);
    assign MENU[1] = (A[2] & ~A[1] & A[0]);
    assign MENU[0] = (A[2] & A[1] & ~A[0]);
    assign DISP[2] = (A[2] & ~A[1]) | (A[2] & ~A[0]);
    assign DISP[1] = (A[2] & A[1] & ~A[0]);
    assign DISP[0] = (A[2] & ~A[1] & A[0]);
    assign ENABLE  = (~A[2] & ~A[1] & A[0]);

endmodule

module FSM_MENU1 (input wire clk, reset, output wire [2:0]F, output wire [2:0]A, input wire [2:0]MENU, input wire CONT, input wire TIME, input wire [2:0]SELE, output wire [2:0]DISP, output wire [3:0]OP, output wire ENABLE);

    DFlipFlop3bits U2 (F, clk, reset, A);

// INTERFAZ DE MENÚ 1 - PLATOS FUERTES

    assign F[2]    = (~A[2] & A[1] & ~A[0] & ~SELE[2] & SELE[1]) | (~A[2] & A[1] & ~A[0] & SELE[2] & ~SELE[1] & ~SELE[0]);
    assign F[1]    = (~A[2] & ~A[1] & A[0] & CONT) | (~A[2] & A[1] & ~A[0] & ~SELE[1]) | (~A[2] & A[1] & ~A[0] & SELE[2] & ~SELE[0]);
    assign F[0]    = (~A[2] & ~A[1] & ~A[0] & ON) | (~A[2] & ~A[1] & A[0] & ~CONT & ~TIME) | (~A[2] & A[1] & ~A[0] & ~SELE[2] & SELE[0]) | (~A[2] & A[1] & ~A[0] & SELE[1] & SELE[0]);
    assign OP[3]   = (~A[2] & A[1] & A[0]);
    assign OP[2]   = (A[2] & ~A[1] & ~A[0]);
    assign OP[1]   = (A[2] & ~A[1] & A[0]);
    assign OP[0]   = (A[2] & A[1] & ~A[0]);
    assign DISP[3] = (~A[2] & A[1] & A[0]);
    assign DISP[2] = (A[2] & ~A[1] & ~A[0]);
    assign DISP[1] = (A[2] & ~A[1] & A[0]);
    assign DISP[0] = (A[2] & A[1] & ~A[0]);
    assign ENABLE  = (~A[2] & ~A[1] & A[0]);


endmodule

/*module FMS_MENU2 (input wire clk, reset, input wire [2:0]F, input wire [2:0]A, input wire CONT, TIME, [2:0]SELE, output wire [3:0]DISP, [3:0]G);

    DFlipFlop3bits U3 (F, clk, reset, A);

// INTERFAZ DE MENÚ 2 - GUARNICIONES

    assign F[2]    = (~A[2] & A[1] & ~A[0] & ~SELE[2] & SELE[1]) | (~A[2] & A[1] & ~A[0] & SELE[2] & ~SELE[1] & ~SELE[0]);
    assign F[1]    = (~A[2] & ~A[1] & A[0] & CONT) | (~A[2] & A[1] & ~A[0] & ~SELE[1]) | (~A[2] & A[1] & ~A[0] & SELE[2] & ~SELE[0]);
    assign F[0]    = (~A[2] & ~A[1] & ~A[0] & ON) | (~A[2] & ~A[1] & A[0] & ~CONT & ~TIME) | (~A[2] & A[1] & ~A[0] & ~SELE[2] & SELE[0]) | (~A[2] & A[1] & ~A[0] & SELE[1] & SELE[0]);
    assign G[3]    = (~A[2] & A[1] & A[0]);
    assign G[2]    = (A[2] & ~A[1] & ~A[0]);
    assign G[1]    = (A[2] & ~A[1] & A[0]);
    assign G[0]    = (A[2] & A[1] & ~A[0]);
    assign DISP[3] = (~A[2] & A[1] & A[0]);
    assign DISP[2] = (A[2] & ~A[1] & ~A[0]);
    assign DISP[1] = (A[2] & ~A[1] & A[0]);
    assign DISP[0] = (A[2] & A[1] & ~A[0]);
    assign ENABLE  = (~A[2] & ~A[1] & A[0]);

endmodule

module FMS_MENU3 (input wire clk, reset, input wire [2:0]F, input wire [2:0]A, input wire CONT, TIME, [2:0]SELE, output wire [3:0]DISP, [3:0]B);

    DFlipFlop3bits U4 (F, clk, reset, A);
    
// INTERFAZ DE MENÚ 3 - BEBIDAS

    assign F[2]    = (~A[2] & A[1] & ~A[0] & ~SELE[2] & SELE[1]) | (~A[2] & A[1] & ~A[0] & SELE[2] & ~SELE[1] & ~SELE[0]);
    assign F[1]    = (~A[2] & ~A[1] & A[0] & CONT) | (~A[2] & A[1] & ~A[0] & ~SELE[1]) | (~A[2] & A[1] & ~A[0] & SELE[2] & ~SELE[0]);
    assign F[0]    = (~A[2] & ~A[1] & ~A[0] & ON) | (~A[2] & ~A[1] & A[0] & ~CONT & ~TIME) | (~A[2] & A[1] & ~A[0] & ~SELE[2] & SELE[0]) | (~A[2] & A[1] & ~A[0] & SELE[1] & SELE[0]);
    assign B[3]    = (~A[2] & A[1] & A[0]);
    assign B[2]    = (A[2] & ~A[1] & ~A[0]);
    assign B[1]    = (A[2] & ~A[1] & A[0]);
    assign B[0]    = (A[2] & A[1] & ~A[0]);
    assign DISP[3] = (~A[2] & A[1] & A[0]);
    assign DISP[2] = (A[2] & ~A[1] & ~A[0]);
    assign DISP[1] = (A[2] & ~A[1] & A[0]);
    assign DISP[0] = (A[2] & A[1] & ~A[0]);
    assign ENABLE  = (~A[2] & ~A[1] & A[0]);

endmodule
*/




