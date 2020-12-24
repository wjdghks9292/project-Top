`timescale 1ns / 1ps


module top(
    input clk,
    input rst,
    output [6:0] seg0,
    output [6:0] seg1,
    output [6:0] seg2,
    output [6:0] seg3,
    output [6:0] seg4,
    output [6:0] seg5
    );
    
    
    wire clk_1hz;
    clk_dll U0(
        rst,
        clk,
        clk_1hz
    );
    
    
    wire [31:0] PC;
    wire [31:0] result;
    single_mips MIPS(
        clk_1hz,
        rst,
        PC,
        result,
    );
    
    seg7 myseg0(PC[7:4], seg0);
    seg7 myseg1(PC[3:0], seg1);
    seg7 myseg2(result[15:12], seg2);
    seg7 myseg3(result[11:8], seg3);
    seg7 myseg4(result[7:4], seg4);
    seg7 myseg5(result[3:0], seg5);
    
endmodule
