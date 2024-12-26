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

module inst_mem (
    input  logic [31:0] addr,
    output logic [31:0] data

);
  logic [31:0] mem[100];  //instruction memory of row width = 32 bits and total = 400 bytes
    
   initial begin
    $readmemb("instruction_memory.mem", mem);
end
 
  //every read operation is asynchronous
  //every write operation is synchronous

  //word addressable -> add 1
  //byte addressable -> add 4
  always_comb begin
    //doing right shift as pc is adding 4
    //to divide with 4, do 2 right shifts (make bytes to word)
    data = mem[addr[31:2]];
   
  end
endmodule