`timescale 1ns / 100ps
`include "sp.v"

module sp_tb;
    reg d = 0, en = 0;
    reg clk = 0, rst = 0;

    wire[15:0] q;

always #1 clk = !clk;

initial $dumpfile("sp_tb.vcd");
initial $dumpvars(0, sp_tb);

sp s
(
    .d(d),
    .en(en),
    .clk(clk),
    .rst(rst),
    .q(q)
);

initial
begin
    #4 d = 1; en = 1;
    #5
    #5 en = 0;
    #5 
    #5 d = 0; en = 1;
    #5
    #5
    #1 d = 1;
    #6 d = 0;
    #5 rst = 1;
    #5 rst = 0; d = 0;
    #5 en = 1;
    #5 $finish;
end

endmodule