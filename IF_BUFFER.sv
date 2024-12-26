`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/12/2024 10:22:50 PM
// Design Name: 
// Module Name: IF_BUFFER
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


module IF_BUFFER(
        input logic clk,
        input logic rst,
        input reg [31:0] pc_in,
        output reg [31:0] pc_out,
        input reg [31:0] inst_in,
        output reg[31:0] inst_out

    );
    
    always_ff @(posedge clk) begin
        if (rst) begin
            pc_out <= 0;
            inst_out <= 0;
        end else begin
            pc_out <= pc_in;
            inst_out <= inst_in;
        end
    end
 
    
endmodule
