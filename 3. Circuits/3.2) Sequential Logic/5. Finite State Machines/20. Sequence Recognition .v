module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
   	parameter NONE = 0;
    parameter ONE  = 1;
	  parameter TWO  = 2;
	  parameter THREE= 3;
	  parameter FOUR = 4;
	  parameter FIVE = 5;
	  parameter SIX  = 6;
	  parameter DISC = 7;
	  parameter FLAG = 8;
	  parameter ERR  = 9;

    reg [3:0] state, next_state;

	  always @(*) begin
		  case (state)
            NONE : next_state = (in) ? ONE : NONE;
            ONE : next_state = (in) ? TWO : NONE;
            TWO	: next_state = (in) ? THREE : NONE;
            THREE: next_state = (in) ? FOUR : NONE;
            FOUR : next_state = (in) ? FIVE : NONE;
            FIVE : next_state = (in) ? SIX : DISC;
            SIX	: next_state = (in) ? ERR : FLAG;
			      DISC : next_state = (in) ? ONE : NONE;
			      FLAG : next_state = (in) ? ONE : NONE;
			      ERR : next_state = (in) ? ERR : NONE;
		  endcase
	  end 

	  always @(posedge clk) begin
		  if (reset)
			  state <= NONE;
		  else 
			  state <= next_state;
	  end

	  assign disc = (state == DISC);
	  assign flag = (state == FLAG);
	  assign err = (state == ERR);

endmodule
