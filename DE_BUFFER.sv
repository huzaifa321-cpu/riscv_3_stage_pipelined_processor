`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2024 10:23:26 PM
// Design Name: 
// Module Name: DE_BUFFER
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DE_BUFFER(
        input logic clk,
        input logic rst,
        input reg [31:0] pc_in,
        output reg [31:0] pc_out,
        input reg [31:0] inst_in,
        output reg[31:0] inst_out,
        input reg [31:0] WD_in,
        output reg[31:0] WD_out,
        input reg [31:0] alu_in,
        output reg[31:0] alu_out,
        input reg [1:0] wb_sel,
        output reg [1:0] wb_selMW,
        input reg reg_wr,
        output reg reg_wrMW,
        input reg wr_en,
        output reg wr_enMW,
        input reg rd_en,
        output reg rd_enMW
        
    );
    always_ff @(posedge clk) begin
        if (rst) begin
            pc_out <= 0;
            inst_out <= 0;
            alu_out <= 0;
            WD_out <= 0;
            wb_selMW <= 0;
            reg_wrMW <= 0;
            wr_enMW <= 0;
            rd_enMW <= 0;
        end else begin
            pc_out <= pc_in;
            inst_out <= inst_in;
            alu_out <= alu_in;
            WD_out <= WD_in;
            wb_selMW <= wb_sel;
            reg_wrMW <= reg_wr;
            wr_enMW <= wr_en;
            rd_enMW <= rd_en;
        end
    end
    
endmodule
