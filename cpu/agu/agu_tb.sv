`include "agu.sv"

module agu_tb;
    logic[15:0] address_in = 0;
    logic[7:0] data_in = 0;

    logic decompose_write_enable = 0, decompose_read_low = 0, decompose_read_high = 0,
          compose_read_enable = 0, compose_write_low = 0, compose_write_high = 0;

    logic clock = 0, reset = 0;

    wire[15:0] address_out;
    wire[7:0] data_out;

    always #1 clock = !clock;

    initial $dumpfile("agu_tb.vcd");
    initial $dumpvars(0, agu_tb);

    agu agu_inst
    (
        .address_in(address_in),
        .data_in(data_in),
        .decompose_write_enable(decompose_write_enable),
        .decompose_read_low(decompose_read_low),
        .decompose_read_high(decompose_read_high),
        .compose_read_enable(compose_read_enable),
        .compose_write_low(compose_write_low),
        .compose_write_high(compose_write_high),
        .clock(clock),
        .reset(reset),
        .address_out(address_out),
        .data_out(data_out)
    );

    initial
    begin
        #5 data_in = 100; compose_write_low = 1; compose_read_enable = 1;
        #5 data_in = 64; compose_write_low = 0;  compose_write_high = 1;
        #5 compose_write_high = 0;
        #5 compose_read_enable = 0;
        #5 compose_read_enable = 1;
        #5 compose_read_enable = 0;
        #2
        #5 data_in = 32; compose_write_high = 1;
        #5 compose_write_high = 0;
        #5 compose_read_enable = 1;
        #5 reset = 1;
        #10
        #5 data_in = 0;
        #5 address_in = 31246; decompose_write_enable = 1;
        #5 decompose_write_enable = 0; decompose_read_low = 1;
        #5 decompose_read_low = 0; decompose_read_high = 1;
        #1
        #5 address_in = 20000; decompose_read_high = 0; decompose_write_enable = 1;
        #5
        #5 decompose_write_enable = 0; decompose_read_high = 1;
        #5
        #5 decompose_read_high = 0; decompose_read_low = 1;
        #5 reset = 1;
        #10 $finish
    end
endmodule