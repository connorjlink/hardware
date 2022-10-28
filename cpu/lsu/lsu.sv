`include "ram/ram.v"
`include "rom/rom.v"
`include "sp/sp.v"

module lsu
(
    input[7:0] dbi,
    input[15:0] abi,
    
    input clk, rst,

    input stack_decrement,
          stack_write,
          stack_enable,

    input read_enable,
          write_enable,

    output[7:0] instruction, data1, data2,
    output[7:0] fbo,
    output[15:0] stack_pointer,
);
    localparam RAM_SIZE = 32768;

    logic[7:0] ram[0:RAM_SIZE-1];

`define RESET_MEM(x, y) for (integer i = 0; i < y``_SIZE; ++i) \
                            x[i] = 0;

    initial
    begin
        `RESET_MEM(ram, RAM)
    end

    // TODO: maybe refactor later to be sensitive only to negedge or posedge
    always @(clk)
    begin
        if (rst)
        begin
            `RESET_MEM(ram, RAM)
        end

        else
        begin
            if (a < RAM_SIZE)
            begin
                if (write_eanble)
                    ram[abi] = dbi;

                if (read_enable)
                    dbo = ram[abi];
                else
                    dbo = 8'bz;
            end

            else
            begin

            end
        end
    end


    wire[15:0] sp_val;

    assign spq = sp_val;

ram ram_inst
(
    .d(d),
    .a(sp_en ? sp_val : a),
    .re(re),
    .we(we),
    .clk(clk),
    .rst(rst),
    .q(q0)
);

rom rom_inst
(
    .a(a),
    .re(re),
    .clk(clk),
    .q0(q0),
    .q1(q1),
    .q2(q2)
);

sp sp_inst
(
    .d(sp_d),
    .en(sp_we & sp_en),
    .clk(clk),
    .rst(rst),
    .q(sp_val)
);

endmodule