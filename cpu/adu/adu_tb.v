`timescale 1ns / 100ps
`include "adu.v"

module adu_tb;
    reg[15:0] a = 0;
    
    reg we = 0;
    reg rl = 0, rh = 0;
    reg clk = 0, rst = 0;

    wire[7:0] q;

always #1 clk = !clk;

initial $dumpfile("adu_tb.vcd");
initial $dumpvars(0, adu_tb);

adu du
(
    .a(a),
    .we(we),
    .rl(rl),
    .rh(rh),
    .clk(clk),
    .rst(rst),
    .q(q)
);

initial
begin
    #5 a = 31246; we = 1;
    #5 we = 0; rl = 1;
    #5 rl = 0; rh = 1;
    #1
    #5 a = 20000; we = 1;
    #5
    #5 we = 0; rh = 1;
    #5 
    #5 rh = 0; rl = 1;
    #5 
    #5 rst = 1;
    #5 rst = 0;
    #5 $finish;
end

endmodule