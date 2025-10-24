module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    
    parameter A = 2'b00;
	  parameter B = 2'b01;

    reg [1:0] state, next_state;
    
    always @(posedge clk or posedge areset) begin
		  if (areset) 
        state <= A;
		  else 
        state <= next_state;
	    end

	  always @(*) begin
		  case (state) 
			  A : begin
				  if (x) begin
					  next_state = B;
					  z = 1;
				  end
				  else begin
					  next_state = A;
					  z = 0;
				  end
			  end
			  B : begin
				  next_state = B;
            z = (x) ? 1'b0 : 1'b1;
			  end
		  endcase
	  end
	endmodule
