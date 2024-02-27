`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2024 12:54:55 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit(
                    // Output port definition
                    output reg IR_Load, MAR_Load, PC_Load, PC_Inc, A_Load, B_Load, CCR_Load,
                    output reg [2:0] ALU_Sel,
                    output reg [0:1] Bus1_Sel,
                    output reg [0:1] Bus2_Sel,
                    output reg write,
                    
                    // Input port definition
                    input wire [7:0] IR,
                    input wire [3:0] CCR_Result,
                    input wire clock, reset);
 
parameter LDA_IMM = 8'h86;
parameter LDA_DIR = 8'h87;
parameter LDB_IMM = 8'h88;
parameter LDB_DIR = 8'h89;
parameter STA_DIR = 8'h96;
parameter STB_DIR = 8'h97;
parameter ADD_AB = 8'h42;
parameter SUB_AB = 8'h43;
parameter OR_AB = 8'h45;
parameter INCA = 8'h46;
parameter INCB = 8'h47;
parameter DECA = 8'h48;
parameter DECB = 8'h49;
parameter BRA = 8'h20;
parameter BMI = 8'h21;
parameter BPL = 8'h22;
parameter BEQ = 8'h23;
parameter BNE = 8'h24;
parameter BVS = 8'h25;
parameter BVC = 8'h26;
parameter BCS = 8'h27;
parameter BCC = 8'h28; 
                    
reg [7:0] current_state, next_state;

parameter S_FETCH_0 = 0,
          S_FETCH_1 = 1,
          S_FETCH_2 = 2,
          
          S_DECODE_3 = 3,
          
          S_LDA_IMM_4 = 4,
          S_LDA_IMM_5 = 5,
          S_LDA_IMM_6 = 6,
          
          S_LDA_DIR_4 = 7,
          S_LDA_DIR_5 = 8,
          S_LDA_DIR_6 = 9,
          S_LDA_DIR_7 = 10,
          S_LDA_DIR_8 = 11,
          
          S_STA_DIR_4 = 12,
          S_STA_DIR_5 = 13,
          S_STA_DIR_6 = 14,
          S_STA_DIR_7 = 15,
                    
          S_LDB_IMM_4 = 16,
          S_LDB_IMM_5 = 17,
          S_LDB_IMM_6 = 18,
          
          S_LDB_DIR_4 = 19,
          S_LDB_DIR_5 = 20,
          S_LDB_DIR_6 = 21,
          S_LDB_DIR_7 = 22,
          S_LDB_DIR_8 = 23,
          
          S_STB_DIR_4 = 24,
          S_STB_DIR_5 = 25,
          S_STB_DIR_6 = 26,
          S_STB_DIR_7 = 27,
          
          S_BRA_4 = 28,
          S_BRA_5 = 29,
          S_BRA_6 = 30,
          
          S_BEQ_4 = 31,
          S_BEQ_5 = 32,
          S_BEQ_6 = 33,
          S_BEQ_7 = 34,
          
          S_ADD_AB_4 = 35;


always @ (posedge clock or negedge reset)
    begin: STATE_MEMORY
        if(!reset)
            current_state <= S_FETCH_0;
        else
            current_state <= next_state;
    end

always @ (current_state, IR, CCR_Result)
    begin: NEXT_STATE_LOGIC
        case(current_state)
        
            S_FETCH_0 : next_state = S_FETCH_1;
            S_FETCH_1 : next_state = S_FETCH_2;
            S_FETCH_2 : next_state = S_DECODE_3;
            
            S_DECODE_3 : 
                        if(IR == LDA_IMM) next_state = S_LDA_IMM_4;
                        else if(IR == LDA_DIR) next_state = S_LDA_DIR_4;
                        else if(IR == STA_DIR) next_state = S_STA_DIR_4; 
                        else if(IR == LDB_IMM) next_state = S_LDB_IMM_4;
                        else if(IR == LDB_DIR) next_state = S_LDB_DIR_4;
                        else if(IR == STB_DIR) next_state = S_STB_DIR_4;
                        else if(IR == BRA) next_state = S_BRA_4;
                        else if(IR == ADD_AB) next_state = S_ADD_AB_4;
                        else next_state = S_FETCH_0;
                        
           S_LDA_IMM_4 : next_state = S_LDA_IMM_5;
           S_LDA_IMM_5 : next_state = S_LDA_IMM_6;
           
           S_LDA_DIR_4 : next_state = S_LDA_DIR_5;
           S_LDA_DIR_5 : next_state = S_LDA_DIR_6;
           S_LDA_DIR_6 : next_state = S_LDA_DIR_7;
           S_LDA_DIR_6 : next_state = S_LDA_DIR_8;
           
           S_STA_DIR_4 : next_state = S_STA_DIR_5;
           S_STA_DIR_5 : next_state = S_STA_DIR_6;
           S_STA_DIR_6 : next_state = S_STA_DIR_7;
           
           S_LDB_IMM_4 : next_state = S_LDB_IMM_5;
           S_LDB_IMM_5 : next_state = S_LDB_IMM_6;
           
           S_LDB_DIR_4 : next_state = S_LDB_DIR_5;
           S_LDB_DIR_5 : next_state = S_LDB_DIR_6;
           S_LDB_DIR_6 : next_state = S_LDB_DIR_7;
           S_LDB_DIR_7 : next_state = S_LDB_DIR_8;
           
           S_STB_DIR_4 : next_state = S_STB_DIR_5;
           S_STB_DIR_5 : next_state = S_STB_DIR_6;
           S_STB_DIR_6 : next_state = S_STB_DIR_7;
           
           S_BRA_4 : next_state = S_BRA_5;
           S_BRA_4 : next_state = S_BRA_6;
           
           S_ADD_AB_4 : next_state = S_FETCH_0;
           
           default : next_state = S_FETCH_0;
        
        endcase
    end

always @ (current_state)
    begin: OUTPUT_LOGIC
        case(current_state)
            S_FETCH_0 : begin
                            IR_Load = 0;
                            MAR_Load = 1;
                            PC_Load = 0;
                            PC_Inc = 0;
                            A_Load = 0;
                            B_Load = 0;
                            ALU_Sel = 3'b000;
                            CCR_Load = 0;
                            Bus1_Sel = 2'b00;   // 00 = PC, 01 = A, 10 = B
                            Bus2_Sel = 2'b01;   // 00 = ALU, 01 = Bus1, 10 = from_memory
                            write = 0;
                        end
                        
            S_FETCH_1 : begin
                            IR_Load = 0;
                            MAR_Load = 0;
                            PC_Load = 0;
                            PC_Inc = 1;
                            A_Load = 0;
                            B_Load = 0;
                            ALU_Sel = 3'b000;
                            CCR_Load = 0;
                            Bus1_Sel = 2'b00;   // 00 = PC, 01 = A, 10 = B
                            Bus2_Sel = 2'b00;   // 00 = ALU, 01 = Bus1, 10 = from_memory
                            write = 0;
                        end
                        
            S_FETCH_2 : begin
                            IR_Load = 1;
                            MAR_Load = 0;
                            PC_Load = 0;
                            PC_Inc = 0;
                            A_Load = 0;
                            B_Load = 0;
                            ALU_Sel = 3'b000;
                            CCR_Load = 0;
                            Bus1_Sel = 2'b00;   // 00 = PC, 01 = A, 10 = B
                            Bus2_Sel = 2'b10;   // 00 = ALU, 01 = Bus1, 10 = from_memory
                            write = 0;
                        end
                                               
            S_DECODE_3 : begin
                            IR_Load = 0;
                            MAR_Load = 0;
                            PC_Load = 0;
                            PC_Inc = 0;
                            A_Load = 0;
                            B_Load = 0;
                            ALU_Sel = 3'b000;
                            CCR_Load = 0;
                            Bus1_Sel = 2'b00;   // 00 = PC, 01 = A, 10 = B
                            Bus2_Sel = 2'b00;   // 00 = ALU, 01 = Bus1, 10 = from_memory
                            write = 0;
                        end
                                               
            S_LDA_IMM_4 : begin
                            IR_Load = 0;
                            MAR_Load = 1;
                            PC_Load = 0;
                            PC_Inc = 0;
                            A_Load = 0;
                            B_Load = 0;
                            ALU_Sel = 3'b000;
                            CCR_Load = 0;
                            Bus1_Sel = 2'b00;   // 00 = PC, 01 = A, 10 = B
                            Bus2_Sel = 2'b01;   // 00 = ALU, 01 = Bus1, 10 = from_memory
                            write = 0;
                        end
                                               
            S_LDA_IMM_5 : begin
                            IR_Load = 0;
                            MAR_Load = 0;
                            PC_Load = 0;
                            PC_Inc = 1;
                            A_Load = 0;
                            B_Load = 0;
                            ALU_Sel = 3'b000;
                            CCR_Load = 0;
                            Bus1_Sel = 2'b00;   // 00 = PC, 01 = A, 10 = B
                            Bus2_Sel = 2'b00;   // 00 = ALU, 01 = Bus1, 10 = from_memory
                            write = 0;
                        end
                                               
            S_LDA_IMM_6 : begin
                            IR_Load = 0;
                            MAR_Load = 0;
                            PC_Load = 0;
                            PC_Inc = 0;
                            A_Load = 1;
                            B_Load = 0;
                            ALU_Sel = 3'b000;
                            CCR_Load = 0;
                            Bus1_Sel = 2'b00;   // 00 = PC, 01 = A, 10 = B
                            Bus2_Sel = 2'b10;   // 00 = ALU, 01 = Bus1, 10 = from_memory
                            write = 0;
                        end
        endcase
    end

endmodule





