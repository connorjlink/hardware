`timescale 1ns / 100ps
`include "alu.v"

module alu_tb;
    reg[7:0] a = 0, b = 0, fi = 0;
    
    reg alu_add, 
        alu_sub, 
        alu_and, 
        alu_or, 
        alu_not, 
        alu_shl, 
        alu_shr;

    reg wa = 0, wb = 0;
    reg oe = 0;
    reg clk = 0, rst = 0;
    wire[7:0] d, fo;

always #1 clk = !clk;

initial $dumpfile("alu_tb.vcd");
initial $dumpvars(0, alu_tb);

alu alu_inst
(
    .a(a),
    .b(b),
    .fi(fi),
    .alu_add(alu_add),
    .alu_sub(alu_sub),
    .alu_and(alu_and),
    .alu_or(alu_or),
    .alu_not(alu_not),
    .alu_shl(alu_shl),
    .alu_shr(alu_shr),
    .clk(clk),
    .rst(rst),
    .wa(wa),
    .wb(wb),
    .oe(oe),
    .d(d),
    .fo(fo)
);

initial
begin
    #5 a = 100; wa = 1; b = 1; wb = 1; fi = 0; op = 0; oe = 1;
    #5 alu_add = 1; wa = 0; wb = 0;
    #5 fi = 1;
    #5 alu_add = 0; alu_sub = 1;
    #5 fi = 0;
    #5 alu_sub = 0; alu_and = 1;
    #5 oe = 0;
    #5 alu_and = 0; alu_or = 1; oe = 1;
    #1
    #5 alu_or = 0; alu_not = 1;
    #5 alu_not = 0; alu_shl = 1;
    #5 b = 2; wb = 1; alu_shl = 0; alu_shr = 1;
    #5 a = 0; wb = 0; wa = 1;
    #5 a = 43; b = 1; wb = 1; alu_shr = 0; oe = 0;
    #5 rst = 1; wa = 0; wb = 0; oe = 1;
    #5 rst = 0;
    #5 $finish;
end

endmodule