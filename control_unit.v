module cu(
    input E,
    input [1:0] T,
    output reg [2:0] sel_A, // Who can drive Bus 1 : R1 (000), R2 (001), R3 (010), AC (011), outr (100)
    output reg sel_B,// Who can drive Bus 2 : R2
    //Decide which registers get data from a bus 
    output reg LD_R1, LD_R2, LD_R3, LD_DR1, LD_DR2, LD_AC, LD_outr,
    // output reg [1:0] ALU,
    output reg sel_DR1, sel_DR2
);


    always @(*) begin

        // default values
        sel_A   = 3'b000;
        sel_B   = 1'b0;
        LD_R1   = 1'b0;
        LD_R2   = 1'b0;
        LD_R3   = 1'b0;
        LD_DR1  = 1'b0;
        LD_DR2  = 1'b0;
        LD_AC   = 1'b0;
        LD_outr = 1'b0;
        

        if (E == 1) begin

            sel_A[2:0] = 3'b010; // R3
            LD_outr = 1;

            sel_A   = 0;
            sel_B   = 0;
            LD_R1   = 0;
            LD_R2   = 0;
            LD_R3   = 0;
            LD_DR1  = 0;
            LD_DR2  = 0;
            LD_AC   = 0;

        end 
        else begin
            // T0
            if (T[1:0] == 2'b00) begin
                sel_A[2:0] = 3'b000; // R1
                sel_B = 1; // R2
                LD_DR1 = 1; 
                LD_DR2 = 1;
            end
            // T1
            else if (T[1:0] == 2'b01) begin
                sel_A[2:0] = 3'b001; // R2
                LD_R1 = 1; 
                LD_AC = 1;
            end 
            // T2
            else if (T[1:0] == 2'b10) begin
                sel_A[2:0] = 3'b011; // AC
                LD_R3 = 1;
            end
            // T3 
            else if (T[1:0] == 2'b11) begin
                sel_A[2:0] = 3'b010; // R3
                LD_R2 = 1;
            end 
        end 
    end 
endmodule 