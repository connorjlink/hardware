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
                1: rf[3] = 1;


            endcase
        end
    end
end

endmodule