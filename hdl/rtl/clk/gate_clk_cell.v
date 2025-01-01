//======================================================//
//
// Coding: utf-8
// @ File    : gate_clk_cell.v
// @ Version : 1.0
// @ Author  : Jayce Jin
// @ Email   :  
// @ License : (C)Copyright 2018-2024, Jayce
// @ Time    : 2024/12/20 00:15:42
// @ Description :
//
//======================================================//


module GATED_CLK_CELL(
    input  wire          clk_in     ,
    input  wire          clk_scan   ,

    input  wire          glb_en     ,
    input  wire          peri_en    ,
    input  wire          local_en   ,

    input  wire          test_mode  ,
    output wire          clk_out
);


`ifdef FPGA
    assign clk_out = clk_in;
`endif

`ifdef ASIC
    wire clk_en;
    reg  clk_tmp;
    
    assign clk_en = glb_en & peri_en & local_en;
    
    always @(posedge clk_in) begin
        if(clk_en) begin
            clk_tmp <= clk_in;
        end
        else begin
            clk_tmp <= 1'b0;
        end
    end

    assign clk_out = test_mode ? clk_scan : clk_tmp;

`endif

endmodule