//decoder block
//this module is basically a wrapper on embedded microcode

module db
(
    input[7:0] insn, d1, d2, d3,
    input[2:0] is,

    input clk, rst,

    output reg[6:0] rf,

    /*
    output reg rf_as, // 0
               rf_bs, // 1
               rf_cs, // 2
               rf_ds, // 3
               rf_fs, // 4
               rf_re, // 5
               rf_we, // 6
    */

    output reg[4:0] lsu,

    /*
    output reg lsu_re,    // 7
               lsu_we,    // 8
               lsu_sp_d,  // 9
               lsu_sp_we, // 10
               lsu_sp_en, // 11
    */

    output reg[9:0] alu,

    /*
    output reg alu_add, // 12
               alu_sub, // 13
               alu_and, // 14
               alu_or,  // 15
               alu_not, // 16
               alu_shl, // 17
               alu_shr, // 18
               alu_wa,  // 19
               alu_wb,  // 20
               alu_oe,  // 21
    */

    output reg ir_we, // 22

    output reg[3:0] pc,

    /*
    output reg pc_lrc, // 23 - load and reset counter; zero out step, take in address
               pc_ini, // 24 - increment to next instruction; zero out step, increment address
               pc_cub, // 25 - count up both; increment step, increment address
               pc_oe,  // 26
    */

    output reg[2:0] acu,

    /*
    output reg acu_wl, // 27
               acu_wh, // 28
               acu_oe, // 29
    */

    output reg[2:0] adu,

    /*
    output reg adu_rl, // 30
               adu_rh, // 31
               adu_oe, // 32
    */

    output reg[1:0] len
);

    localparam UCODE_WIDTH = 48;
    localparam UCODE_ENTRIES = 256;
    localparam UCODE_STEPS = 8;
    localparam UCODE_LENGTH = UCODE_ENTRIES * UCODE_STEPS;

    localparam WRITE_FILE = 1;

    reg[UCODE_WIDTH-1:0] ucode[0:UCODE_LENGTH-1];

    initial 
    begin
        $readmemh("/Users/connor/desktop/cpu-design/ucode.bin", ucode);

		if (WRITE_FILE)
			for (integer i = 0; i < UCODE_ENTRIES; i++)
				$display("%d: %h", i, ucode[i]);
    end

    always @(negedge clk)
    begin



    end

endmodule