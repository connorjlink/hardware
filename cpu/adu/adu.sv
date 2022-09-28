module adu
(
    input[15:0] a,

    input we,
    input rl, rh,

    input clk, rst,

    output reg[7:0] q
);
    reg[15:0] tmp;

    initial
    begin
        tmp <= 16'h0000;
        q <= 8'bz;
    end

    always @(posedge clk)
    begin
        if (rst)
        begin
            tmp = 16'h0000;
            q = 8'bz;
        end

        else
        begin
            if (we)
                tmp = a;

            if (rl)
                q = tmp[7:0];

            else if (rh)
                q = tmp[15:8];

            else
                q = 8'bz;
        end
    end

endmodule