//======================================================//
//
// Coding: utf-8
// @ File    : px_ram_sp.v
// @ Version : 1.0
// @ Author  : Jayce Jin
// @ Email   :  
// @ License : (C)Copyright 2018-2024, Jayce
// @ Time    : 2024/12/19 23:50:31
// @ Description :
//
//======================================================//

module PX_RAM_SP #(
    parameter   DATA_WIDTH  =   8,
    parameter   ADDR_WIDTH  =   1
)(
    input  wire                     clk      ,
    input  wire                     rst_n    ,
    
    input  wire                     ena      ,
    input  wire                     wen      ,
    input  wire  [ADDR_WIDTH-1:0]   addr     ,
    input  wire  [DATA_WIDTH-1:0]   data_in  ,

    output wire  [DATA_WIDTH-1:0]   data_out
);

    localparam DATA_DEPTH = 2**ADDR_WIDTH;
    reg  [DATA_WIDTH-1:0]   spram   [DATA_DEPTH-1:0];

    // reg with no reset 
    always @(posedge clk) begin
        if(ena && wen) begin
            spram[addr] <= data_in;
        end
    end


    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            data_out <= {DATA_WIDTH{1'b0}};
        end
        else if(ena && (!wen)) begin
            data_out <= spram[addr];
        end
    end

endmodule