`include "ram/ram.v"
`include "rom/rom.v"
`include "sp/sp.v"

module lsu
(
    input[7:0] d,
    input[15:0] a,
    
    input clk, rst,

    input sp_d, sp_we, sp_en,

    input re, we, 

    output[7:0] q, q1, q2, q3, 
    output[7:0] fo
);

    wire[15:0] sp_val;

ram ram_inst
(
    .d(d),
    .a(sp_en ? sp_val : a),
    .re(re),
    .we(we),
    .clk(clk),
    .rst(rst),
    .q(q)
);

rom rom_inst
(
    .a(a),
    .re(re),
    .clk(clk),
    .q0(q),
    .q1(q1),
    .q2(q2),
    .q3(q3)
);

sp sp_inst
(
    .d(sp_d),
    .en(sp_we & sp_en),
    .clk(clk),
    .rst(rst),
    .q(sp_val)
);

endmodule