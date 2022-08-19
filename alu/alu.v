`include "../util/reg/reg_8b.v"

module alu(input[7:0] a, b, fi, input[6:0] op, input clk, wo, oe, output[7:0] o, fo);
    wire[7:0] dw, fw;

    wire[8:0] ai = a;
    wire[8:0] bi = b;

    wire orego;
    Register oreg
    (
        .in(dw),
        .clk(clk),
        .en(wo),
        .out(orego)
    );
    
    wire frego;
    Register freg
    (
        .in(fw),
        .clk(clk),
        .en(wo),
        .out(frego)
    );

    
    case (op)
        7'b0000001: begin //addition
                        wire[8:0] r = ai + bi + fi[0];
                        dw = r[7:0];
                        fw[0] = r[8];
                    end

        7'b0000010: begin //subtraction
                        wire[8:0] r = ai - bi - fi[0];
                        dw = r[7:0];
                        fw[0] = r[8];
                    end

        7'b0000100: begin //and
                        dw = a & b;
                    end

        7'b0001000: begin //or
                        dw = a | b;
                    end

        7'b0010000: begin //not
                        dw = ~a;
                    end

        7'b0100000: begin //left shift

                    end

        7'b1000000: begin //right shift
                        
                    end

        default: ;
    endcase

    //input extend output enable
    localparam WIDTH = 8;
    wire oee = { {WIDTH-1{oe}}, oe };

    assign o = orego & oee;
    assign fo = frego & oee;
endmodule