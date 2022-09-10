`timescale 1ns / 100ps
`include "lsu.v"

module lsu_tb;
    reg[7:0] d = 0;
    reg[15:0] a = 0;

    reg clk = 0, rst = 0;

    reg sp_d = 0, sp_we = 0, sp_en = 0;

    reg re = 0, we = 0;

    wire[7:0] q, q1, q2, q3;
    wire[7:0] fo;

always #1 clk = !clk;

initial $dumpfile("lsu_tb.vcd");
initial $dumpvars(0, lsu_tb);

lsu u 
(
    .d(d),
    .a(a),
    .clk(clk),
    .rst(rst),
    .sp_d(sp_d),
    .sp_we(sp_we),
    .sp_en(sp_en),
    .re(re),
    .we(we),
    .q(q),
    .q1(q1),
    .q2(q2),
    .q3(q3),
    .fo(fo)
);

initial
begin
    #5 a = 32768; re = 1; 
    #5 a = 32769; re = 1;
    #5 re = 0;
    #5 a = 0; d = 100; we = 1;
    #5 re = 1; we = 0;
    #5 a = 30; d = 48; we = 1;
    #5 we = 0;
    #5 re = 1; a = 0;
    #5 re = 0; sp_en = 1; sp_d = 1; sp_we = 1;
    #5
    #5
    #5 sp_d = 0;
    #5
    #5 rst = 1;
    #5 rst = 0; we = 0; re = 1; sp_en = 0; sp_we = 0;
    #5 a = 0;
    #5 $finish;
end

endmodule