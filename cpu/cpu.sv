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

wire[7:0] db, fb, fod;
wire[15:0] ab;

wire[15:0] sp;
wire[15:0] pc;
wire[2:0] is;

wire[23:0] rom_raw;

wire alu_add, 
     alu_sub,
     alu_and,
     alu_or,
     alu_not,
     alu_shl,
     alu_shr,
     alu_wa,
     alu_wb,
     alu_oe;

wire rf_ai, rf_bi, rf_ci, rf_di, rf_fi,
     rf_ao, rf_bo, rf_co, rf_do, rf_fo;

wire acu_wl,
     acu_wh,
     acu_oe;

wire adu_rl,
     adu_rh,
     adu_we;

wire lsu_re,
     lsu_we,
     lsu_sp_d,
     lsu_sp_we,
     lsu_sp_en;

wire ir_we;

wire pc_lrc, 
     pc_ini, 
     pc_sub, 
     pc_oe;

wire out_q1,
     out_q2;

wire trap;


wire[1:0] len;

wire[7:0] insn, d1, d2;
wire[2:0] is;

wire[15:0] pc_out;
assign ao = pc_out;

ir ir_inst
(
    .raw(raw),
    .len(len),
    .we(ir_we),
    .clk(clk),
    .rst(rst),
    .insn(insn),
    .d1(d1),
    .d2(d2)
);

pc pc_inst
(
    .ai(ai),
    .clk(clk),
    .rst(rst),
    .lrc(pc_lrc),
    .ini(pc_ini),
    .cub(pc_cub),
    .oe(pc_oe),
    .ao(pc_out),
    .is(is)
);

db db_inst
(
    .insn(insn),
    .d1(d1),
    .d2(d2),
    .d3(d3),
    .clk(clk),
    .rst(rst),
    .rf(rf),
    .lsu(lsu),
    .alu(alu),
    .ir_we(ir_we),
    .pc(pc_ctl_lines),
    .acu(acu),
    .adu(adu),
    .out_q1(out_q1),
    .out_q2(out_q2),
    .trap(trap),
    .len(len)
);

acu acu_inst
(
    .d(db),
    .wl(acu_wl),
    .wh(acu_wh),
    .clk(clk),
    .rst(rst),
    .oe(acu_oe),
    .q(ab),
);

adu adu_inst
(
    .a(ab),
    .we(adu_we),
    .rl(adu_rl),
    .rh(adu_rh),
    .clk(clk),
    .rst(rst),
    .q(db)
);

alu alu_inst
(
    .a(db),
    .b(db),
    .fi(fod),
    .add(alu_add),
    .sub(alu_sub),
    .land(alu_and),
    .lor(alu_or),
    .lnot(alu_not),
    .shl(alu_shl),
    .shr(alu_shr),
    .wa(alu_wa),
    .wb(alu_wb),
    .clk(clk),
    .rst(rst),
    .oe(alu_oe),
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
    .out_q1(out_q1),
    .out_q2(out_q2),
    .trap(trap),
    .ao(ab)
);

lsu lsu_inst
(
    .d(db),
    .a(ab),
    .clk(clk),
    .rst(rst),
    .sp_d(lsu_sp_d),
    .sp_we(lsu_sp_we),
    .sp_en(lsu_sp_en),
    .re(lsu_re),
    .we(lsu_we),
    .q0(rom_raw[7:0]),
    .q1(rom_raw[15:8]),
    .q2(rom_raw[23:16]),
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

always @(posedge clk)
begin
    if (out_q1)
        db <= rom_raw[15:8];
    else if (out_q2)
        db <= rom_raw[23:16];
    else
        db <= 8'bz;
end

endmodule