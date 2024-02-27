`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2024 03:47:36 PM
// Design Name: 
// Module Name: cpu
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


module cpu(
           output wire [7:0] address, to_memory,
           output wire write,
           input wire [7:0] from_memory,
           input wire clock, reset
           );
           
// out wires control unit  perspective
wire IR_Load_out, MAR_Load_out, PC_Load_out, PC_Inc_out, A_Load_out, B_Load_out, CCR_Load_out, write_out;
wire [1:0] Bus1_Sel_out, Bus2_Sel_out;
wire [2:0] ALU_Sel_out;

// in wires control unit perspective
wire [7:0] IR_in;
wire [3:0] CCR_Result_in;

control_unit U0 (.IR_Load(IR_Load_out),.MAR_Load(MAR_Load_out), .PC_Load(PC_Load_out), .PC_Inc(PC_Inc_out),
                 .A_Load(A_Load_out), .B_Load(B_Load_out), .CCR_Load(CCR_Load_out), .ALU_Sel(ALU_Sel_out),
                 .Bus1_Sel(Bus1_Sel_out), .Bus2_Sel(Bus2_Sel_out), .write(write),
                 .IR(IR_in), .CCR_Result(CCR_Result_in), .clock(clock), .reset(!reset));

data_path U1 (.to_memory(to_memory), .IR(IR_in),.CCR_Result(CCR_Result_in),.address(address),
             .IR_Load(IR_Load_out), .MAR_Load(MAR_Load_out), .PC_Load(PC_Load_out),
             .PC_Inc(PC_Inc_out), .A_Load(A_Load_out), .B_Load(B_Load_out), .ALU_Sel(ALU_Sel_out),
             .CCR_Load(CCR_Load_out), .Bus1_Sel(Bus1_Sel_out), .Bus2_Sel(Bus2_Sel_out),
             .from_memory(from_memory), .clock(clock), .reset(!reset));


endmodule


