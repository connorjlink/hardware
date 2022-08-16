`include "adder_1b.v"

module adder_4b(input[3:0] a, b, input ci, output[3:0] s, output co);
    wire c1, c2, c3;

    adder_1b fa1(a[0], b[0], ci, s[0], c1);
    adder_1b fa2(a[1], b[1], c1, s[1], c2);
    adder_1b fa3(a[2], b[2], c2, s[2], c3);
    adder_1b fa4(a[3], b[3], c3, s[3], co);
endmodule