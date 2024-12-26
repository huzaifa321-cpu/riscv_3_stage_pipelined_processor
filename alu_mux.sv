`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2024 04:18:49 PM
// Design Name: 
// Module Name: alu_mux
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

module alu_mux (
    input logic [31:0] sign_extended_imm,
    input logic imm_en,
    input logic [31:0] rdata2,
    output logic [31:0] opr_b
);

always_comb
begin
        opr_b = imm_en ? sign_extended_imm : rdata2;
end
endmodule