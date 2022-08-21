module register(input[7:0] d, input clk, en, output reg[7:0] q);
    always @*
    begin
        if (clk & en)
            q = d;
    end
endmodule