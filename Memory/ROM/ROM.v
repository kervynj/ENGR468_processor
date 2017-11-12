/* ENGR 468 - Milestone #2 Memory
ROM module
*/

module ROM(oeb, inst, pc);
  parameter Awidth = 8, Dwidth = 16;
  
  input oeb;
  output [Dwidth-1:0] inst; //read only output instruction set
  input [Awidth-1:0] pc;
  localparam Length = (1 << Awidth);
  reg [Dwidth-1:0] mem[0:Length-1]; // initialize 8x16 memory address 
  assign inst = (oeb ==1'b0) ? mem[pc]: 'bz;
  
endmodule