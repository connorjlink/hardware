module ir
(
    input[23:0] raw,
    input[1:0] len,

    input we,
    input clk, rst,

    output reg[7:0] insn, d1, d2
);
    always @(posedge clk)
    begin
        if (rst)
        begin
            insn <= 0;
            d1 <= 0;
            d2 <= 0;
        end
    end

    always @(negedge clk)
    begin
        if (!rst && we)
        begin
            insn <= raw[31:24];
    
            case (len)
                0: //1 byte
                begin
                    d1 <= 8'bz;
                    d2 <= 8'bz;
                end

                1: //2 bytes
                begin
                    d1 <= raw[23:16];
                    d2 <= 8'bz;
                end

                2: //3 bytes
                begin
                    d1 <= raw[23:16];
                    d2 <= raw[15:8];
                end
            endcase
        end    
    end

endmodule