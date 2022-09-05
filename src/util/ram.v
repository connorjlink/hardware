module ram
(
	input [7:0] d,
	input [15:0] a,

	input we, clk,

	output[7:0] q1, q2, q3
);
	localparam SIZE = 32768;

	wire[15:0] ac = { 16{ a >= 16'h8000 } } & (a - 16'h8000);

	reg [7:0] m[SIZE:0];
	
	assign q1 = m[a + 0];
	assign q2 = m[a + 1];
	assign q3 = m[a + 2];

	always @(posedge clk)
	begin
		if (we) 
		begin
			m[a - 16'h8000] = d;
		end
	end
endmodule
