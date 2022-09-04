`include "../util/register.v"

module rf
(
    input[7:0] d,
    
    input as, bs, cs, ds, fs,

    input re, we,
    input clk, rst,

    output reg[7:0] p, fo, fod
);

wire[7:0] at, bt, ct, dt, ft;

wire al = as | rst,
     bl = bs | rst,
     cl = cs | rst,
     dl = ds | rst,
     fl = fs | rst;

wire aw = as && we;
wire ar = as && re;
register_rst r0
(
    .d(d),
    .clk(clk),
    .rst(rst),
    .en(aw),
    .q(at)
);


wire bw = bs && we;
wire br = bs && re;
register_rst r1
(
    .d(d),
    .clk(clk),
    .rst(rst),
    .en(bw),
    .q(bt)
);


wire cw = cs && we;
wire cr = cs && re;
register_rst r2
(
    .d(d),
    .clk(clk),
    .rst(rst),
    .en(cw),
    .q(ct)
);


wire dw = ds && we;
wire dr = ds && re;
register_rst r3
(
    .d(d),
    .clk(clk),
    .rst(rst),
    .en(dw),
    .q(dt)
);


wire fw = fs && we;
wire fr = fs && re;
register_rst rf
(
    .d(d),
    .clk(clk),
    .rst(rst),
    .en(fw),
    .q(ft)
);

always @*
begin
    fod = ft;

    if (!fr)
    begin
        p = re ? ({ 8{ as } } & at) |
                 ({ 8{ bs } } & bt) |
                 ({ 8{ cs } } & ct) |
                 ({ 8{ ds } } & dt) : 8'bz;
    end

    else
        fo = ft;
end

endmodule