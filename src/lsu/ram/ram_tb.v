`timescale 1ns / 100ps
`include "ram.v"

module ram_tb;

    reg clk = 0, rst = 0;
    reg re = 0, we = 0;

    reg[7:0] d = 0;
    reg[15:0] a = 0;

    wire[7:0] q;

always #1 clk = !clk;

initial $dumpfile("ram_tb.vcd");
initial $dumpvars(0, ram_tb);

ram r
(
    .d(d),
    .a(a),
    .re(re),
    .we(we),
    .clk(clk),
    .q(q)
);

initial
begin
    #2
    #5 a = 0; re = 1; we = 1; d = 100;
    #5 we = 0; re = 0;
    #5 a = 32; re = 1; we = 1; d = 30;
    #5 we = 0;
    #5 a = 0; re = 1;
    #5 a = 32;
    #5 a = 40000;
    #5 rst = 1;
    #5 a = 0; re = 1;
    #5 a = 32;
    #5 $finish;
end

endmodule
