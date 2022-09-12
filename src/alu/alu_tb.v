`timescale 1ns / 100ps
`include "alu.v"

module alu_tb;
    reg[7:0] a = 0, b = 0, fi = 0;
    reg[6:0] op = 0;
    reg clk = 0, rst = 0;
    wire[7:0] d, fo;

always #1 clk = !clk;

initial $dumpfile("alu_tb.vcd");
initial $dumpvars(0, alu_tb);

alu alu
(
    .a(a),
    .b(b),
    .fi(fi),
    .op(op),
    .clk(clk),
    .rst(rst),
    .d(d),
    .fo(fo)
);

initial
begin
    #5 a = 1; b = 100; fi = 0; op = 0;
    #5 op = 1;
    #5 op = 2;
    #5 op = 3;
    #5 op = 4;
    #1
    #5 op = 8;
    #5 op = 16;
    #5 op = 32;
    #5 op = 64;
    #5 op = 65;
    #5 $finish;
end

endmodule