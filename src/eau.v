`include "../util/register.v"





module eauD_A(input[7:0] d, input di, clk, hs, ls, ao, output[15:0] a);
    wire[15:0] q;
    
    register_rst rl
    (
        d, 
        clk, 
        ls, 
        q[7:0]
    );

    register_rst rh
    (
        d,
        clk,
        hs,
        q[15:8]
    );

    assign a = q;

endmodule


module eau_A_D(input[15:0] a, input ai, clk, hs, ls, do, output[7:0] d);

endmodule