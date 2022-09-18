`timescale 1ns / 100ps
`include "ecu.v"

module ecu_tb;
    reg[15:0] ai = 0;
    reg[31:0] raw = 0;
    reg clk = 0, rst = 0;

    wire[6:0] rf_ctl_lines;
    wire[4:0] lsu_ctl_lines;
    wire[9:0] alu_ctl_lines;
    wire[2:0] acu_ctl_lines;
    wire[2:0] adu_ctl_lines;
    wire[15:0] ao;

initial $dumpfile("ecu_tb.vcd");
initial $dumpvars(0, ecu_tb);

always #1 clk = !clk;

initial
begin
    #5
    #5 $finish;
end

endmodule