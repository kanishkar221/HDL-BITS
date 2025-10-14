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
 
    parameter walk_l = 3'b000;
    parameter walk_r = 3'b001;
    parameter fall_l = 3'b010;
    parameter fall_r = 3'b011;
    parameter dig_l = 3'b100;
    parameter dig_r = 3'b101;

    reg [2:0] state, next;

    always @(posedge clk or posedge areset) begin
        if(areset) state <= walk_l;
        else state <= next;
    end

    always @(*) begin
        case(state)
            walk_l : begin
                if(!ground) next = fall_l;
                else begin
                    if(dig) next = dig_l;
                    else begin
                        if(bump_left) next = walk_r;
                        else next = walk_l;
                    end
                end
            end
            walk_r : begin
                if(!ground) next = fall_r;
                else begin
                    if(dig) next = dig_r;
                    else begin
                        if(bump_right) next = walk_l;
                        else next = walk_r;
                    end
                end
            end
            fall_l : next = (ground) ? walk_l : fall_l;
            fall_r : next = (ground) ? walk_r : fall_r;
            dig_l  : next = (ground) ? dig_l : fall_l;
            dig_r  : next = (ground) ? dig_r : fall_r;
        endcase
    end

    assign walk_left = (state == walk_l);
    assign walk_right = (state == walk_r);
    assign aaah = ((state == fall_l) || (state == fall_r));
    assign digging = ((state == dig_l) || (state == dig_r));
    
endmodule
