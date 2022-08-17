 `timescale 1ns / 100ps
 `include "test.v"

 module test_tb;
    reg A, B, C;
    wire Y;

    test test_inst(
        .A(A),
        .B(B),
        .C(C),
        .Y(Y)
    );

    initial
        begin
            assign A = 0;
            assign B = 0;
            assign C = 0;

            #20 assign A = 1;
            #20 assign A = 0;
            #20 assign B = 1;
                assign C = 1;
            #20 assign B = 0;
            #20 assign A = 1;
                assign B = 1;
            #20 assign A = 0;
                assign C = 0;
            #20 assign B = 0;
            #20 assign A = 1;
                assign C = 1;

            $dumpfile("test.vcd");
            $dumpvars;

            $finish;

        end
endmodule