`include "agu.sv"

module agu_tb;
    logic[15:0] abi = 0;
    logic[7:0] dbi = 0;

    logic dwe = 0, drl = 0, drh = 0,
          cre = 0, cwl = 0, cwh = 0;

    logic clk = 0, rst = 0;

    wire[15:0] abo;
    wire[7:0] dbo;


    always #1 clk = !clk;

    initial $dumpfile("agu_tb.vcd");
    initial $dumpvars(0, agu_tb);

    agu agu_inst
    (
        .abi(abi),
        .dbi(dbi),
        .dwe(dwe),
        .drl(drl),
        .drh(drh),
        .cre(cre),
        .cwl(cwl),
        .cwh(cwh),
        .clk(clk),
        .rst(rst),
        .abo(abo),
        .dbo(dbo)
    );

    initial
    begin
        #5 dbi = 100; cwl = 1; cre = 1;
        #5 dbi = 64; cwl = 0;  cwh = 1;
        #5 cwh = 0;
        #5 cre = 0;
        #5 cre = 1;
        #5 cre = 0;
        #2
        #5 dbi = 32; cwh = 1;
        #5 cwh = 0;
        #5 cre = 1;
        #5 rst = 1;
        #10
        #5 dbi = 0;
        #5 abi = 31246; dwe = 1;
        #5 dwe = 0; drl = 1;
        #5 drl = 0; drh = 1;
        #1
        #5 abi = 20000; drh = 0; dwe = 1;
        #5
        #5 dwe = 0; drh = 1;
        #5
        #5 drh = 0; drl = 1;
        #5 rst = 1;
        #10 $finish
    end
endmodule