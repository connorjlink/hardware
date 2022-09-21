`include "../msc/reg/reg.v"

module rf
(
    input[7:0] d,
    
    input ai, bi, ci, di, fi,
    input ao, bo, co, do, fo,

    input clk, rst,

    output reg[7:0] p, fq, fod
);

wire[7:0] ap, bp, cp, dp, fp;

reg_rst ar
(
    .d(d),
    .clk(clk),
    .rst(rst),
    .en(ai),
    .q(ap)
);

reg_rst br
(
    .d(d),
    .clk(clk),
    .rst(rst),
    .en(bi),
    .q(bp)
);

reg_rst cr
(
    .d(d),
    .clk(clk),
    .rst(rst),
    .en(ci),
    .q(cp)
);

reg_rst dr
(
    .d(d),
    .clk(clk),
    .rst(rst),
    .en(di),
    .q(dp)
);

reg_rst fr
(
    .d(d),
    .clk(clk),
    .rst(rst),
    .en(fi),
    .q(fp)
);

wire want_output = (ao | bo | co | do | fo);

always @(posedge clk)
begin
    fod <= fp;

    if (!fo)
    begin
        if (want_output)
        begin
                 if (ao) p <= ap;
            else if (bo) p <= bp;
            else if (co) p <= cp;
            else if (do) p <= dp;
            else if (fo) p <= fp;
        end

        else
            p <= 8'bz;
            
        fq <= 8'bz;
    end

    else
    begin
        fq <= fp;
    end 
end

endmodule