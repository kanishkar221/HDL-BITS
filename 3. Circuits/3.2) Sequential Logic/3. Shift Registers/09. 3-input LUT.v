module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
    
    reg [7:0] Q;
    always @(posedge clk) begin  //shift register
        if (enable)
            Q <= {Q[6:0], S};
    end
    always @(*) begin
        Z = Q[{A,B,C}];   // 3-8 mux directly index with select lines
    end
endmodule

