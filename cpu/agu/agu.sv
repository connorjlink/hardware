module agu
(
    input[15:0] abi,
    input[7:0] dbi,

    input dwe, drl, drh,
    input cre, cwl, cwh,

    input clk, rst,

    output logic[15:0] abo,
    output logic[7:0] dbo
);
    logic[15:0] cc, dc;

//reuse the register clear code
`define RESET_ALL cc  <= 16'h0; \
                  dc  <= 16'h0; \
                  abo <= 16'bz; \
                  dbo <= 8'bz;

    initial
    begin
        `RESET_ALL
    end

    always @(posedge clk)
    begin
        if (rst)
        begin
            `RESET_ALL
        end

        else
        begin
            if (dwe) dc = abi;

                 if (cwl) cc[7:0]  = dbi;
            else if (cwh) cc[15:8] = dbi;

                 if (drl) dbo = dc[7:0];
            else if (drh) dbo = dc[15:8];

            if (cre || (!drl && !drh)) dbo = cc;
            else                       dbo = 16'bz;
        end
    end
endmodule 