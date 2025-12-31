`timescale 1ns/1ps

module tb_main;

    // testbench signals
    reg clk;
    reg rst;
    reg E;

    // outputs from DUT
    wire [1:0] T;
    wire LD_R1, LD_R2, LD_R3;
    wire LD_DR1, LD_DR2, LD_AC, LD_outr;
    wire [2:0] sel_A;
    wire sel_B;
    // wire [1:0] ALU;
    wire [3:0] outr;
    wire sel_DR1, sel_DR2;

    // instantiate DUT
    main uut (
        .E(E),
        .clk(clk),
        .rst(rst),
        .T(T),
        .LD_R1(LD_R1), .LD_R2(LD_R2), .LD_R3(LD_R3),
        .LD_DR1(LD_DR1), .LD_DR2(LD_DR2), .LD_AC(LD_AC), .LD_outr(LD_outr),
        .sel_A(sel_A),
        .sel_B(sel_B),
        // .ALU(ALU),
        .outr(outr),
        .sel_DR1(sel_DR1), .sel_DR2(sel_DR2)
    );


    // clock generation: 10ns period
    always #5 clk = ~clk;

    initial begin
        // dump for GTKWave
        $dumpfile("main_wave.vcd");
        $dumpvars(0, tb_main);

        // init
        clk = 0;
        rst = 1;
        E   = 0;

        // Wait for 20ns, then do : rst = 0
        #20;
        rst = 0;

        uut.dp_inst.R1 = 4'd3;
        uut.dp_inst.R2 = 4'd5;

        #70;

        // freeze
        E = 1;
        #40;

        // restart
        E = 0;
        #60;

        $finish;
    end

endmodule
