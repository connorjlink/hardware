`include "acu/acu.v"
`include "adu/adu.v"
`include "alu/alu.v"
`include "ecu/ecu.v"
`include "lsu/lsu.v"
`include "rf/rf.v"

module cpu
(
    input clk, rst
);

acu acu_inst
(

);

adu adu_inst
(

);

alu alu_inst
(
    
);

ecu ecu_inst
(

);

lsu lsu_inst
(

);

rf rf_inst
(

);

endmodule