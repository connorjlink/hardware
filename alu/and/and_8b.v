`include "and_4b.v"

module and_8b(input[7:0] a, b, output[7:0] c);
    and_4b a1(a[3:0], b[3:0], c[3:0]);
    and_4b a2(a[7:4], b[7:4], c[7:4]);
endmodule