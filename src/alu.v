module Alu(input[7:0] a, b, fi, input[6:0] op, output[7:0] d, fo);
    reg[8:0] out = 0;
    reg[7:0] flags = 0;

    reg[8:0] ai, bi;
    reg signed[7:0] tmp;

    assign d = out[7:0];
    assign fo = flags;

    localparam CARRY = 0;

    initial
    begin
        out = 0;
        flags = 0;
    end

    always @*
    begin
        ai = {1'b0,a};
        bi = {1'b0,b};

        case (op)
            7'b0000001: //addition
            begin
                out = ai + bi + {8'h00,fi[CARRY]};
                flags[CARRY] = out[8];
            end

            7'b0000010: //subtraction
            begin
                out = ai - bi - {8'h00,fi[CARRY]};
                flags[CARRY] = out[8];
            end

            7'b0000100: //bitwise and
            begin
                out = ai & bi;
            end

            7'b0001000: //bitwise or
            begin
                out = ai | bi;
            end

            7'b0010000: //bitwise not
            begin
                out = ~ai;
            end

            7'b0100000: //left shift
            begin
                out = ai << bi;
            end

            7'b1000000: //right shift
            begin
                out = ai >> bi;
            end

            default: ;
        endcase

        flags[1] = (out[7:0] == 0);
        tmp = out[7:0];
        flags[2] = tmp > 0;
    end
endmodule