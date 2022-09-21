`timescale 1ns / 100ps
`include "rf.v"

module rf_tb;
    reg[7:0] d = 0;

    reg ai = 0, bi = 0, ci = 0, di = 0, fi = 0;
    reg ao = 0, bo = 0, co = 0, do = 0, fo = 0;

    reg clk = 0, rst = 0;

    wire[7:0] p, fq, fod;

always #1 clk = !clk;

initial $dumpfile("rf_tb.vcd");
initial $dumpvars(0, rf_tb);

rf r
(
    .d(d),
    .ai(ai),
    .bi(bi),
    .ci(ci),
    .di(di),
    .fi(fi),
    .ao(ao),
    .bo(bo),
    .co(co),
    .do(do),
    .fo(fo),
    .clk(clk),
    .rst(rst),
    .p(p),
    .fq(fq),
    .fod(fod)
);

initial
begin
    #1 rst = 1;
    #5 rst = 0;
    #5 d = 100; ai = 1; bi = 1; ao = 0;
    #3 ao = 1;
    #5 d = 0; ai = 0; bi = 0; ao = 0;
    #5 ao = 0; bo = 1;
    #5 bo = 0; d = 64; ci = 1;
    #5 ci = 0; co = 1; d = 4; fi = 1;
    #5 d = 0; fi = 0; co = 0; fo = 1;
    #5 fo = 0;
    #1
    #5 rst = 1;
    #5 $finish;
end

endmodule