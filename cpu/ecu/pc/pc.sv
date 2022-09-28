module pc
(
    input[15:0] ai,

    input clk, rst,

    //load and reset counter
    //increment to next instruction
    //count up both
    input lrc, ini, cub,

    //for address bus ports
    input oe,

    output reg[15:0] ao,
    output reg[2:0] is
);

    reg[15:0] ac = 0;
    reg[2:0] ic = 0;

    //for simulation purposes only
    initial
    begin
        ac = 16'h8000;
        ic = 3'b000;
    end

    always @*
    begin
        if (oe)
            ao <= ac;
        else
            ao <= 16'bz;

        is <= ic;
    end

    always @(posedge clk)
    begin
        if (rst)
        begin
            ac <= 16'h8000;
            ic <= 3'b000;
        end

        else
        begin
            if (ic == 3'b111)
            begin
                ic <= 0;
                ac += 1;
            end


            if (lrc)
            begin
                ic <= 3'b000;
                ac <= ai;
            end

            else if (ini)
            begin
                ic <= 3'b000;
                ac += 1;
            end

            else if (cub)
            begin
                if (ic == 3'b110)
                begin
                    ic <= 0;
                    ac += 1;
                end

                else
                begin
                    ic += 2;
                    ac += 1;
                end
            end

            else
                ic += 1;

            // TODO: verify address on { 0x8000 <= a <= 0xFFFF - 3 }
            //three is max extra instruction lengths      
        end
    end
endmodule
