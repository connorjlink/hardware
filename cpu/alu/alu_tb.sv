`timescale 1ns / 100ps
`include "alu.v"

module alu_tb;
    reg[7:0] a = 0, b = 0, fi = 0;
    reg[6:0] op = 0;
    reg wa = 0, wb = 0;
    reg oe = 0;
    reg clk = 0, rst = 0;
    wire[7:0] d, fo;

always #1 clk = !clk;

initial $dumpfile("alu_tb.vcd");
initial $dumpvars(0, alu_tb);

alu al
(
    .a(a),
    .b(b),
    .fi(fi),
    .op(op),
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
    #5 op = 1; wa = 0; wb = 0;
    #5 fi = 1;
    #5 op = 2;
    #5 fi = 0;
    #5 op = 3; 
    #5 oe = 0;
    #5 op = 4; oe = 1;
    #1
    #5 op = 8;
    #5 op = 16;
    #5 b = 2; wb = 1; op = 32;
    #5 a = 0; wb = 0; wa = 1;
    #5 a = 43; b = 1; wb = 1; op = 64; oe = 0;
    #5 rst = 1; wa = 0; wb = 0; oe = 1;
    #5 rst = 0;
    #5 $finish;
end

endmodule