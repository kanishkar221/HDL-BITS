module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
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
    reg [9:0] count_1000;
    
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
            COUNT: next_state = (count == 0 && count_1000 == 999) ? WAIT:COUNT;
            WAIT: next_state = ack ? S0:WAIT;
        endcase
    end
    
      always @(posedge clk) begin
        case(state)
            SHIFT0: count[3] <= data;
            SHIFT1: count[2] <= data;
            SHIFT2: count[1] <= data;
            SHIFT3: count[0] <= data;
            COUNT: begin
                if(count >= 0) begin
                    if(count_1000<999)
                        count_1000 = count_1000 + 1;
                    else begin
                        count = count - 1;
                        count_1000 = 0;
                    end
                end
            end
            default: count_1000 = 0;
        endcase
    end
    
    assign counting = (state == COUNT);
    assign done = (state == WAIT);

endmodule
