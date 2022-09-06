module ram
(
    input[7:0] d,
    input[15:0] a,

    input re, we,
    input clk, rst,

    output reg[7:0] q
);
    localparam SIZE = 32768;

    reg[7:0] m[0:SIZE-1];

    initial
    begin
        for (integer i = 0; i < SIZE; i++)
            m[i] = 8'h00;
    end

    always @(posedge clk)
    begin
        if (rst)
		begin
			for (integer j = 0; j < SIZE; j++)
				m[j] <= 0;
		end

        else
        begin
            if (a < SIZE)
            begin
                if (we)
                begin
                    m[a] <= d;

                    if (re)
                        q <= d;
                end

                else if (re)
                begin
                    q <= m[a];
                end

                else
                    q <= 8'bz;
            end

            else
                q <= 8'bz;
        end
    end

endmodule