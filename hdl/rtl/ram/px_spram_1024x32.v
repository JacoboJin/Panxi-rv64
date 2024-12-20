//======================================================//
//
// Coding: utf-8
// @ File    : px_spram_1024x32.v
// @ Version : 1.0
// @ Author  : Jayce Jin
// @ Email   :  
// @ License : (C)Copyright 2018-2024, Jayce
// @ Time    : 2024/12/20 23:54:21
// @ Description : 
//
//======================================================//


module PX_SPRAM_1024x32 #(
    parameter DATA_WIDTH = 32 ,
    parameter ADDR_WIDTH = 10 ,
    parameter WRAP_SIZE  = 8  ,
    // ! do not modify it
    parameter WARP_NUM   = DATA_WIDTH/WRAP_SIZE;
)(
    input  wire                     CLK   ,
    input  wire                     GWEN  ,
    input  wire                     CEN   ,
    input  wire  [ADDR_WIDTH-1:0]   ADDR  ,
    input  wire  [DATA_WIDTH-1:0]   D     ,
    input  wire  [WARP_NUM-1:0]     WSTRB ,

    output reg   [DATA_WIDTH-1:0]   Q
);

//========= PARAMETER DEFINE ==========//
    localparam WARP_NUM = DATA_WIDTH/WRAP_SIZE;

//========= SIGNAL DEFINE  ============//
    wire [WRAP_SIZE-1:0]    ram_din    [WARP_NUM-1:0];
    wire [WRAP_SIZE-1:0]    ram_dout   [WARP_NUM-1:0];
    wire                    ram_wen    [WARP_NUM-1:0];

    wire [ADDR_WIDTH-1:0]   ram_addr;
    reg  [ADDR_WIDTH-1:0]   addr_latch;
//========= BEHAVIOR DEFINE ===========//

    always @(posedge CLK) begin
        if(!CEN) begin
            addr_latch <= ADDR;
        end
    end

    assign ram_addr = CEN ? addr_latch : ADDR;


    generate
        integer i;
        for(i=0; i<WARP_NUM; i=i+1) begin: WEN_SPLIT
            assign ram_wen[i] = (!GWEN) && (!CEN) && (WSTRB[i]);
        end
    endgenerate

    generate
        integer i;
        for(i=0; i<WARP_NUM; i=i+1) begin: DATA_IN_SPLIT
            assign ram_din[i] = D[i*WRAP_SIZE +: WRAP_SIZE];
        end
    endgenerate

    generate
        integer i;
        for(i=0; i<WARP_NUM; i=i+1) begin: DATA_OUT_SPLIT
            assign Q[i*WRAP_SIZE +: WRAP_SIZE] = ram_dout[i];
        end
    endgenerate

    generate
        integer i;
        for(i=0; i<WARP_NUM; i=i+1) begin: RAM_INST
            PX_RAM #(
                .DATA_WIDTH (WRAP_SIZE  ),
                .ADDR_WIDTH (ADDR_WIDTH )
            ) U_PX_RAM_INST(
                .clk        (CLK        ),
                .wen        (ram_wen[i] ),
                .addr       (ram_addr   ),
                .data_in    (ram_din[i] ),
                .data_out   (ram_dout[i])
            );
        end
    endgenerate


endmodule