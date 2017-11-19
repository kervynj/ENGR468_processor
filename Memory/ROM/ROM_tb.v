`include "ROM.v"

/* ENGR 468 - Milestone #2 Memory
ROM Test Bench module
*/

module rom_tb();

wire [15:0] instruction;

reg oeb;
reg [2:0] pc;
integer i, j;

ROM MUT(oeb, instruction, pc);

initial
begin

  $readmemb("ROM_instructions.txt", MUT.mem);
  
  #5
  
  for(j=0; j<16; j = j+1)
	begin	
		$display("data[%d] = %b", j, MUT.mem[j]);
	end
  
  oeb = 0;
  pc = 3'b000;
  
  for (i=0; i<10; i= i+1)
  begin
    pc = i;
	#5;
	oeb=1;
    #10;
	oeb=0;
  end
  $finish();
end

initial begin
  $monitor("t=%3d, PC=%d, instruction=%b\n", $time, pc, instruction); 
  end
endmodule



  
  
    
  
  
  
