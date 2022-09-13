module sp
(
    input d, //1 = decrement; 0 = increment;
    input en,

    input clk, rst,

    output reg[15:0] q
);

    reg[14:0] sp;

    initial
    begin
        sp <= 15'h7FFF;
    end

    always @(posedge clk)
    begin
        if (rst)
        begin
            sp <= 15'h7FFF;
            q <= 15'h7FFF;
        end

        else
        begin
            if (en)
            begin
                if (d)
                    sp--;
                else 
                    sp++;
            end

            q <= { 1'b0, sp };
        end
    end

endmodule