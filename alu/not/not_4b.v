`include "not_1b.v"

module not_4b(input[3:0] a, output[3:0] b);
    not_1b n1(a[0], b[0]);
    not_1b n2(a[1], b[1]);
    not_1b n3(a[2], b[2]);
    not_1b n4(a[3], b[3]);
endmodule