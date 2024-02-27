`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2024 06:36:41 PM
// Design Name: 
// Module Name: computer_TB
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


module computer_TB();

reg clock_TB, reset_TB;

reg [7:0] port_in_00_TB;
reg [7:0] port_in_01_TB;
reg [7:0] port_in_02_TB;
reg [7:0] port_in_03_TB;
reg [7:0] port_in_04_TB;
reg [7:0] port_in_05_TB;
reg [7:0] port_in_06_TB;
reg [7:0] port_in_07_TB;
reg [7:0] port_in_08_TB;
reg [7:0] port_in_09_TB;
reg [7:0] port_in_10_TB;
reg [7:0] port_in_11_TB;
reg [7:0] port_in_12_TB;
reg [7:0] port_in_13_TB;
reg [7:0] port_in_14_TB;
reg [7:0] port_in_15_TB;

computer DUT (.clock(clock_TB),.reset(reset_TB),
           .port_in_00(port_in_00_TB),
           .port_in_01(port_in_01_TB),
           .port_in_02(port_in_02_TB),
           .port_in_03(port_in_03_TB),
           .port_in_04(port_in_04_TB),
           .port_in_05(port_in_05_TB),
           .port_in_06(port_in_06_TB),
           .port_in_07(port_in_07_TB),
           .port_in_08(port_in_08_TB),
           .port_in_09(port_in_09_TB),
           .port_in_10(port_in_10_TB),
           .port_in_11(port_in_11_TB),
           .port_in_12(port_in_12_TB),
           .port_in_13(port_in_13_TB),
           .port_in_14(port_in_14_TB),
           .port_in_15(port_in_15_TB)
           );

initial
    begin
      reset_TB = 1'b0;
      port_in_00_TB = 8'hCC;
      port_in_01_TB = 8'hDD;          
      port_in_02_TB = 8'h22;
      port_in_03_TB = 8'h33;          
      port_in_04_TB = 8'h44;
      port_in_05_TB = 8'h55;          
      port_in_06_TB = 8'h66;
      port_in_07_TB = 8'h77;          
      port_in_08_TB = 8'h88;
      port_in_09_TB = 8'h99;          
      port_in_10_TB = 8'hAA;
      port_in_11_TB = 8'hBB;
      port_in_12_TB = 8'hCC;
      port_in_13_TB = 8'hDD;
      port_in_14_TB = 8'hEE;
      port_in_15_TB = 8'hFF; 
    end

initial
    begin
        clock_TB = 1'b0;
        reset_TB = 1'b0;
    end

always
    begin
       #100 reset_TB = 1'b1;
    end

always
    begin
       clock_TB = ~clock_TB;
       #10;
    end

endmodule
