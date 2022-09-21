module reg_std
(
    input[7:0] d, 
    
    input en,
    input clk,

    output reg[7:0] q
);
    always @(posedge clk)
    begin
        if (en)
            q <= d;
    end
endmodule

module reg_rst
(
    input[7:0] d,
    
    input we,
    input clk, rst,

    output reg[7:0] q
);
    always @(posedge clk)
    begin
        if (rst)
            q <= 8'b0;
        else if (we)
            q <= d;
    end
endmodule