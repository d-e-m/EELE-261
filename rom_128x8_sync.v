`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2024 07:03:22 PM
// Design Name: 
// Module Name: rom_128x8_sync
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


module rom_128x8_sync(output reg [7:0] data_out, input wire clock, wire [7:0] address);

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


reg EN;

reg[7:0] ROM[0:127];


initial
    begin:LOAD_PROGRAM_MEM
        ROM[0] = LDA_IMM;
        ROM[1] = 8'hAA;
        ROM[2] = STA_DIR;
        ROM[3] = 8'hE0;
        ROM[4] = BRA;
        ROM[5] = 8'h00;
    end
    
 always @(address)
    begin:ENABLE_PROGRAM_MEM
        if((address >= 0) && (address <= 127))
            EN = 1'b1;
        else
            EN = 1'b0;
    end
    
always @(posedge clock)
    begin:OUTPUT_PROGRAM_MEM
        if(EN)
            data_out = ROM[address];
    end

endmodule





