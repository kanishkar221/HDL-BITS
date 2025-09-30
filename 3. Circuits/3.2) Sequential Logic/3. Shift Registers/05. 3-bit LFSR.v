module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
	reg [2:0] Q;
    wire clk = KEY[0];
    wire L   = KEY[1];

    assign LEDR = Q;

    always @(posedge clk) begin
        if (L)
            Q <= SW;                          
        else
            Q <= {Q[1] ^ Q[2], Q[0], Q[2]};   
    end
endmodule
