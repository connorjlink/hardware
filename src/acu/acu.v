module acu
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
        q <= 16'bz;
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
            begin
                if (oe)
                begin
                    tmp[7:0] <= d;
                    q <= tmp;
                end

                else
                begin
                    tmp[7:0] <= d;
                    q <= 16'bz;
                end
            end

            else if (wh)
            begin
                if (oe)
                begin
                    tmp[15:8] <= d;
                    q <= tmp;
                end

                else
                begin
                    tmp[15:8] <= d;
                    q <= 16'bz;
                end
            end

            if (oe)
                q <= tmp;
            else
                q <= 16'bz;
        end
    end

endmodule