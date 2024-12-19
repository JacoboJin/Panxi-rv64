//======================================================//
//
// Coding: utf-8
// @ File    : px_level2pulse.v
// @ Version : 1.0
// @ Author  : Jayce Jin
// @ Email   :  
// @ License : (C)Copyright 2018-2024, Jayce
// @ Time    : 2024/12/20 00:41:37
// @ Description : pulse signal for cdc
//                 pulse -> level -> pulse
//
//======================================================//

module PX_LEVEL2PULSE(
    input  wire               clk,
    input  wire               rst_n,

    input  wire               level,
    output wire               pulse
);

    reg  level_sync;
    reg  level_sync_ff;

    PX_SYNC U_PX_SYNC_INST_0(
        .clk        (clk        ),
        .rst_n      (rst_n      ),
        .data_in    (level      ),
        .data_out   (level_sync )
    );

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            level_sync_ff <= 1'b0;
        end
        else begin
            level_sync_ff <= level_sync;
        end
    end

    assign pulse = level_sync & ~level_sync_ff;


endmodule