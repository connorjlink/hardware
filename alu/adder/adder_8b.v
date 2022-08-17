`include "adder_4b.v"

module adder_8b(input[7:0] a, b, input ci, output[7:0] s, output co);
    wire c1;

    adder_4b fa1(a[3:0], b[3:0], ci, s[3:0], c1);
    adder_4b fa2(a[7:4], b[7:4], c1, s[7:4], co);
endmodule