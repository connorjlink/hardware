`timescale 1ns / 100ps
`include "rf.v"

module rf_tb;
    reg[7:0] d = 0;
    reg as = 0, bs = 0, cs = 0, ds = 0, fs = 0;
    reg re = 0, we = 0;

    reg clk = 0, rst = 0;

    wire[7:0] p, fo, fod;

always #1 clk = !clk;

initial $dumpfile("rf_tb.vcd");
initial $dumpvars(0, rf_tb);

rf r
(
    .d(d),
    .as(as),
    .bs(bs),
    .cs(cs),
    .ds(ds),
    .fs(fs),
    .re(re),
    .we(we),
    .clk(clk),
    .rst(rst),
    .p(p),
    .fo(fo),
    .fod(fod)
);

initial
begin
    #5 re = 1; we = 1; as = 1; d = 100;
    #5 d = 30; as = 0; bs = 1;
    #5 d = 54; bs = 0; ds = 1;
    #5 we = 0; ds = 0;

    #5 $finish;
end

endmodule