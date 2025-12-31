module datapath(
    input E, rst, clk,
    input LD_R1, LD_R2, LD_R3, LD_DR1, LD_DR2, LD_AC, LD_outr,
    input [2:0] sel_A, // Who can drive Bus 1 : R1 (000), R2 (001), R3 (010), AC (011), outr (100)
    input sel_B,// Who can drive Bus 2 : R2
    output reg [3:0] outr 
);

    reg [3:0] R1, R2, R3, AC, DR1, DR2;
    wire [3:0] B1, B2;
    wire [3:0] ALU_out = DR1 + DR2 ;

    assign B1 = (sel_A == 3'b000) ? R1 :
            (sel_A == 3'b001) ? R2 :
            (sel_A == 3'b010) ? R3 :
            (sel_A == 3'b011) ? AC :
            (sel_A == 3'b100) ? outr : 4'b0000 ;
    
    assign B2 = R2 ;


    always @(posedge clk) begin

        if (rst) begin
            R1 <= 4'b0000;
            R2 <= 4'b0000;
            R3 <= 4'b0000;
            DR1 <= 4'b0000;
            DR2 <= 4'b0000;
            AC <= 4'b0000;
            outr <= 4'b0000;
        end 
        if (E) begin
            outr[3:0] <= B1[3:0];
        end 
        else begin 
            // T0
            if (LD_DR1 == 1 && LD_DR2 == 1) begin
                DR1[3:0] <= B1[3:0]; 
                DR2[3:0] <= B2[3:0];
            end 

            // T1
            if (LD_R1 == 1 && LD_AC == 1) begin
                AC[3:0] <= ALU_out[3:0]; 

                R1[3:0] <= B1[3:0];
            end 
            
            // T2
            if (LD_R3 == 1) begin
                R3[3:0] <= B1[3:0];
            end 

            // T3
            if (LD_R2 == 1) begin
                R2[3:0] <= B1[3:0];
            end
        end 
    end

endmodule 