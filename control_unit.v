module cu(
    input E, clk, rst,
);

    wire [5:0] sel_A;
    wire [1:0] sel_B;
    //Load data to bus (drive the bus)
    wire LD_R1, LD_R2, LD_R3, LD_AC, LD_outr;
    // wire [1:0] sel1, sel2, sel3, sel_AC, sel_DR1, sel_DR2, sel_outr;

    sequence_counter sq_instance(.E (E), .clk (clk), .rst (), .T[1:0] (T[1:0]));

    always @(posedge clk) begin
        if (E == 1) begin
            LD_R3 = 1;
            sel_A[5:0] = 6'b000010; 
        end
        else begin
            if (T[3:0] == 4'b000) begin
                LD_R3 = 1;
            end
            if (T[3:0] == 4'b001) begin
              
            end
            if (T[3:0] == 4'b010) begin
              
            end
            if (T[3:0] == 4'b011) begin
              
            end
        end
    end
endmodule