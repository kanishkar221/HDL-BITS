module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
    
    always @(posedge clk) begin
        if (load)
            q <= data;   // parallel load
        else if (ena) begin
            case (amount)
                2'b00: q <= q << 1;                        // logical left by 1
                2'b01: q <= q << 8;                        // logical left by 8
                2'b10: q <= $signed(q) >>> 1;              // arithmetic right by 1
                2'b11: q <= $signed(q) >>> 8;              // arithmetic right by 8
            endcase
        end
    end
endmodule
