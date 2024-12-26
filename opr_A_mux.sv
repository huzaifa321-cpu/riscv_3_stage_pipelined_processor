`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2024 04:26:53 PM
// Design Name: 
// Module Name: opr_A_mux
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


module opr_A_mux (
    input logic [31:0] pc_out,
    input logic sel_A,
    input logic [31:0] rdata1,
    output logic [31:0] opr_a
);

  always_comb begin
    opr_a = sel_A ? pc_out : rdata1;
  end


endmodule