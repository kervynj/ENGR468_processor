`include "ROM.v"

/* ENGR 468 - Milestone #2 Memory
ROM Test Bench module
*/

module rom_tb();

wire [15:0] instruction;

reg oeb;
reg [7:0] pc;
integer i;

ROM MUT(oeb, instruction, pc);

initial
begin
  $readmemb("ROM_instructions.txt", MUT.mem);
  
  oeb = 0;
  pc = 8'b00000000;
  
  for (i=0; i<10; i= i+1)
  begin
    pc = i;
    #10;
  end
  $finish();
end

initial begin
  $monitor("t=%3d, PC=%d, instruction=%b\n", $time, pc, instruction); 
  end
endmodule



  
  
    
  
  
  
