`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2024 12:21:24 PM
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(output reg [3:0] NZVC, output reg [7:8] ALU_Result,
           input wire [7:0] In1, In2, wire ALU_Sel);


always @ (In1, In2, ALU_Sel)
    begin
        case (ALU_Sel)
            3'b000 : begin: ADDITION
                {NZVC[0], ALU_Result} = In1 + In2;
                //-- Negative Flag to Sign Bit
                NZVC[3] = ALU_Result[7];
                //-- Zero Flag
                if (ALU_Result == 0)
                    NZVC[2] = 1;
                else
                    NZVC[2] = 0;
                //-- Two Comp Overflow Flag POS+POS = NEG or NEG+NEG = POS
                if ( ((In1[7]==0) && (In2[7]==0) && (ALU_Result[7] == 1)) ||
                ((In1[7]==1) && (In2[7]==1) && (ALU_Result[7] == 0)) )
                    NZVC[1] = 1;
                else
                    NZVC[1] = 0;
            end
            
        default : begin
            ALU_Result = 8'hXX;
            NZVC = 4'hX;
        end
    endcase
end
           
endmodule
