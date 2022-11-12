`define RESET_ALL   compose_memory <= 16'h0; \
                  decompose_memory <= 16'h0; \
                       address_out <= 16'bz; \
                          data_out <= 8'bz;

module address_generation_unit
(
    input[15:0] address_in,
    input[7:0] data_in,

    input decompose_write_enable, decompose_read_low, decompose_read_high,
    input compose_read_enable, compose_write_low, compose_write_high,

    input clock, reset,

    output logic[15:0] address_out,
    output logic[7:0] data_out
);
    logic[15:0] compose_memory, decompose_memory;

    initial
    begin
        `RESET_ALL
    end

    always @(posedge clock)
    begin
        if (reset)
        begin
            `RESET_ALL
        end

        else
        begin
            if (decompose_write_enable) decompose_memory = address_in;

                 if (compose_write_low)  compose_memory[7:0]  = data_in;
            else if (compose_write_high) compose_memory[15:8] = data_in;

                 if (decompose_read_low)  data_out = decompose_memory[7:0];
            else if (decompose_read_high) data_out = decompose_memory[15:8];

            if (compose_read_enable || (!decompose_read_low && !decompose_read_high)) 
                data_out = compose_memory;
            else 
                data_out = 16'bz;
        end
    end

endmodule 

`undef RESET_ALL