// Test benche for ALU
// to test:
// 1. run simulation 
// 2. simulate -> run -> run all
// 3. Stop sim
// 4. shift F to focus on waveform

module alu_main_tb();
  
parameter len = 32;
parameter shift = 2;

wire [len-1:0] response;
wire [3:0] flgs;
reg [3:0] opcd;
reg [len-1:0] a,b;
reg clk;

initial
begin
  clk = 0;
  opcd = 0; //ADD
  a = 2;
  b = 2; //expecting 0100, C =0, V = 0;
  #5
  a = 32'hffffffff;
  b = 32'h10000000; //expecting ffffffff, C=1, V=1, N=1
  #5
  opcd = 1; // Sub
  a = 7;
  b = 6; // expecting 1110
  #5
  opcd = 2; // multiply
  a = 3;
  b = 2; // expecting 0110
  #5
  opcd = 3; // OR
  a = 7;
  b = 3; // expecting 0111
  #5
  opcd = 4; // AND
  a = 4;
  b = 14; // expecting 0100
  #5
  opcd = 5; // XOR
  a = 15;
  b = 6; // expecting 1001
  #5
  opcd = 6; // left shift by 2
  a = 3; //expected 0110, carry = 1
  #5
  opcd = 7; // right  shift by 2
  a = 3; //expected 0001, carry = 1
  #5
  opcd = 8; // rotate right by 2
  a  = 2; // expected 1000, carry 0
    
end

main  #(len, shift) alu_DUT(response, a, b, opcd, flgs);
always
#5 clk = !clk;

always
#5 clk = !clk;

endmodule




