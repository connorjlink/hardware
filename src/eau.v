`include "../util/register.v"


module Eau_D_A(input[7:0] d, input di, clk, rst, hs, ls, ao, output[15:0] a);
    wire[15:0] q;
    wire[7:0] p;
    assign p = d & { 8{ di } };

    register_rst rl
    (
        .d(p), 
        .clk(clk),
        .rst(rst), 
        .en(ls), 
        .q(q[7:0])
    );

    register_rst rh
    (
        .d(p),
        .clk(clk),
        .rst(rst),
        .en(hs),
        .q(q[15:8])
    );

    assign a = ao ? q : 16'bz;
endmodule


module Eau_A_D(input[15:0] a, input ai, clk, rst, hs, ls, do, output[7:0] d);
    wire[7:0] q = 0, l = 0, h = 0;

    assign q = (l & { 8{ ls } }) | (h & { 8{ hs } });

    wire[15:0] p;
    assign p = a & { 8{ ai } };

    register_rst rl
    (
        .d(p[7:0]), 
        .clk(clk),
        .rst(rst), 
        .en(ls), 
        .q(l)
    );

    register_rst rh
    (
        .d(p[15:8]),
        .clk(clk),
        .rst(rst),
        .en(hs),
        .q(h)
    );

    assign d = do ? (q) : (8'bz);
endmodule


module Eau(input[7:0] d, input[15:0] a, input ai, ao, di, do, hs, ls, clk, rst, output[7:0] dq, output[15:0] aq);
    Eau_D_A eau_da
    (
        .d(d),
        .di(di),
        .clk(clk),
        .rst(rst),
        .hs(hs),
        .ls(ls),
        .ao(ao),
        .a(aq)
    );

    Eau_A_D eau_ad
    (
        .a(a),
        .ai(ai),
        .clk(clk),
        .rst(rst),
        .hs(hs),
        .ls(ls),
        .do(do),
        .d(dq)
    );


endmodule