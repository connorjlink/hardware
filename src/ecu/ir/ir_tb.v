`timescale 1ns / 100ps
`include "ir.v"

module ir_tb;
    reg[31:0] raw = 0;
    reg[1:0] len = 0;

    reg we = 0;
    reg clk = 0, rst = 0;

    wire[7:0] insn, d1, d2, d3;

always #1 clk = !clk;

initial $dumpfile("ir_tb.vcd");
initial $dumpvars(0, ir_tb);

ir r
(
    .raw(raw),
    .len(len),
    .clk(clk),
    .rst(rst),
    .insn(insn),
    .we(we),
    .d1(d1),
    .d2(d2),
    .d3(d3)
);

initial
begin
    #5 raw = 32'h5E606202; len = 2; we = 1;
    #5 we = 0;
    #5 len = 1;
    #5 raw = 32'hDFE342FE; 
    #1
    #5 we = 1;
    #5 we = 0;
    #5 len = 1;
    #5 len = 0; we = 1;
    #5 len = 2; we = 0;
    #5 len = 3;
    #5 rst = 1;
    #5 rst = 0; raw = 32'h3249FD2A; we = 1;
    #5
    #5 $finish;
end

endmodule