//======================================================//
//
// Coding: utf-8
// @ File    : px_ram.v
// @ Version : 1.0
// @ Author  : Jayce Jin
// @ Email   :  
// @ License : (C)Copyright 2018-2024, Jayce
// @ Time    : 2024/12/20 23:43:18
// @ Description : 
//
//======================================================//

module PX_RAM #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
)(
    input  wire                     clk      ,
    input  wire                     wen      ,
    input  wire  [ADDR_WIDTH-1:0]   addr     ,
    input  wire  [DATA_WIDTH-1:0]   data_in  ,

    // !!! do not modify it
    // mem output type must be reg 
    output reg   [DATA_WIDTH-1:0]   data_out
);

//========= PARAMETER DEFINE ==========//
    localparam MEM_DEPTH = 2**(ADDR_WIDTH);

//========= SIGNAL DEFINE ==========//
    reg  [DATA_WIDTH-1:0] mem [MEM_DEPTH-1:0];

//========= BEHAVIOR DEFINE ==========//

    always @(posedge clk) begin
        if(wen) begin
            mem[addr] <= data_in;
            //
            data_out <= data_in;
        end
        else begin
            data_out <= mem[addr];
        end
    end
    


endmodule