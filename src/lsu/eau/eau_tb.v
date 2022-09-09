`timescale 1ns / 100ps
`include "eau.v"

module eau_tb;
    reg clk = 0, rst = 0;
    reg wl = 0, wh = 0;
    reg oe = 0;

    reg[7:0] d = 0;

    wire[15:0] q;

always #1 clk = !clk;

initial $dumpfile("eau_tb.vcd");
initial $dumpvars(0, eau_tb);

eau e
(
    .d(d),
    .clk(clk),
    .rst(rst),
    .wl(wl),
    .wh(wh),
    .oe(oe),
    .q(q)
);

initial
begin
    #5 d = 100; wl = 1; oe = 1;
    #5 d = 64; wl = 0; wh = 1;
    #5 wh = 0;
    #5 oe = 0;
    #5 oe = 1;
    #5 oe = 0;
    #2
    #5 d = 32; wh = 1;
    #5 wh = 0;
    #5 oe = 1;
    #5 rst = 1;
    #5
    #5 $finish;
end

endmodule