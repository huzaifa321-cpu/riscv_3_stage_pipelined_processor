`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2024 03:13:38 PM
// Design Name: 
// Module Name: tb_processor
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

module tb_processor();
    logic clk;
    logic rst;

    processor dut
    (
        .clk(clk),
        .rst(rst)
     );

    // Clock Generator
    initial
    begin
        clk=0;
        forever
        begin
            #5 clk = ~clk;
        end
    end

    //reset generator
    initial
    begin
        rst = 1;
        #10;
        rst = 0;
        #1000;
        $finish;
    end

// add x3, x4, x2
// 0000000 00010 00100 000 00011 0110011
// 00000000001000100000000110110011

// initializing memory


// initial
// begin
//     $readmemb("register_file", dut.reg_file_inst.reg_mem);
// end
//dumping output

endmodule