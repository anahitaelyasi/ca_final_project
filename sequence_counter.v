module sequence_counter(
    //The inputs important for sequence counter
    input E, clk, rst,
    //At first, T is set to 0 (just a default thing)
    output reg [1:0] T
);

    reg E_prev;
    
    always @(posedge clk) begin

        //Everything is being reset to 0, even T 
        if (rst == 1) begin
            T[1:0] <= 2'b00;
            E_prev <= 1'b0;
        end 
        else begin
            if (E_prev == 1'b1 && E == 1'b0) begin
                T[1:0] <= 2'b00;              // restart cycle
            end
            //Stop where you are and show me the output at this moment
            //So T has to freeze
            else if (E == 1'b1) begin
                T <= T;    
            end
            //In normal operations, just keep increasing and wraping around T
            else begin
                if (T[1:0] == 2'b11) begin 
                //If you reached 3, start fresh from 0
                T[1:0] <= 2'b00;
                end
                else begin
                    //Otherwise, just keep increasing T on each clk
                    T[1:0] <= T[1:0] + 2'b01 ;
                end       
            end

            E_prev <= E;
        end
        
    end

endmodule