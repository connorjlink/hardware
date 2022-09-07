`timescale 1ns / 100ps
`include "pc.v"

module pc_tb;
    reg clk = 0;
    reg rst = 0;

    reg[15:0] ai = 0;

    reg lrc = 0;
    reg ini = 0;
    reg cub = 0;

    reg oe = 0;

    wire[15:0] ao;
    wire[2:0] is;

always #1 clk = !clk;

initial $dumpfile("pc_tb.vcd");
initial $dumpvars(0, pc_tb);

pc ipc
(
    .ai(ai),
    .clk(clk),
    .rst(rst),
    .lrc(lrc),
    .ini(ini),
    .cub(cub),
    .oe(oe),
    .ao(ao),
    .is(is)
);

initial
begin
    #5 oe = 1;
    #5
    #5
    #5
    #5 ini = 1;
    #2 ini = 0;
    #5 ai = 16'h800A; lrc = 1;
    #2 lrc = 0;
    #5 cub = 1;
    #2 cub = 0;
    #2
    #2
    #2
    #2
    #2 oe = 0;
    #2
    #2
    #2 oe = 1;
    #5 rst = 1;
    #2 rst = 0;
    #5 $finish;
end

endmodule
