module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=0;
	parameter B=1;
	parameter C=2;
	parameter D=3;
	always @(*)
        case(state)
            A:begin
            	if(in)
                	next_state = B;
            	else
                	next_state = A;
        	end
            B:begin
            	if(in)
                	next_state = B;
            	else
                	next_state = C;
        	end
            C:begin
            	if(in)
                	next_state = D;
            	else
                	next_state = A;
        	end
            D:begin
            	if(in)
                	next_state = B;
            	else
                	next_state = C;
        	end
        endcase
        
    assign out = (state == D)?1:0;

endmodule
