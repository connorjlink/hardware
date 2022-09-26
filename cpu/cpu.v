`include "acu/acu.v"
`include "adu/adu.v"
`include "alu/alu.v"
`include "ecu/ecu.v"
`include "lsu/lsu.v"
`include "rf/rf.v"

module cpu
(
    input clk, rst
);

wire[7:0] db, fb;
wire[15:0] ab;

wire[15:0] sp;
wire[15:0] pc;
wire[2:0] is;

wire[31:0] rom_raw;

wire[6:0] rf_ctl;
wire[4:0] lsu_ctl;
wire[9:0] alu_ctl;
wire[2:0] acu_ctl;
wire[2:0] adu_ctl;

wire[7:0] fod;

acu acu_inst
(
    .d(db),
    .wl(acu_ctl[0]),
    .wh(acu_ctl[1]),
    .clk(clk),
    .rst(rst),
    .oe(acu_ctl[2]),
    .q(ab),
);

adu adu_inst
(
    .a(ab),
    .we(adu_ctl[0]),
    .rl(adu_ctl[1]),
    .rh(adu_ctl[2]),
    .clk(clk),
    .rst(rst),
    .q(db)
);

alu alu_inst
(
    .a(db),
    .b(db),
    .fi(fod),
    .op(alu_ctl[6:0]),
    .wa(alu_ctl[7]),
    .wb(alu_ctl[8]),
    .clk(clk),
    .rst(rst),
    .oe(alu_ctl[9]),
    .d(db),
    .fo(fb)
);

ecu ecu_inst
(
    .ai(ab),
    .raw(rom_raw),
    .clk(clk),
    .rst(rst),
    .rf(rf),
    .lsu(lsu),
    .alu(alu),
    .acu(acu),
    .adu(adu),
    .ao(ab)
);

lsu lsu_inst
(
    .d(db),
    .a(ab),
    .clk(clk),
    .rst(rst),
    .sp_d(lsu_ctl[0]),
    .sp_we(lsu_ctl[1]),
    .sp_en(lsu_ctl[2]),
    .re(lsu_ctl[3]),
    .we(lsu_ctl[4]),
    .q(rom_raw[7:0]),
    .q1(rom_raw[15:8]),
    .q2(rom_raw[23:16]),
    .q3(rom_raw[31:24]),
    .fo(fb),
    .spq(sp)
);

rf rf_inst
(
    .d(db),
    .ai(rf_ctl[0]),
    .bi(rf_ctl[1]),
    .ci(rf_ctl[2]),
    .di(rf_ctl[3]),
    .fi(rf_ctl[4]),
    .ao(rf_ctl[5]),
    .bo(rf_ctl[6]),
    .co(rf_ctl[7]),
    .do(rf_ctl[8]),
    .fo(rf_ctl[9]),
    .clk(clk),
    .rst(rst),
    .p(db),
    .fq(fb),
    .fod(fod)
);

endmodule