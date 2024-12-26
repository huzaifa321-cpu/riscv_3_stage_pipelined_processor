`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2024 04:25:47 PM
// Design Name: 
// Module Name: pc_mux
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


module pc_mux (
    input logic [31:0] pc_out,
    input logic [31:0] alu_result,
    input logic br_true,
    input logic jump_en,
    input logic epc_taken,
    input logic [31:0] epc,
    output logic [31:0] next_pc
);

  always_comb begin
    if (br_true || jump_en) next_pc = alu_result;
    else if (epc_taken) next_pc = epc;
    else next_pc = pc_out + 32'd4;
  end

endmodule