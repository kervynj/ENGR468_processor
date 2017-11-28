module RAM(rw, chip_enable, enable, select1, select2, dataIn, source1, source2, opcode, dest);

  input rw, chip_enable;
  input[2:0] enable, select1, select2, dest;
  input[3:0] opcode;
  input [15:0] dataIn;
  
  reg [15:0] mem[0:7]; // memory array
  output reg [15:0] source1, source2;
  
  
  always @(*)
  begin
	if (chip_enable)
		if (rw)
		begin
			source1 = mem[select1];
			source2 = mem[select2];
		end
		else
			mem[enable] = dataIn;
	else
	begin
		source1 = 16'hzzzz;
		source2 = 16'hzzzz;
	end
   end
		
endmodule