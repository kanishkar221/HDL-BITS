module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    
    parameter S0=0;
    parameter S1=1;
    parameter S2=2;
    parameter S3=3;
    parameter SHIFT0=4;
    parameter SHIFT1=5;
    parameter SHIFT2=6;
    parameter SHIFT3=7;
    parameter COUNT=8;
    parameter WAIT=9;
    
    reg [3:0] state, next_state;
    
    always @(posedge clk) begin
        if(reset)
            state <= S0;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case(state)
            S0: next_state = data ? S1:S0;
            S1: next_state = data ? S2:S0;
            S2: next_state = data ? S2:S3;
            S3: next_state = data ? SHIFT0:S0;
            SHIFT0: next_state = SHIFT1;
            SHIFT1: next_state = SHIFT2;
            SHIFT2: next_state = SHIFT3;
            SHIFT3: next_state = COUNT;
            COUNT: next_state = done_counting ? WAIT:COUNT;
            WAIT: next_state = ack ? S0:WAIT;
        endcase
    end
    
    assign shift_ena = (state == SHIFT0) || (state == SHIFT1) || (state == SHIFT2) || (state == SHIFT3);
    assign counting = (state == COUNT);
    assign done = (state == WAIT);

endmodule
