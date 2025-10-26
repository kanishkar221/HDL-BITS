module top_module(
    input clk,
    input areset,
	input  predict_valid,
    input  [6:0] predict_pc,
    output reg predict_taken,
    output reg [6:0] predict_history,

    input train_valid,
    input train_taken,
    input train_mispredicted,
    input [6:0] train_history,
    input [6:0] train_pc
);
    parameter SNT = 2'b00;
    parameter WNT = 2'b01;
    parameter WT = 2'b10;
    parameter ST = 2'b11;
    
    reg [6:0] global_history;
    reg [1:0] PHT [127:0];
    wire [6:0] predict_index;
    wire [6:0] train_index;
    
    assign predict_index = predict_pc^global_history;
    assign train_index = train_pc^train_history;
    
    always @(*) begin
        if(predict_valid)begin
            predict_history = global_history;
            predict_taken = (PHT[predict_index] >= WT);
        end
        else begin
            predict_history = 7'd0;
            predict_taken = 1'b0;
        end              
    end
    
    integer i;
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 0;
            for (i = 0; i < 128; i++)
                PHT[i] = WNT;
        end
        else begin
            if(train_valid) begin
                case(PHT[train_index])
                    SNT: PHT[train_index] <= train_taken ? WNT : SNT;
                    WNT: PHT[train_index] <= train_taken ? WT : SNT;
                    WT:  PHT[train_index] <= train_taken ? ST : WNT;
                    ST:  PHT[train_index] <= train_taken ? ST : WT;
                endcase
            end
            if(train_valid && train_mispredicted)
                global_history <= {train_history[5:0],train_taken};
            else if (predict_valid)
                global_history <= {global_history[5:0],predict_taken};
        end
    end

endmodule
