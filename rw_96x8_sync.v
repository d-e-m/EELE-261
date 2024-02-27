`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2024 08:08:56 PM
// Design Name: 
// Module Name: rw_96x8_sync
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


module rw_96x8_sync(output reg data_out, input wire [7:0] address, data_in, wire write, clock);

reg[7:0] RW[128:223];

reg EN;

always @(address)
    begin:ENABLE_DATA_MEM
        if((address >= 128) && (address <= 223))
            EN = 1'b1;
        else
            EN = 1'b0;
        end


always @(posedge clock)
    begin:RW_DATA_MEM
        if(write && EN)
            RW[address] = data_in;
        else if(!write && EN)
            data_out = RW[address];
    end
    
endmodule




