`include "register.v"

module register_tb;

reg clk = 0;
reg en = 1;

reg[15:0] d;
wire[15:0] q;

always #1 clk = !clk;

initial $dumpfile("register_tb.vcd");
initial $dumpvars(0, register_tb);

Register r
(

);

initial
begin
    #5 value_in = 31;
    #5 value_in = 127;
    #5 enable = 0;
    #5 value_in = 1023;
    #5 $finish;
end
endmodule
