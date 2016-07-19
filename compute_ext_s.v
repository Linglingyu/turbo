`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:29:44 06/06/2016 
// Design Name: 
// Module Name:    compute_ext_s 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module compute_ext_s(
clk,
m00,
m01,
m10,
m11,
beta0,
beta1,
beta2,
beta3,
beta4,
beta5,
beta6,
beta7,
alpha0,
alpha1,
alpha2,
alpha3,
alpha4,
alpha5,
alpha6,
alpha7,
ext,
systematic
);

  input clk;
  input [15:0] m11,m10,m00,m01;
  input  [15:0] beta0,beta1,beta2,beta3,beta4,beta5,beta6,beta7;  
  input  [15:0] alpha0,alpha1,alpha2,alpha3,alpha4,alpha5,alpha6,alpha7; 
  input [15:0] systematic;
  output [15:0] ext; 
  
  reg [15:0]m00_4,m11_4,m00_3,m11_3,m00_2,m11_2,m00_1,m11_1,m01_4,m10_4,m01_3,m10_3,m01_2,m10_2,m01_1,m10_1;
  wire [15:0]m00_12t,m00_34t,m01_12t,m01_34t,m10_12t,m10_34t,m11_12t,m11_34t;
  wire [15:0]m00_m,m01_m,m10_m,m11_m;
  wire [15:0]m0t,m1t;
  wire  [15:0] ext;

always @(posedge clk)
 begin
  m00_4<=alpha7+beta3;
  m11_4<=alpha7+beta7;
  m00_3<=alpha6+beta7;
  m11_3<=alpha6+beta3;
  m00_2<=alpha1+beta4;
  m11_2<=alpha1+beta0;
  m00_1<=alpha0+beta0;
  m11_1<=alpha0+beta4;
  m01_4<=alpha5+beta6;
  m10_4<=alpha5+beta2;
  m01_3<=alpha4+beta2;
  m10_3<=alpha4+beta6;
  m01_2<=alpha3+beta1;
  m10_2<=alpha3+beta5;
  m01_1<=alpha2+beta5;
  m10_1<=alpha2+beta1;
 end

//assign  ext=m1t-m0t-systematic;

MAX max00_12(.m0(m00_1),.m1(m00_2),.m(m00_12t));
MAX max00_34(.m0(m00_3),.m1(m00_4),.m(m00_34t));
MAX max10_12(.m0(m10_1),.m1(m10_2),.m(m10_12t));
MAX max10_34(.m0(m10_3),.m1(m10_4),.m(m10_34t));
MAX max01_12(.m0(m01_1),.m1(m01_2),.m(m01_12t));
MAX max01_34(.m0(m01_3),.m1(m01_4),.m(m01_34t));
MAX max11_12(.m0(m11_1),.m1(m11_2),.m(m11_12t));
MAX max11_34(.m0(m11_3),.m1(m11_4),.m(m11_34t));

MAX max00_(.m0(m00_12t),.m1(m00_34t),.m(m00_m));
MAX max01_(.m0(m01_12t),.m1(m01_34t),.m(m01_m));
MAX max10_(.m0(m10_12t),.m1(m10_34t),.m(m10_m));
MAX max11_(.m0(m11_12t),.m1(m11_34t),.m(m11_m));

TMAX m0(.old0(m01_m),.old1(m00_m),.m0(m01),.m1(m00),.alpha(m0t));
TMAX m1(.old0(m10_m),.old1(m11_m),.m0(m10),.m1(m11),.alpha(m1t));

wire [15:0]temp0,temp0s;
assign temp0=m0t+systematic;
assign temp0s=(m0t[15]&systematic[15]&~temp0[15]) ? (16'h8001):
          ((~m0t[15]&~systematic[15]&temp0[15]) ? 16'h7fff : temp0);
assign ext=m1t-temp0s;

endmodule


module MAX(
  m0,
  m1,
  m
);

input [15:0]m0;
input [15:0]m1;
output [15:0]m;

reg [15:0]m;

always @(*)
  case ({m0[15],m1[15]})
    2'b00:
    if(m0>m1)
      m=m0;
    else
      m=m1;
    2'b01:
      m=m0;
    2'b10:
      m=m1;
    2'b11:
    if(m0>m1)
      m=m0;
    else
      m=m1;
    default:
      m=m0;
    endcase
	 
endmodule
