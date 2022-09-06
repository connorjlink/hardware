`timescale 1ns / 100ps
`include "rom.v"

module rom_tb;
    reg clk = 0;
    reg re = 1;

    reg[15:0] a = 0;

    wire[7:0] q0, q1, q2, q3;

always #1 clk = !clk;

initial $dumpfile("rom_tb.vcd");
initial $dumpvars(0, rom_tb);

rom r
(
   .a(a),
   .re(re),
   .clk(clk),
   .q0(q0),
   .q1(q1),
   .q2(q2),
   .q3(q3)
);

initial  
begin
    #5 re = 1;
    #5 a = 32768;
    #5 a = 32769;
    #5 a = 40000;
    #5 re = 0;
    #5 a = 32768;
    #5 a = 10;
    #5 a = 65537;
    #5 re = 1;
    #5 a = 32769;
    #5 a = 10;
    #5 $finish;
end

endmodule
