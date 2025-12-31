module main(
    input E,
    input clk,
    input rst,
    output [1:0] T,
    output LD_R1, LD_R2, LD_R3,
    output LD_DR1, LD_DR2, LD_AC, LD_outr,
    output [2:0] sel_A,
    output sel_B,
    // output [1:0] ALU,
    output [3:0] outr,
    output sel_DR1, sel_DR2
);

reg [1:0] T_reg;


sequence_counter sequence_inst(
    .E (E), .clk (clk), .rst (rst), .T (T)
); 
cu cu_inst(
    .E (E), .T (T),
    .sel_A (sel_A), 
    .sel_B (sel_B),
    .LD_R1 (LD_R1), .LD_R2 (LD_R2), .LD_R3 (LD_R3), .LD_DR1 (LD_DR1), .LD_DR2 (LD_DR2), .LD_AC (LD_AC), .LD_outr (LD_outr),
    // .ALU (ALU),
    .sel_DR1 (sel_DR1), 
    .sel_DR2 (sel_DR2) 
); 
datapath dp_inst(
    .E (E), .rst (rst), .clk (clk),
    .LD_R1 (LD_R1), .LD_R2 (LD_R2), .LD_R3 (LD_R3), .LD_DR1 (LD_DR1), .LD_DR2 (LD_DR2), .LD_AC (LD_AC), .LD_outr (LD_outr),
    .sel_A (sel_A), .sel_B (sel_B), .outr (outr)
);

endmodule;