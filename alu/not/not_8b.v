`include "not_4b.v"

module not_8b(input[7:0] a, output[7:0] b);
    not_4b n1(a[3:0], b[3:0]);
    not_4b n2(a[7:4], b[7:4]);
endmodule