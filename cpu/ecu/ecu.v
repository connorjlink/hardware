`include "db/db.v"
`include "ir/ir.v"
`include "pc/pc.v"

module ecu
(
    input clk, rst,

    output reg[6:0] rf,
    output reg[4:0] lsu,
    output reg[9:0] alu,

    output reg[2:0] acu,
    output reg[2:0] adu,
);

reg[31:0] raw;

wire ir_we;
wire[3:0] pc_c;
wire[1:0] len;

wire[7:0] insn, d1, d2, d3;

ir ir_inst
(
    .raw(raw),
    .len(len),
    .ir(ir_we),
    .clk(clk),
    .rst(rst),
    .insn(insn),
    .d1(d1),
    .d2(d2),
    .d3(d3)
);

always @(negedge clk)
begin

end

endmodule