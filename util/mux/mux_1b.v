`include "../and/and_2w.v"
`include "../or/or_2w.v"
`include "../not/not_1w.v"

module mux_1b(input a, b, s, output o);
    wire si;
    not_1w(s, si);

    wire aa, ba;
    and_2w(a, s, aa);
    and_2w(b, si, ba);

    or_2w(aa, ba, o);
endmodule