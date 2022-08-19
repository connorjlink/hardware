module reg_8b(input[7:0] in, input clk, en, output reg[7:0] out);
    always @(posedge clk)
    begin
        if (en)
            out <= in;
    end
endmodule