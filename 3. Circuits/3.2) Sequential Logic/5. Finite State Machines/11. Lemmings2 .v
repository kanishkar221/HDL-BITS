module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah );
    
	parameter walk_l = 0;
    parameter walk_r = 1;
    parameter fall_l = 2;
    parameter fall_r = 3;
    reg [1:0] state,next_state;
    
    always @ (posedge clk or posedge areset) begin
        if(areset)
            state <= walk_l;
        else 
            state <= next_state;
    end
    
    always @(*) begin
        case(state)
            walk_l : next_state = (ground==0)? fall_l : bump_left? walk_r : walk_l ;
            walk_r: next_state = (ground==0)? fall_r : bump_right? walk_l : walk_r;
            fall_l: next_state = ground ? walk_l : fall_l;
            fall_r: next_state = ground ? walk_r : fall_r;
        endcase
    end

    assign walk_left = (state == walk_l);
    assign walk_right = (state == walk_r);
    assign aaah = (state == fall_l) || (state == fall_r);
endmodule
