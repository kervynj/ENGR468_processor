// Mitchell Johnston - ENGR 468 2017
// Project Milestone 1 - ALU
// Note: CMP instruction can be taken care of with subtraction block


module main(r1, r2, r3, opcode, flags);
  parameter len = 32;
  parameter m = 4;
  
  input [3:0] opcode;
  
  input [31:0] r2, r3;
  output [31:0] r1;
  output [3:0] flags;
  
  // output from individual modules
  wire [len-1:0] add_out, sub_out, mult_out, or_out, and_out, xor_out, ls_out, rs_out, rr_out;
  // flag output from individual modules
  wire [3:0] f_add_out, f_sub_out, f_mult_out, f_or_out, f_and_out, f_xor_out, f_ls_out, f_rs_out, f_rr_out;
  
  //instantiate modules with individual output wires
  nbit_adder #(len) add(r2, r3, add_out, f_add_out);
  nbit_subtractor #(len) sub(r2, r3, sub_out, f_sub_out);
  nbit_multiplier #(len) mult(r2, r3, mult_out, f_mult_out);
  nbit_or #(len) orr(r2, r3, or_out, f_or_out);
  nbit_and #(len) andd(r2, r3, and_out, f_and_out);
  nbit_xor #(len) xorr(r2, r3, xor_out, f_xor_out);
  nbit_left_shift #(len, m) ls(r2, ls_out, f_ls_out);
  nbit_right_shift #(len, m) rs(r2, rs_out, f_rs_out);
  nbit_right_rotate #(len, m) rr(r2, rr_out, f_rr_out);
  
  // multiplex data lines from modules including flags
  mux mx(add_out, sub_out, mult_out, or_out, and_out, xor_out, ls_out, rs_out, rr_out, opcode, r1);
  fourbit_mux mxf(f_add_out, f_sub_out, f_mult_out, f_or_out, f_and_out, f_xor_out, f_ls_out, f_rs_out, f_rr_out, opcode, flags);
  
  
endmodule
