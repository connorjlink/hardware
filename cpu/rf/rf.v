`include "../msc/reg/reg.v"

module rf
(
    input[7:0] d,
    
    input ai, bi, ci, di, fi,
    input ao, bo, co, do, fo,

    input clk, rst,

    output[7:0] p, fq, fod
);

wire[7:0] ap, bp, cp, dp, fp;

reg_rst ar
(
    .d(d),
    .clk(clk),
    .rst(rst),
    .we(ai),
    .q(ap)
);

reg_rst br
(
    .d(d),
    .clk(clk),
    .rst(rst),
    .we(bi),
    .q(bp)
);

reg_rst cr
(
    .d(d),
    .clk(clk),
    .rst(rst),
    .we(ci),
    .q(cp)
);

reg_rst dr
(
    .d(d),
    .clk(clk),
    .rst(rst),
    .we(di),
    .q(dp)
);

reg_rst fr
(
    .d(d),
    .clk(clk),
    .rst(rst),
    .we(fi),
    .q(fp)
);

assign p = ao ? ap : 
           bo ? bp : 
           co ? cp : 
           do ? dp : 8'bz;

assign fq = fo ? fp : 8'bz;
assign fod = fp;

endmodule