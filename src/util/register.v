module register(input[7:0] d, input clk, en, output reg[7:0] q);
    always @(posedge clk)
    begin
        if (en)
            q <= d;
    end
endmodule

module register_rst(input[7:0] d, input clk, rst, en, output reg[7:0] q);
    always @(posedge clk)
    begin
        if (en && !rst)
            q <= d;
        else if (rst)
            q <= 8'h00;
    end
endmodule