`include "or_4b.v"

module or_8b(input[7:0] a, b, output[7:0] c);
    or_4b o1(a[3:0], b[3:0], c[3:0]);
    or_4b o2(a[7:4], b[7:4], c[7:4]);
endmodule