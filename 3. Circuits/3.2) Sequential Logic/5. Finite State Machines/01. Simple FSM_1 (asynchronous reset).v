module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0;
	parameter B=1; 
    reg state, next_state;

    always @(*) begin
        case(state)
        A:if(in == 1)
			next_state = A;
          else
            next_state = B;
        B:if(in == 1)
        	next_state = B;
          else
            next_state = A;
        endcase
    end

    always @(posedge clk, posedge areset) begin
    	if(areset)
            state <= B;
        else
            state <= next_state;
    end
    assign out = (state == B);
endmodule
