`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2024 10:43:45 AM
// Design Name: 
// Module Name: data_path
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


module data_path(

                // Outputs ports definition

                output reg [7:0] to_memory,
                output reg [7:0] IR,
                output reg [3:0] CCR_Result,
                output reg [7:0] address,
                
                // Input port definition
                
                input wire IR_Load,
                input wire MAR_Load,
                input wire PC_Load,
                input wire PC_Inc,
                input wire A_Load,
                input wire B_Load,
                input wire [2:0] ALU_Sel,
                input wire CCR_Load,
                input wire [1:0] Bus1_Sel,
                input wire [1:0] Bus2_Sel,
                input wire [7:0] from_memory,
                input wire clock, reset);
reg [7:0] MAR;
reg [7:0] PC;
reg [7:0] A;
reg [7:0] B;
wire [3:0] CCR;
wire [7:0] ALU_Result;
reg [7:0] Bus1;
reg [7:0] Bus2;


alu U0 (.NZVC(CCR), .ALU_Result(ALU_Result), .In1(B), .In2(Bus1));


always @ (Bus1_Sel, PC, A, B)
    begin: MUX_BUS1
        case (Bus1_Sel)
            2'b00 : Bus1 = PC;
            2'b01 : Bus1 = A;
            2'b10 : Bus1 = B;
            default : Bus1 = 8'hXX;
        endcase
    end
    
 
always @ (Bus2_Sel, ALU_Result, Bus1, from_memory)
    begin: MUX_BUS2
        case (Bus2_Sel)
            2'b00 : Bus2 = ALU_Result;
            2'b01 : Bus2 = Bus1;
            2'b10 : Bus2 = from_memory;
            default : Bus2 = 8'hXX;
        endcase
    end

always @ (Bus1, MAR)
    begin
        to_memory = Bus1;
        address = MAR;
    end

always @ (posedge clock or negedge reset)
    begin: INSTRUCTION_REGISTER
        if(!reset)
            IR <= 8'h00;
        else if(IR_Load)
            IR <= Bus2;
    end
 
always @ (posedge clock or negedge reset)
    begin: MEMORY_ADDRESS_REGISTER
        if(!reset)
            MAR <= 8'h00;
        else if(MAR_Load)
            MAR <= Bus2;
    end
     
always @ (posedge clock or negedge reset)
    begin: PROGRAM_COUNTER
        if(!reset)
            PC <= 8'h00;
        else
        if(PC_Load)
            PC <= Bus2;
        else if(PC_Inc)
                PC <= MAR + 1;
    end
    
always @ (posedge clock or negedge reset)
    begin: A_REGISTER
        if(!reset)
            A <= 8'h00;
        else if(A_Load)
            A <= Bus2;
    end

always @ (posedge clock or negedge reset)
    begin: B_REGISTER
        if(!reset)
            B <= 8'h00;
        else if(B_Load)
            B <= Bus2;
    end
    
always @ (posedge clock or negedge reset)
    begin: CONDITION_CODE_REGISTER
        if(!reset)
            CCR_Result <= 8'h00;
        else if(CCR_Load)
            CCR_Result <= CCR;
    end

endmodule
