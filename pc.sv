`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2024 07:33:57 PM
// Design Name: 
// Module Name: inst_mem
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

module pc (

    //in RISC-V XLEN donates the bits of CPU like 32bit or 64bit. Now XLEN=32bits
    input logic clk,
    input logic rst,
    input logic [31:0] pc_in,
    output logic [31:0] pc_out
);

  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      pc_out <= 0;
    end else begin
      pc_out <= pc_in;
    end
  end
endmodule