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
    input  wire          CLK_IN ,
    input  wire          EN     ,
    input  wire          TE     ,
    output wire          CLK_OUT
);


`ifdef FPGA
    assign CLK_OUT = CLK_IN;
`endif

`ifdef ASIC

`endif

endmodule