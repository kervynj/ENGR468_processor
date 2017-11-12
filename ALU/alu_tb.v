module alu_tb();

wire [3:0] C;
wire n, c, z, v;
reg [3:0] A,B;

initial
  begin
  A = 4'b0110;
  B = 4'b0110;
end

  
  //nbit_ DUT(A,B,C,n,c,z,v);

endmodule    
