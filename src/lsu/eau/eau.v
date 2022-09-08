module eau
(
    input[7:0] d,
    
    input wl, wh,
    input clk, rst,

    input oe,

    output reg[15:0] q
);
    reg[15:0] tmp;

    initial 
    begin
        tmp <= 16'h0000;
    end

    always @(posedge clk)
    begin
        if (rst)
        begin
            tmp <= 16'h0000;

            if (oe)
                q <= tmp;
            else 
                q <= 16'bz;
        end

        else
        begin
            if (wl)
                tmp[7:0] <= d;

            else if (wh)
                tmp[15:8] <= d;

            if (oe)
                q <= tmp;

            else
                q <= 16'bz;
        end
    end

endmodule