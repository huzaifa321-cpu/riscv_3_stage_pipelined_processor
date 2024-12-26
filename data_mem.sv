`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2024 05:24:50 PM
// Design Name: 
// Module Name: data_mem
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



module data_mem (
    input  logic        clk,
    input  logic [31:0] addr,        // Base address from ALU for load/store
    input  logic [31:0] write_data,  // Data to be written to memory for store
    input  logic        mem_read,
    input  logic        mem_write,
    input  logic [ 2:0] func3,       // ALU operation code
    output logic [31:0] rdata        // Data read from memory for load
);

  logic [31:0] data_memory[40];  // 40 rows of 32-bit words
  
   initial
begin
    $readmemb("data_mem.mem", data_memory);
 //   $readmemb("register_file", dut.reg_file_inst.reg_mem);
end

  // Read operation for Load
  always_comb begin
    if (mem_read) begin
      case (func3)
        3'b000:
        rdata = {{24{data_memory[addr][7]}}, data_memory[addr][7:0]};  // LB (Load Byte, sign-extended)
        3'b001:
        rdata = {
          {16{data_memory[addr][15]}}, data_memory[addr][15:0]
        };  // LH (Load Halfword, sign-extended)
        3'b010: rdata = data_memory[addr];  // LW (Load Word)
        3'b100: rdata = {24'b0, data_memory[addr][7:0]};  // LBU (Load Byte Unsigned, zero-extended)
        3'b101:
        rdata = {16'b0, data_memory[addr][15:0]};  // LHU (Load Halfword Unsigned, zero-extended)
        default: rdata = 32'b0;
      endcase
    end
  end

  // Write operation for Store
  always_ff @(posedge clk) begin
    if (mem_write) begin
      data_memory[addr] <= write_data;
    end
  end

endmodule
