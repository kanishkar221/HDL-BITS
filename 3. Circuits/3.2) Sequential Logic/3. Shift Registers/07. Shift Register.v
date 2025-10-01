module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    reg [2:0] Q;
    always @(posedge clk) begin
        if (!resetn) begin
            Q   <= 3'b000;
            out <= 1'b0;
        end
        else begin
            Q   <= {in, Q[2:1]};  // shift left, new bit = in
            out <= Q[0];          
        end
    end
endmodule
