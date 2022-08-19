`include "and_1b.v"

module and_4b(input[3:0] a, b, output[3:0] c);
    and_1b a1(a[0], b[0], c[0]);
    and_1b a2(a[1], b[1], c[0]);
    and_1b a3(a[2], b[2], c[0]);
    and_1b a4(a[3], b[3], c[0]);
endmodule