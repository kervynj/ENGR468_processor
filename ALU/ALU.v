module nbit_adder (in1, in2, return1, f);
  parameter size = 4; // default length of 4
  input [size-1:0] in1, in2;
  output [size-1:0] return1;
  output [3:0] f;
  wire [size:0] carry;
  
  genvar i;
  assign carry[0] = 0; //input to first half-adder = 0
  assign f[1] = carry[size]; // carry flag set from final full-adder output
  assign f[3] = carry[size] ^ carry[size-1]; // overflow flag determined from last two carry values
  assign f[2] = ~|{in1, in2}; // reduction NOR to evaluate all bits being the same
  assign f[0] = return1[size-1]; // assume MSB of result determines polarity
  
  generate for (i=0; i<size; i = i +1)
    begin
    full_adder fa(in1[i], in2[i], carry[i], carry[i+1], return1[i]);
    end
  endgenerate 
endmodule  


// subtractor module for ALU - leverages nbit_Adder 
module nbit_subtractor(in1, in2, return1, f);
  parameter size =4;
  input [size-1:0] in1, in2;
  output [size-1:0] return1;
  output [3:0] f;
  
  wire [3:0] f_intermediate;
  
  wire [size-1:0] in2_inverse;
  wire [size-1:0] in2_negative;
  
  assign in2_inverse = (~in2) ;
  
  nbit_adder #(size) add(in2_inverse, 16'b1, in2_negative, f_intermediate);
  
  nbit_adder #(size) add2(in1, in2_negative, return1, f); 
  
  
  
endmodule 


// multiplier block for ALU
module nbit_multiplier(in1, in2, return1, f);
  parameter size = 4;
  input [size-1:0] in1, in2;
  output [size-1:0] return1;
  output [3:0] f;
  
  assign {f[0],return1} = in1*in2; // complete multiplication and set C
  assign f[3:0] = 3'b000;
endmodule 


//n-bitwise OR'ing module
module nbit_or(in1, in2, return1, f);
  parameter size = 4;
  input [size-1:0] in1, in2;
  output [size-1:0] return1;
  output [3:0] f;
  
  assign return1 = in1|in2;
  assign f[0] = return1[size-1];
  assign f[1] = 1'b0; // set to 0
  assign f[3] = 1'b0; // set to 0
  assign f[2] = ~|return1;
endmodule

//n-bitwise AND'ing module
module nbit_and(in1, in2, return1, f);
  parameter size =4;
  input [size-1:0] in1, in2;
  output [size-1:0] return1;
  output [3:0] f;
  
  assign return1 = in1&in2;
  assign f[0] = return1[size-1];
  assign f[1] = 1'b0; // set to 0
  assign f[3] = 1'b0; // set to 0
  assign f[2] = ~|return1;
  
endmodule

//n-bitwise XOR'ing module
module nbit_xor(in1, in2, return1, f);
  parameter size =4;
  input [size-1:0] in1, in2;
  output [size-1:0] return1;
  output [3:0] f;
  
  assign return1 = in1^in2;
  assign f[0] = return1[size-1];
  assign f[1] = 1'b0; // set to 0
  assign f[3] = 1'b0; // set to 0
  assign f[2] = ~|return1;
endmodule

//n-bitwise left shift
module nbit_left_shift(in1, return1, f, shiftb);
  parameter size = 16;
  input [3:0] shiftb;
  input [size-1:0] in1;
  output [size-1:0] return1;
  output [3:0] f;
  
  assign return1 = in1 << shiftb;
  assign f[0] = return1[size-1];
  assign f[1] = in1[size-shiftb]; 
  assign f[3] = 1'b0; // set to 0
  assign f[2] = ~|return1;
endmodule


//n-bitwise right shift
module nbit_right_shift(in1, return1, f, shiftb);
  parameter size = 16;
  
  input [3:0]shiftb;
  input [size-1:0] in1;
  output [size-1:0] return1;
  output [3:0] f;
  
  assign return1 = in1 >> shiftb;
  assign f[0] = return1[size-1];
  assign f[1] = in1[shiftb-1]; 
  assign f[3] = 1'b0; // set to 0
  assign f[2] = ~|return1;
endmodule


//n-bitwise right rotate 
module nbit_right_rotate(in1, return1, f, shiftb);
  parameter size = 16;

  input [3:0]shiftb;
  input [size-1:0] in1;
  output [size-1:0] return1;
  output [3:0] f;
  
  wire [(size*2-1):0] tmp;
  
  assign tmp = {in1, in1} >> shiftb;
  
  
  assign return1 = tmp[size-1:0];
  
  assign f[0] = return1[size-1];
  assign f[1] = in1[shiftb-1]; 
  assign f[3] = 1'b0; // set to 0
  assign f[2] = ~|return1;
endmodule


// 16bit mux
module mux(a, b, c, d, e, f, g, h, i, sel, return1, execute);
  input [15:0] a, b, c, d, e, f, g, h, i;
  input [3:0] sel;
  input execute;
  output [15:0] return1;
  
  reg [15:0] return1;

  always@(posedge execute)
    case(sel)
      4'b0000: return1 = a;
      4'b0001: return1 = b;
      4'b0010: return1 = c;
      4'b0011: return1 = d;
      4'b0100: return1 = e;
      4'b0101: return1 = f;
      4'b0110: return1 = g;
      4'b0111: return1 = h;
      4'b1000: return1 = i;
	  4'b1001: return1 = b; // compare uses same lines as subract module
	  default return1 =a;
    endcase
endmodule 

// 4bit mux
module fourbit_mux(a2, b2, c2, d2, e2, f2, g2, h2, i2, sel2, return1, execute);
  input [3:0] a2, b2, c2, d2, e2, f2, g2, h2, i2;
  input [3:0] sel2;
  input execute;
  output reg [3:0] return1;
  
  always@(posedge execute)
    case(sel2)
      4'b0000: return1 = a2;
      4'b0001: return1 = b2;
      4'b0010: return1 = c2;
      4'b0011: return1 = d2;
      4'b0100: return1 = e2;
      4'b0101: return1 = f2;
      4'b0110: return1 = g2;
      4'b0111: return1 = h2;
      4'b1000: return1 = i2;
	  4'b1001: return1 = b2; // compare uses same lines as subract module
	  default return1 = a2;
    endcase
endmodule 
  

// Full Adder required for Sum and Subtract modules
module full_adder(a, b, cin, cout, sum);
  input a, b, cin;
  output sum, cout;

  assign sum = a^b^cin;
  assign cout = (a&b)|(a&cin)|(b&cin);
  
endmodule
  
     
    
  
