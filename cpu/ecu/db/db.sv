//decoder block
//this module is basically a wrapper on embedded microcode
//`include "ctl_lines.h"

module db
(
    input[7:0] insn, d1, d2,
    input[2:0] is,

    input clk, rst,

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

               lsu_re,    // 10
               lsu_we,    // 11
               lsu_sp_d,  // 12
               lsu_sp_we, // 13
               lsu_sp_en, // 14

               alu_add, // 15
               alu_sub, // 16
               alu_and, // 17
               alu_or,  // 18
               alu_not, // 19
               alu_shl, // 20
               alu_shr, // 21
               alu_wa,  // 22
               alu_wb,  // 23
               alu_oe,  // 24

               ir_we, // 25

               pc_lrc, // 26 - load and reset counter; zero out step, take in address
               pc_ini, // 27 - increment to next instruction; zero out step, increment address
               pc_cub, // 28 - count up both; increment step, increment address
               pc_oe,  // 29

               acu_wl, // 30
               acu_wh, // 31
               acu_oe, // 32

               adu_rl, // 33
               adu_rh, // 34
               adu_oe, // 35

    //more outputs here 

    output reg out_q1, out_q2,

    output reg trap,
    output reg[1:0] len
);
    `include "ctl_lines.h"
    ctl_lines;

    localparam UCODE_STEPS = 8;
    localparam UCODE_WIDTH = 64;
    localparam UCODE_ENTRIES = 256;
    localparam UCODE_LENGTH = UCODE_ENTRIES * UCODE_STEPS;

    localparam WRITE_FILE = 1;

    reg[UCODE_WIDTH-1:0] ucode[0:UCODE_ENTRIES-1][0:UCODE_STEPS-1];

    wire addr = ;
    reg[UCODE_WIDTH-1:0] tmp;

    initial 
    begin
        $readmemh("/Users/connor/desktop/cpu-design/ucode.bin", ucode);

		if (WRITE_FILE)
			for (integer i = 0; i < UCODE_ENTRIES; i++)
                for (integer j = 0; j < UCODE_STEPS; j++)
                    $display("%d: %h", (i * UCODE_ENTRIES) + j, ucode[i][j]);
    end

    always @(negedge clk)
    begin
        if (rst)
            tmp = 64'b0;

        else
        begin
            tmp = ucode[insn][is];

            rf_ai <= tmp[RF_AI];
            rf_bi <= tmp[RF_BI];
            rf_ci <= tmp[RF_CI];
            rf_di <= tmp[RF_DI];
            rf_fi <= tmp[RF_FI];

            rf_ao <= tmp[RF_AO];
            rf_bo <= tmp[RF_BO];
            rf_co <= tmp[RF_CO];
            rf_do <= tmp[RF_DO];
            rf_fo <= tmp[RF_FO];

            lsu_re    <= tmp[LSU_RE];
            lsu_we    <= tmp[LSU_WE];
            lsu_sp_d  <= tmp[LSU_SP_D];
            lsu_sp_we <= tmp[LSU_SP_WE];
            lsu_sp_en <= tmp[LSU_SP_EN];

            alu_add <= tmp[ALU_ADD];
            alu_sub <= tmp[ALU_SUB];
            alu_and <= tmp[ALU_AND];
            alu_or  <= tmp[ALU_OR];
            alu_not <= tmp[ALU_NOT];
            alu_shl <= tmp[ALU_SHL];
            alu_shr <= tmp[ALU_SHR];
            alu_wa  <= tmp[ALU_WA];
            alu_wb  <= tmp[ALU_WB];
            alu_oe  <= tmp[ALU_OE];

            ir_we <= tmp[IR_WE];

            pc_lrc <= tmp[PC_LRC];
            pc_ini <= tmp[PC_INI];
            pc_cub <= tmp[PC_CUB];
            pc_oe  <= tmp[PC_OE];

            acu_wl <= tmp[ACU_WL];
            acu_wh <= tmp[ACU_WH];
            acu_oe <= tmp[ACU_OE];

            adu_rl <= tmp[ADU_RL];
            adu_rh <= tmp[ADU_RH];
            adu_oe <= tmp[ADU_OE];

            out_q1 <= tmp[OUT_Q1];
            out_q2 <= tmp[OUT_Q2];

            trap <= tmp[TRAP];

            len <= tmp[LEN1:LEN0];
        end
    end

endmodule