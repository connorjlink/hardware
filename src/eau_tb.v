`timescale 1ns / 100ps
`include "eau.v"


module EauTestbench;
    reg clock = 0;

    reg[7:0] d = 0;
    reg[15:0] a = 0;
    reg ai = 0, ao = 0, di = 0, do = 0, hs = 0, ls = 0, rst = 0;
    
    wire[7:0] dq = 0;
    wire[15:0] aq = 0;


    always #1 clock = !clock;

    initial $dumpfile("eautestbench.vcd");
    initial $dumpvars(0, EauTestbench);

     Eau eau
     (
        .d(d),
        .a(a),
        .ai(ai),
        .ao(ao),
        .di(di),
        .do(do),
        .hs(hs),
        .ls(ls),
        .clk(clock),
        .rst(rst),
        .dq(dq),
        .aq(aq)
     );

    initial
    begin
        #5 d = 8'hF1; di = 1; ls = 1;
        #5 d = 8'h14; di = 1; ls = 0; hs = 1;
        #5 hs = 0; ao = 1;
        #5 rst = 1;
        #5 $finish;
    end

    //input[7:0] d, 
    //input[15:0] a, 
    //input ai, ao, di, do, hs, ls, clk, rst, 
    
    //output[7:0] dq, 
    //output[15:0] aq



endmodule