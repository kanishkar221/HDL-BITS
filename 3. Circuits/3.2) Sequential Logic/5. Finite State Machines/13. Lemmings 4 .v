module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter left = 0;
    parameter right = 1;
    parameter fall_l = 2;
    parameter fall_r = 3;
    parameter dig_l = 4;
    parameter dig_r = 5;
    parameter splatter = 6;
    
    reg [2:0] state,next_state;
    reg [7:0] count;
    
    always @ (posedge clk or posedge areset) begin
        if(areset) begin
            state <= left;
            count <= 0;
        end
        else if ( (state == fall_l) || (state == fall_r) ) begin
            state <= next_state;
            count <= count+1;
        end
        else begin
            state <= next_state;
            count <= 0;
        end
    end
    
    always @(*) begin
        case(state)
            left : next_state = (ground==0)? fall_l : (dig)? dig_l : bump_left? right : left ;
            right: next_state = (ground==0)? fall_r : (dig)? dig_r : bump_right? left : right;
            fall_l: next_state = (ground==0)? fall_l : (count>19)? splatter : left ;
            fall_r: next_state = (ground==0)? fall_r : (count>19)? splatter : right ;
            dig_l: next_state = ground ? dig_l : fall_l;
            dig_r: next_state = ground ? dig_r : fall_r;
            splatter: next_state = splatter;
        endcase
    end

    assign walk_left = (state == left);
    assign walk_right = (state == right);
    assign aaah = (state == fall_l) || (state == fall_r);
    assign digging = (state == dig_l) || (state == dig_r);
endmodule
