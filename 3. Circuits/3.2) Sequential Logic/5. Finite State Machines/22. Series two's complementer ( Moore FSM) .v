module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    parameter S0=2'b00;
    parameter S1=2'b01;
    parameter S2=2'b10;
    
    reg [1:0] state,next_state;
    
    always @(posedge clk or posedge areset)
        begin
            if (areset)
            state <= S0;
    		else
            state <= next_state;
    	end
    
    always @(*)
        begin
            case (state)
                S0: begin
                    if (x) next_state = S1;
                    else   next_state = S0;
                end
                S1: begin
                    if (x) next_state = S2;
                    else   next_state = S1;
                end
                S2: begin
                    if (x) next_state = S2;
                    else   next_state = S1;
                end
                default : next_state = S0;
            endcase
        end
    
    assign z = (state == S1);
    
endmodule
