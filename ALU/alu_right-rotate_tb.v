module alu_rr_tb();
  
parameter len = 8;
parameter shift = 3;

wire [len-1:0] response;
wire n, c, z, v;
reg [len-1:0] a;
reg clk;

initial
begin
  clk = 0;
  a = 11111000;
  #5
  a = 00110011;
  #5
  a = 00011110;
end

nbit_right_rotate #(len, shift) DUT(a, response, n, c, z, v);
always
#5 clk = !clk;

initial 
begin
  $display("\tclk,\ta,\tresponse,\tn,\tc,\tz,\tv"); 
  $monitor($time,"\t%b,\t%b,\t%b,\t%b,\t%b,\t%b,\t%d", clk, a, response, n, c, z, v); 
end

always
#5 clk = !clk;

endmodule




