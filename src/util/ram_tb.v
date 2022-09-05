`timescale 1ns / 100ps
`include "ram.v"

module ram_testbench();
    reg clk = 0;
    reg we = 1;

    reg[7:0] d = 0;
    reg[5:0] a = 0;

    wire[7:0] q1o, q2o;

always #1 clk = !clk;

initial $dumpfile("ram_testbench.vcd");
initial $dumpvars(0, ram_testbench);

ram r
(
    .d(d),
    .a(a),
    .we(we),
    .clk(clk),
    .q1(q1o),
    .q2(q2o)
);

initial 
begin
    #1
    #4 a = 2; d = 100; we = 1;
    #2
    #4 a = 12; d = 30; we = 1;
    #2
    #4 a = 3; d = 48; we = 1;
    #2
    #4 a = 2; d = 100; we = 0;
    #2
    #4 a = 3; 
    #2
    #4 a = 1;
    #2
    #4 a = 2;
    #2
    #4 $finish;
end

endmodule