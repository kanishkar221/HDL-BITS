module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

   	parameter A=0;
    parameter B=1;
  	reg present_state, next_state;

    always @(posedge clk) begin
        if (reset) begin  
            present_state <= B;
        end 
        else begin
            present_state <= next_state;
        end
    end
    
     always @(*) begin
        case (present_state)
            B : next_state = (in == 1) ? B : A;
            A : next_state = (in == 1) ? A : B;
        endcase
    end
    
    assign out = (present_state == B);
endmodule 
