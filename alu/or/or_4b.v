`include "or_1b.v"

module or_4b(input[3:0] a, b, output[3:0] c);
    or_1b o1(a[0], b[0], c[0]);
    or_1b o1(a[1], b[1], c[1]);
    or_1b o1(a[2], b[2], c[2]);
    or_1b o1(a[3], b[3], c[3]);
endmodule