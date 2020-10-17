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

// Timer 2

module Timer2 (input wire ENABLE1, output reg TIME2);
    always @ (ENABLE1) begin
        if (ENABLE1 == 0) begin
            TIME2 = 0 ;
        end while(ENABLE1) begin
            TIME2 = 0;
            #3 TIME2 = 1 ;
            #3 TIME2 = 0 ;
        end

    end
endmodule

// INTERFAZ DE BIENVENIDA - SELECCIÓN DE MENÚS 

module FSM_BIENVENIDA (input wire clk, reset, output wire [2:0]F, output wire [2:0]A, input wire ON, input wire CONT, input wire TIME, input wire [1:0]SELE, output wire [2:0]MENU, output wire ENABLE);

    FlipFloptipoD3Bits U1(F, clk, reset, A); 

    assign F[2]    = (~A[2] & A[1] & ~A[0] & SELE[1]) | (~A[2] & A[1] & ~A[0] & SELE[0]);
    assign F[1]    = (~A[2] & ~A[1] & A[0] & CONT) | (~A[2] & A[1] & ~A[0] & SELE[1] & SELE[0]) | (~A[2] & A[1] & ~A[0] & ~SELE[1] & ~SELE[0]);
    assign F[0]    = (~A[2] & ~A[1] & ~A[0] & ON) | (~A[2] & ~A[1] & A[0] & ~CONT & ~TIME) | (~A[2] & A[1] & ~A[0] & SELE[1] & ~SELE[0]);
    assign MENU[2] = (A[2] & ~A[1] & ~A[0]);
    assign MENU[1] = (A[2] & ~A[1] & A[0]);
    assign MENU[0] = (A[2] & A[1] & ~A[0]);
    assign ENABLE  = (~A[2] & ~A[1] & A[0]);

endmodule

// INTERFAZ DE MENÚ 1 - PLATOS FUERTES

module FSM_MENU1 (input wire clk, reset, output wire [2:0]Fm1, output wire [2:0]Am1, input wire [2:0]MENU, input wire CONTm1, input wire TIME, input wire [2:0]SELEm1, output wire [3:0]OP, output wire ENABLE);

    FlipFloptipoD3Bits U2 (Fm1, clk, reset, Am1);
    
    assign Fm1[2]    = (~Am1[2] & Am1[1] & ~Am1[0] & ~SELEm1[2] & SELEm1[1]) | (~Am1[2] & Am1[1] & ~Am1[0] & SELEm1[2] & ~SELEm1[1] & ~SELEm1[0]);
    assign Fm1[1]    = (~Am1[2] & ~Am1[1] & Am1[0] & CONTm1) | (~Am1[2] & Am1[1] & ~Am1[0] & ~SELEm1[1]) | (~Am1[2] & Am1[1] & ~Am1[0] & SELEm1[2] & ~SELEm1[0]);
    assign Fm1[0]    = (~Am1[2] & ~Am1[1] & Am1[0] & ~CONTm1 & ~TIME) | (~Am1[2] & Am1[1] & ~Am1[0] & ~SELEm1[2] & SELEm1[0]) | (~Am1[2] & Am1[1] & ~Am1[0] & SELEm1[1] & SELEm1[0]) | (~Am1[2] & ~Am1[1] & ~Am1[0] & MENU[2] & ~MENU[1] & ~MENU[0]);
    assign OP[3]     = (~Am1[2] & Am1[1] & Am1[0]);
    assign OP[2]     = (Am1[2] & ~Am1[1] & ~Am1[0]);
    assign OP[1]     = (Am1[2] & ~Am1[1] & Am1[0]);
    assign OP[0]     = (Am1[2] & Am1[1] & ~Am1[0]);
    assign ENABLE    = (~Am1[2] & ~Am1[1] & Am1[0]);

endmodule

// INTERFAZ DE MENÚ 2 - GUARNICIONES

module FSM_MENU2 (input wire clk, reset, output wire [2:0]Fm2, output wire [2:0]Am2, input wire [3:0]OP, input wire CONTm2, input wire TIME, input wire [2:0]SELEm2, output wire [3:0]G, output wire ENABLE);

    FlipFloptipoD3Bits U3 (Fm2, clk, reset, Am2);

    assign Fm2[2]  = (~Am2[2] & Am2[1] & ~Am2[0] & ~SELEm2[2] & SELEm2[1]) | (~Am2[2] & Am2[1] & ~Am2[0] & SELEm2[2] & ~SELEm2[1] & ~SELEm2[0]);
    assign Fm2[1]  = (~Am2[2] & ~Am2[1] & Am2[0] & CONTm2) | (~Am2[2] & Am2[1] & ~Am2[0] & ~SELEm2[1]) | (~Am2[2] & Am2[1] & ~Am2[0] & SELEm2[2] & ~SELEm2[0]);
    assign Fm2[0]  = (~Am2[2] & ~Am2[1] & Am2[0] & ~CONTm2 & ~TIME) | (~Am2[2] & Am2[1] & ~Am2[0] & ~SELEm2[2] & SELEm2[0]) | (~Am2[2] & Am2[1] & ~Am2[0] & SELEm2[1] & SELEm2[0]) | (~Am2[2] & ~Am2[1] & ~Am2[0] & ~OP[3] & ~OP[2] & ~OP[1] & OP[0]) | (~Am2[2] & ~Am2[1] & ~Am2[0] & ~OP[3] & ~OP[2] & OP[1] & ~OP[0]) | (~Am2[2] & ~Am2[1] & ~Am2[0] & ~OP[3] & OP[2] & ~OP[1] & ~OP[0]) | (~Am2[2] & ~Am2[1] & ~Am2[0] & OP[3] & ~OP[2] & ~OP[1] & ~OP[0]);
    assign G[3]    = (~Am2[2] & Am2[1] & Am2[0]);
    assign G[2]    = (Am2[2] & ~Am2[1] & ~Am2[0]);
    assign G[1]    = (Am2[2] & ~Am2[1] & Am2[0]);
    assign G[0]    = (Am2[2] & Am2[1] & ~Am2[0]);
    assign ENABLE  = (~Am2[2] & ~Am2[1] & Am2[0]);

endmodule

// INTERFAZ DE MENÚ 3 - BEBIDAS

module FSM_MENU3 (input wire clk, reset, output wire [2:0]Fm3, output wire [2:0]Am3, input wire [3:0]G, input wire CONTm3, input wire TIME, input wire [2:0]SELEm3, output wire [3:0]B, output wire ENABLE);

    FlipFloptipoD3Bits U4 (Fm3, clk, reset, Am3);

    assign Fm3[2]  = (~Am3[2] & Am3[1] & ~Am3[0] & ~SELEm3[2] & SELEm3[1]) | (~Am3[2] & Am3[1] & ~Am3[0] & SELEm3[2] & ~SELEm3[1] & ~SELEm3[0]);
    assign Fm3[1]  = (~Am3[2] & ~Am3[1] & Am3[0] & CONTm3) | (~Am3[2] & Am3[1] & ~Am3[0] & ~SELEm3[1]) | (~Am3[2] & Am3[1] & ~Am3[0] & SELEm3[2] & ~SELEm3[0]);
    assign Fm3[0]  = (~Am3[2] & ~Am3[1] & Am3[0] & ~CONTm3 & ~TIME) | (~Am3[2] & Am3[1] & ~Am3[0] & ~SELEm3[2] & SELEm3[0]) | (~Am3[2] & Am3[1] & ~Am3[0] & SELEm3[1] & SELEm3[0]) | (~Am3[2] & ~Am3[1] & ~Am3[0] & ~G[3] & ~G[2] & ~G[1] & G[0]) | (~Am3[2] & ~Am3[1] & ~Am3[0] & ~G[3] & ~G[2] & G[1] & ~G[0]) | (~Am3[2] & ~Am3[1] & ~Am3[0] & ~G[3] & G[2] & ~G[1] & ~G[0]) | (~Am3[2] & ~Am3[1] & ~Am3[0] & G[3] & ~G[2] & ~G[1] & ~G[0]);
    assign B[3]    = (~Am3[2] & Am3[1] & Am3[0]);
    assign B[2]    = (Am3[2] & ~Am3[1] & ~Am3[0]);
    assign B[1]    = (Am3[2] & ~Am3[1] & Am3[0]);
    assign B[0]    = (Am3[2] & Am3[1] & ~Am3[0]);
    assign ENABLE  = (~Am3[2] & ~Am3[1] & Am3[0]);

endmodule 

module FSM_B1 (input wire clk, reset, output wire [2:0]FB1, output wire [2:0]AB1, input wire [3:0]B, input wire [1:0]SELEB1, output wire [1:0]SB1);

    FlipFloptipoD3Bits U5 (FB1, clk, reset, AB1);

    assign FB1[2]  = (0);
    assign FB1[1]  = (~AB1[2] & ~AB1[1] & AB1[0] & ~SELEB1[1] & SELEB1[0]) | (~AB1[2] & ~AB1[1] & AB1[0] & SELEB1[1] & ~SELEB1[0]);
    assign FB1[0]  = (~AB1[2] & ~AB1[1] & AB1[0] & SELEB1[1]) | (~AB1[2] & ~AB1[1] & AB1[0] & ~SELEB1[0]) | (~AB1[2] & ~AB1[1] & ~AB1[0] & B[3] & ~B[2] & ~B[1] & ~B[0]);
    assign SB1[1] = (~AB1[2] & ~AB1[1] & AB1[0] & SELEB1[1] & ~SELEB1[0]);
    assign SB1[0] = (~AB1[2] & ~AB1[1] & AB1[0] & ~SELEB1[1] & SELEB1[0]);
    
endmodule

module FSM_B2 (input wire clk, reset, output wire [2:0]FB2, output wire [2:0]AB2, input wire [3:0]B, input wire [1:0]SELEB2, output wire [1:0]SB2);

    FlipFloptipoD3Bits U6 (FB2, clk, reset, AB2);

    assign FB2[2]  = (0);
    assign FB2[1]  = (~AB2[2] & ~AB2[1] & AB2[0] & ~SELEB2[1] & SELEB2[0]) | (~AB2[2] & ~AB2[1] & AB2[0] & SELEB2[1] & ~SELEB2[0]);
    assign FB2[0]  = (~AB2[2] & ~AB2[1] & AB2[0] & SELEB2[1]) | (~AB2[2] & ~AB2[1] & AB2[0] & ~SELEB2[0]) | (~AB2[2] & ~AB2[1] & ~AB2[0] & ~B[3] & B[2] & ~B[1] & ~B[0]);
    assign SB2[1] = (~AB2[2] & ~AB2[1] & AB2[0] & SELEB2[1] & ~SELEB2[0]);
    assign SB2[0] = (~AB2[2] & ~AB2[1] & AB2[0] & ~SELEB2[1] & SELEB2[0]);

endmodule 

module FSM_B3 (input wire clk, reset, output wire [2:0]FB3, output wire [2:0]AB3, input wire [3:0]B, input wire [1:0]SELEB3, output wire [1:0]SB3);

    FlipFloptipoD3Bits U7 (FB3, clk, reset, AB3);

    assign FB3[2] = (0);
    assign FB3[1] = (~AB3[2] & ~AB3[1] & AB3[0] & ~SELEB3[1] & SELEB3[0]) | (~AB3[2] & ~AB3[1] & AB3[0] & SELEB3[1] & ~SELEB3[0]);
    assign FB3[0] = (~AB3[2] & ~AB3[1] & AB3[0] & SELEB3[1]) | (~AB3[2] & ~AB3[1] & AB3[0] & ~SELEB3[0]) | (~AB3[2] & ~AB3[1] & ~AB3[0] & ~B[3] & ~B[2] & B[1] & ~B[0]);
    assign SB3[1] = (~AB3[2] & ~AB3[1] & AB3[0] & SELEB3[1] & ~SELEB3[0]);
    assign SB3[0] = (~AB3[2] & ~AB3[1] & AB3[0] & ~SELEB3[1] & SELEB3[0]);

endmodule 

module FSM_B4 (input wire clk, reset, output wire [2:0]FB4, output wire [2:0]AB4, input wire [3:0]B, input wire [1:0]SELEB4, output wire [1:0]SB4);

    FlipFloptipoD3Bits U8 (FB4, clk, reset, AB4);

    assign FB4[2] = (0);
    assign FB4[1] = (~AB4[2] & ~AB4[1] & AB4[0] & ~SELEB4[1] & SELEB4[0]) | (~AB4[2] & ~AB4[1] & AB4[0] & SELEB4[1] & ~SELEB4[0]);
    assign FB4[0] = (~AB4[2] & ~AB4[1] & AB4[0] & SELEB4[1]) | (~AB4[2] & ~AB4[1] & AB4[0] & ~SELEB4[0]) | (~AB4[2] & ~AB4[1] & ~AB4[0] & ~B[3] & ~B[3] & ~B[1] & B[0]);
    assign SB4[1] = (~AB4[2] & ~AB4[1] & AB4[0] & SELEB4[1] & ~SELEB4[0]);
    assign SB4[0] = (~AB4[2] & ~AB4[1] & AB4[0] & ~SELEB4[1] & SELEB4[0]);

endmodule

module FSM_LLENADOB1(input wire clk, reset, output wire [2:0]FF1, output wire [2:0]AF1, input wire TIME, input wire TIME2, input wire [1:0]SB1, input wire M1, output wire DONE, output wire ENABLE1);

    FlipFloptipoD3Bits U9 (FF1, clk, reset, AF1);

    assign FF1[2] = (AF1[2] & ~AF1[1] & ~AF1[0]) | (~AF1[2] & AF1[1] & ~AF1[0] & M1) | (~AF1[2] & AF1[1] & AF1[0] & TIME);
    assign FF1[1] = (~AF1[2] & ~AF1[1] & AF1[0] & M1) | (~AF1[2] & AF1[1] & ~AF1[0] & ~M1) | (~AF1[2] & AF1[1] & AF1[0] & ~TIME) | (~AF1[2] & ~AF1[1] & ~AF1[0] & SB1[1] & ~SB1[0]);
    assign FF1[0] = (~AF1[2] & AF1[0]) | (~AF1[2] & ~AF1[1] & ~SB1[1] & SB1[0]) | (AF1[2] & ~AF1[1] & ~AF1[0] & TIME2);
    assign DONE   = (~AF1[2] & AF1[1] & AF1[0] & TIME) | (AF1[2] & ~AF1[1] & ~AF1[0] & TIME2);
    assign ENABLE1 = (~AF1[2] & AF1[1] & AF1[0]) | (AF1[2] & ~AF1[1] & ~AF1[0]);

endmodule 
