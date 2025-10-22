module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
    
    parameter BYTE1 = 2'b00;
    parameter BYTE2 = 2'b01;
    parameter BYTE3 = 2'b10;
    parameter DONE  = 2'b11;

    reg [1:0] state, next_state;
    reg [23:0] data;
    
     always @(*) begin
        case(state) 
            BYTE1 : next_state = in[3] ? BYTE2 : BYTE1;
            BYTE2 : next_state = BYTE3;
            BYTE3 : next_state = DONE;
            DONE : next_state = in[3] ? BYTE2 : BYTE1;
            default: next_state = BYTE1;
        endcase
    end
    
    always @(posedge clk) begin
        if(reset)
            state <= BYTE1;
        else 
            state <= next_state;
    end
    
     always @(posedge clk) begin
    	if (reset) data <= 24'b0;
    	else data <= {data[15:8], data[7:0], in};
    end
    
    // Output logic
    assign done = (state == DONE);
    assign out_bytes = (done) ? data : 23'b0;

endmodule
