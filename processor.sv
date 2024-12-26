module processor (
    input logic clk,
    input logic rst
);
  // Internal signals
  logic [31:0] pc_out,pc_out_buff1,pc_out_buff2;
  logic [31:0] inst,inst_buff1,inst_buff2;
  logic [ 6:0] opcode;
  logic [31:0] csr_rdata;
  logic [31:0] read_data_from_data_memory;  // Data read from data memory
  logic [31:0] write_data;  // Data to write to data memory
  logic [ 2:0] func3;
  logic [ 6:0] func7;
  logic [ 4:0] rs1;
  logic [ 4:0] rs2;
  logic [ 4:0] rd;
  logic [31:0] alu_result,alu_result_buff2;  // ALU output
  logic [31:0] rdata1;
  logic [31:0] rdata2;
  logic [31:0] opr_b;
  logic [31:0] opr_a;
  logic [31:0] wdata, WD_out_buff2;
  logic [ 3:0] aluop;
  logic [31:0] sign_extended_imm;
  logic rf_en, imm_en, mem_read, mem_write, csr_rd, csr_wr, jump_en, sel_A, reg_wrMW, rd_enMW;
  logic [ 1:0] wb_sel,wb_selMW;  // Write-back select signal from controller
  logic        br_true;
  logic [31:0] next_pc;  // Next PC value for JAL, JALR, and branches
  logic trap, is_mret, epc_taken;
  logic [31:0] epc;
  logic       sel_laddr;
  logic wd2_en;
  logic [31:0] wdata2;



    

  // Program Counter instance
  pc pc_inst (
      .clk   (clk),
      .rst   (rst),
      .pc_in (next_pc),
      .pc_out(pc_out)
  );

  // Instruction Memory Instance
  inst_mem imem (
      .addr(pc_out),
      .data(inst)
  );
  
  
  IF_BUFFER buff1(.clk(clk),
                  .rst(rst),
                  .pc_in(pc_out),
                  .inst_in(inst),
                  .pc_out(pc_out_buff1),
                  .inst_out(inst_buff1));
  
  
  
  

  // Instruction Decoder
  inst_dec inst_instance (
      .inst  (inst_buff1),
      .rs1   (rs1),
      .rs2   (rs2),
      .rd    (rd),
      .opcode(opcode),
      .func3 (func3),
      .func7 (func7)
  );

  // Register File
  reg_file reg_file_inst (
      .rs1(rs1),
      .rs2(rs2),
      .rd(inst_buff2),
      .rf_en(rf_en),
      .clk(clk),
      
       //custom
        .wd2_en(wd2_en),
        .wdata2(alu_result),
      
      .rdata1(rdata1),
      .rdata2(rdata2),
      .wdata(wdata)
  );

  csr csr_inst (
      .csr_rd(csr_rd),
      .csr_wr(csr_wr),
      .inst(inst),
      .pc(next_pc),
      .rdata(csr_rdata),
      .wdata(write_data),
      .rst(rst),
      .clk(clk),
      .is_mret(is_mret),
      .epc(epc),
      .epc_taken(epc_taken)
  );

  // Controller
  controller contr_inst (
      .opcode(opcode),
      .func3(func3),
      .func7(func7),
      .rf_en(rf_en),
      .csr_rd(csr_rd),
      .csr_wr(csr_wr),
      .aluop(aluop),
      .imm_en(imm_en),
      .mem_read(mem_read),
      .mem_write(mem_write),
      .sel_A(sel_A),
      .jump_en(jump_en),
      .wb_sel(wb_sel),  // Write-back select signal
      .sel_laddr(sel_laddr),
      .wd2_en(wd2_en)
      
  );

  // ALU Multiplexer
  alu_mux alu_mux_inst (
      .sign_extended_imm(sign_extended_imm),
      .imm_en(imm_en),
      .rdata2(rdata2),
      .opr_b(opr_b)
  );

  opr_A_mux opr_A_mux_inst (
      .rdata1(rdata1),
      .pc_out(pc_out_buff1),
      .sel_A (sel_A),
      .opr_a (opr_a)
  );

  // ALU
  alu alu_inst (
      .opr_a  (opr_a),
      .opr_b  (opr_b),
      .aluop  (aluop),
      .opr_res(alu_result)  // ALU result
  );
  
  
  
  
  DE_BUFFER buff2(.clk(clk),
                  .rst(rst),
                  .pc_in(pc_out_buff1),
                  .inst_in(inst_buff1),
                  .WD_in(rdata2),
                  .alu_in(alu_result),
                  .wb_sel(wb_sel),
                  .reg_wr(rf_en),
                  .wr_en(mem_write),
                  .rd_en(mem_read),
                  .pc_out(pc_out_buff2),
                  .inst_out(inst_buff2),
                  .WD_out(WD_out_buff2),
                  .alu_out(alu_result_buff2),
                  .wb_selMW(wb_selMW),
                  .reg_wrMW(reg_wrMW),
                  .rd_enMW(rd_enMW)
                  );
  
  
  
  
  
  
  

  // Immediate Generator
  imm_gen imm_gen_inst (
      .inst(inst_buff1),
      .sign_extended_imm(sign_extended_imm),
      .func3(func3),
      .opcode(opcode)
  );

  // Data Memory Instance
  data_mem data_mem_inst (
      .clk       (clk),                        // Clock signal for memory
      .addr      (alu_result_buff2),                 // Address for load/store (from ALU result)
      .write_data(WD_out_buff2),                     // Data to write to memory (from rdata2)
      .mem_read  (rd_enMW),                   // Memory read enable
      .mem_write (reg_wrMW),                  // Memory write enable
      .func3     (func3),
      .rdata     (read_data_from_data_memory)  // Data read from memory
  );

  // Branch Condition Generator
  branch_cond_gen branch_cond_gen_inst (
      .func3  (func3),
      .rdata1 (rdata1),
      .rdata2 (rdata2),
      .br_true(br_true)
  );

  writeback_mux writeback_mux_inst (
      .read_data_from_data_memory(read_data_from_data_memory),
      .alu_result(alu_result),
      .csr_rdata(csr_rdata),
      .wb_sel(wb_selMW),
      .pc(pc_out_buff2),
      .wdata(wdata)
  );

  pc_mux pc_mux_inst (
      .pc_out(pc_out),
      .alu_result(alu_result_buff2),
      .br_true(br_true),
      .jump_en(jump_en),
      .epc_taken(epc_taken),
      .epc(epc),
      .next_pc(next_pc)
  );

endmodule