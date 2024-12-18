//======================================================//
//
// Coding: utf-8
// @ File    : px_sync.v
// @ Version : 1.0
// @ Author  : Jayce Jin
// @ Email   :  
// @ License : (C)Copyright 2018-2024, Jayce
// @ Time    : 2024/12/19 00:05:11
// @ Description : DFF Synchronizer for clock domain cross
//
//======================================================//

module px_sync #(
    parameter DATA_WIDTH = 1,
    parameter SYNC_STAGE = 3
)(
    input  wire                     clk     ,
    input  wire                     rst_n   ,
    input  wire [DATA_WIDTH-1:0]    data_in ,
    output reg  [DATA_WIDTH-1:0]    data_out
);
    reg  [DATA_WIDTH-1:0]  sync_ff [SYNC_STAGE-1:0];

    genvar i;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            sync_ff[0] <= {DATA_WIDTH{1'b0}};
        end
        else begin
            sync_ff[0] <= data_in;
        end
    end

    generate
        for(i=1; i<SYNC_STAGE; i=i+1) begin: SYNC_FLOP
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    sync_ff[i] <= {DATA_WIDTH{1'b0}};
                end
                else begin
                    sync_ff[i] <= sync_ff[i-1];
                end
            end
        end
    endgenerate

    assign data_out = sync_ff[SYNC_STAGE-1];

endmodule