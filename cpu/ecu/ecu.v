`include "db/db.v"
`include "ir/ir.v"
`include "pc/pc.v"

module ecu
(
    input[15:0] ai,
    input[31:0] raw,
    input clk, rst,

    output[6:0] rf,
    output[4:0] lsu,
    output[9:0] alu,

    output[2:0] acu,
    output[2:0] adu,

    output[15:0] ao
);

wire ir_we;
wire[3:0] pc_ctl_lines;
wire[1:0] len;

wire[7:0] insn, d1, d2, d3;
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
    .d2(d2),
    .d3(d3)
);

pc pc_inst
(
    .ai(ai),
    .clk(clk),
    .rst(rst),
    .lrc(pc_ctl_lines[3]),
    .ini(pc_ctl_lines[2]),
    .cub(pc_ctl_lines[1]),
    .oe(pc_ctl_lines[0]),
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
    .len(len)
);

endmodule