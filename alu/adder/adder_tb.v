`timescale 1ns / 1ns
`include "adder_8b.v"

module adder_tb;
    reg[7:0] a, b;
    reg ci;

    wire[7:0] s;
    wire co;

    adder_8b adder_inst
    (
        .a(a),
        .b(b),
        .ci(ci),
        .s(s),
        .co(co)
    );

    initial begin
        a[7:0] = 8'h00;
        b[7:0] = 8'h00;
        ci = 1'b0;

        #10;

        a[7:0] = 8'h02;
        b[7:0] = 8'h03;
        ci = 1'b0;

        #10;

        a[7:0] = 8'hFF;
        b[7:0] = 8'hFF;
        ci = 1'b0;

        #10;

        a[7:0] = 8'h01;
        b[7:0] = 8'h00;
        ci = 1'b1;

        #10;

        a[7:0] = 8'h00;
        b[7:0] = 8'h00;
        ci = 1'b0;



        $dumpfile("adder.vcd");
        $dumpvars;
    end
endmodule