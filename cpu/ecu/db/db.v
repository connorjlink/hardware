//decoder block
//this module is basically a wrapper on embedded microcode

module db
(
    input[7:0] insn, d1, d2, d3,
    input[2:0] is,

    input clk, rst,

    output reg[6:0] rf,
    /*
    output reg rf_ai, // 0
               rf_bi, // 1
               rf_ci, // 2
               rf_di, // 3
               rf_fi, // 4

               rf_ao, // 5
               rf_bo, // 6
               rf_co, // 7
               rf_do, // 8
               rf_fo, // 9
    */

    output reg[4:0] lsu,
    /*
    output reg lsu_re,    // 10
               lsu_we,    // 11
               lsu_sp_d,  // 12
               lsu_sp_we, // 13
               lsu_sp_en, // 14
    */

    output reg[9:0] alu,
    /*
    output reg alu_add, // 15
               alu_sub, // 16
               alu_and, // 17
               alu_or,  // 18
               alu_not, // 19
               alu_shl, // 20
               alu_shr, // 21
               alu_wa,  // 22
               alu_wb,  // 23
               alu_oe,  // 24
    */

    output reg ir_we, // 25

    output reg[3:0] pc,
    /*
    output reg pc_lrc, // 26 - load and reset counter; zero out step, take in address
               pc_ini, // 27 - increment to next instruction; zero out step, increment address
               pc_cub, // 28 - count up both; increment step, increment address
               pc_oe,  // 29
    */

    output reg[2:0] acu,
    /*
    output reg acu_wl, // 30
               acu_wh, // 31
               acu_oe, // 32
    */

    output reg[2:0] adu,
    /*
    output reg adu_rl, // 33
               adu_rh, // 34
               adu_oe, // 35
    */

    //more outputs here 

    output reg[1:0] len
);

    localparam UCODE_WIDTH = 64;
    localparam UCODE_ENTRIES = 256;
    localparam UCODE_STEPS = 8;
    localparam UCODE_LENGTH = UCODE_ENTRIES * UCODE_STEPS;

    localparam WRITE_FILE = 1;

    reg[UCODE_WIDTH-1:0] ucode[0:UCODE_LENGTH-1];

    wire addr = (insn * UCODE_STEPS) + is;
    reg[UCODE_WIDTH-1:0] tmp;

    initial 
    begin
        $readmemh("/Users/connor/desktop/cpu-design/ucode.bin", ucode);

		if (WRITE_FILE)
			for (integer i = 0; i < UCODE_ENTRIES; i++)
				$display("%d: %h", i, ucode[i]);
    end

    always @(negedge clk)
    begin
        if (rst)
            tmp = 64'b0;

        else
        begin
            tmp = ucode[addr];

            rf    <= tmp[9:0];
            lsu   <= tmp[14:10];
            alu   <= tmp[24:15];
            ir_we <= tmp[25];
            pc    <= tmp[29:26];
            acu   <= tmp[32:30];
            adu   <= tmp[35:33];

            len   <= tmp[63:62]; 
        end
    end

endmodule