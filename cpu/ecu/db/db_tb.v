`timescale 1ns / 100ps
`include "db.v"

module db_tb;
    reg[7:0] insn = 0, d1 = 0, d2 = 0, d3 = 0;
    reg[2:0] is = 0;

    reg clk = 0, rst = 0;

    wire[6:0] rf;
    wire[4:0] lsu;
    wire[9:0] alu;
    wire ir_we;
    wire[3:0] pc;
    wire[2:0] acu;
    wire[2:0] adu;
    wire[1:0] len;

always #1 clk = !clk;

initial $dumpfile("db_tb.vcd");
initial $dumpvars(0, db_tb);

db d
(
    .insn(insn),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .is(is),
    .clk(clk),
    .rst(rst),
    .rf(rf),
    .lsu(lsu),
    .alu(alu),
    .ir_we(ir_we),
    .pc(pc),
    .acu(acu),
    .adu(adu),
    .len(len)
);

initial
begin
    #5
    #5 insn = 13; d1 = 100; d2 = 50; d3 = 64;
    #5 $finish;
end

endmodule
