module test(A, B, C, Y);
    input A, B, C;
    output Y;

    wire gate1, gate2, gate2a, gate3;

    nor n1(gate1, A, B);
    and a1(gate2, A, B);
    not il(gate2a, gate2);
    or ol(gate3, gate1, gate2a);
    and a2(Y, gate3, C);
endmodule