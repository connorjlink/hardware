`timescale 1ns / 100ps
`include "db.sv"

module db_tb;
    reg[7:0] insn = 0, d1 = 0, d2 = 0;
    reg[2:0] is = 0;

    reg clk = 0, rst = 0;

    wire rf_ai, rf_bi, rf_ci, rf_di, rf_fi;
    wire rf_ao, rf_bo, rf_co, rf_do, rf_fo;

    wire lsu_re, lsu_we, lsu_sp_d, lsu_sp_we, lsu_sp_en;

    wire alu_add, alu_sub, alu_and, alu_or, alu_not, alu_shl, alu_shr;

    wire ir_we;

    wire pc_lrc, pc_ini, pc_cub, pc_oe;

    wire acu_wl, acu_wh, acu_oe;
    wire adu_rl, adu_rh, adu_oe;

    wire out_q1, out_q2;
    wire trap

    wire[1:0] len;


always #1 clk = !clk;

initial $dumpfile("db_tb.vcd");
initial $dumpvars(0, db_tb);

db d
(
    .insn(insn),
    .d1(d1),
    .d2(d2),
    .is(is),
    .clk(clk),
    .rst(rst),
    .rf_ai(rf_ai),
    .rf_ao(rf_ao),
    .rf_bi(rf_bi),
    .rf_bo(rf_bo),
    .rf_ci(rf_ci),
    .rf_co(rf_co),
    .rf_di(rf_di),
    .rf_do(rf_do),
    .rf_fi(rf_fi),
    .rf_fo(rf_fo),
    .lsu_re(lsu_re),
    .lsu_we(lsu_we),
    .lsu_sp_d(lsu_sp_d),
    .lsu_sp_we(lsu_sp_we),
    .lsu_sp_en(lsu_sp_en),
    .alu_add(alu_add),
    .alu_sub(alu_sub),
    .alu_and(alu_and),
    .alu_or(alu_or),
    .alu_not(alu_not),
    .alu_shl(alu_shl),
    .alu_shr(alu_shr),
    .alu_wa(alu_wa),
    .alu_wb(alu_wb),
    .alu_oe(alu_oe),
    .ir_we(ir_we),
    .pc_lrc(pc_lrc),
    .pc_ini(pc_ini),
    .pc_cub(pc_cub),
    .pc_oe(pc_oe),
    .acu_wl(acu_wl),
    .acu_wh(acu_wh),
    .acu_oe(acu_oe),
    .adu_rl(adu_rl),
    .adu_rh(adu_rh),
    .adu_oe(adu_oe),
    .out_q1(out_q1),
    .out_q2(out_q2),
    .trap(trap),
    .len(len)
);

initial
begin
    #5
    #5 insn = 13; d1 = 100; d2 = 50;
    
    #1
    #5 insn = 24;
    #5 $finish;
end

endmodule
