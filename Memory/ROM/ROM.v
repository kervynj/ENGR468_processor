/* ENGR 468 - Milestone #2 Memory
ROM module
*/

module ROM(oeb, inst, pc);
  parameter Awidth = 4, Dwidth = 16;
  
  input oeb;
  reg rw;
  input[2:0] pc;
  //wire [Dwidth-1:0] next_inst; //read only output instruction set
  output reg[Dwidth-1:0] inst; //read only output instruction set

  localparam Length = (1 << Awidth);
  reg [Dwidth-1:0] mem[0:Length-1]; // initialize 8x16 memory address 
  
  
  always@(posedge oeb)
  begin
  
	rw = oeb;
	
	if (rw == 1)
		inst = mem[pc];	//pass instruction set through only on 'fetch' cycle
  end
  
  
endmodule