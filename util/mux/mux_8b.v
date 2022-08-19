module mux_8b(input[7:0] d0, d1, d2, d3, d4, d5, d6, d7, input[2:0] s, output reg[7:0] o);
    always @*
    begin
        case (s)
            3'b000: o = d0;
            3'b001: o = d1;
            3'b010: o = d2;
            3'b011: o = d3;
            3'b100: o = d4;
            3'b101: o = d5;
            3'b110: o = d6;
            3'b111: o = d7;
        endcase
    end
endmodule