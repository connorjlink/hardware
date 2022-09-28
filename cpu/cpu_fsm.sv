module cpu_fsm
(
    input clk, rst
);

reg[7:0] r0, r1, r2, r3, rf;
reg[15:0] pc;

reg[7:0] insn, q1, q2, q3;
reg[7:0][0:65535] mem;

initial
begin
    r0 <= 0;
    r1 <= 0;
    r2 <= 0;
    r3 <= 0;
    rf <= 0;
    pc <= 16'h8000;

    for (integer i = 0; i < 32768; i++)
        mem[i] = 0;

    $readmemh("/Users/connor/desktop/cpu-design/test.o", mem, 32768);

    for (integer j = 32768; j < 65536; j++)
        $display("%d: %h", j, mem[j]);
end

always @(posedge clk)
begin
    if (rst)
    begin
        r0 <= 0;
        r1 <= 0;
        r2 <= 0;
        r3 <= 0;
        rf <= 0;
        pc <= 16'h8000;
    end

    else
    begin
        if (!rf[3])
        begin
            insn <= mem[pc + 0];
            q1 <= mem[pc + 1];
            q2 <= mem[pc + 2];
            q3 <= mem[pc + 3];

            case (insn)
                0: pc++;
                1: rf[3] <= 1;

                2: r0 <= r1;
                3: r0 <= r2;
                4: r0 <= r3;
                5: r0 <= rf;

                6: r1 <= r0;
                7: r1 <= r2;
                8: r1 <= r3;
                9: r1 <= rf;

                10: r2 <= r0;
                11: r2 <= r1;
                12: r2 <= r3;
                13: r2 <= rf;

                14: r3 <= r0;
                15: r3 <= r1;
                16: r3 <= r2;
                17: r3 <= rf;


            endcase
        end
    end
end

endmodule