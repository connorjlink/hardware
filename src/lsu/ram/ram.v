module ram
(
    input[7:0] d,
    input[15:0] a,

    input re, we, 
    input clk, rst,

    output reg[7:0] q
);

    localparam SIZE = 32768;

    reg[7:0] m[0:SIZE-1];

    initial
    begin
        for (integer i = 0; i < SIZE; i++)
            m[i] = 0;
    end

    always @(clk)
    begin
        if (rst)
        begin
            
        end

        else
        begin
            if (a < SIZE)
            begin
                if (we && re)
                begin
                    m[a] <= d;
                    q <= d;
                end

                else if (we)
                    m[a] <= d;

                else if (re)
                    q <= m[a];

                else
                    q <= 8'bz;
            end

            else
                q <= 8'bz;
        end
    end
endmodule
