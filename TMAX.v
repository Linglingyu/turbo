`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:32:08 06/06/2016 
// Design Name: 
// Module Name:    TMAX 
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
module TMAX(
old0,
old1,
m0,
m1,
alpha
);

input [15:0]old0;
input [15:0]old1;
input [15:0]m0;
input [15:0]m1;

output [16:0]alpha;

wire [16:0] data0,data1;
wire [16:0]old0_temp,old1_temp,m0_temp,m1_temp;
//wire [16:0] data0s,data1s;
reg [16:0]alpha;

assign old0_temp[16:0]=(old0[15])?({1'b1,old0[15:0]}):({1'b0,old0[15:0]});
assign old1_temp[16:0]=old1[15]?{1'b1,old1[15:0]}:{1'b0,old1[15:0]};
assign m0_temp[16:0]=m0[15]?{1'b1,m0[15:0]}:{1'b0,m0[15:0]};
assign m1_temp[16:0]=m1[15]?{1'b1,m1[15:0]}:{1'b0,m1[15:0]};


assign data0=old0_temp+m0_temp;
assign data1=old1_temp+m1_temp;
/*
assign data0s=(old0[15]&m0[15]&~data0[15]) ? (17'h10000):
          ((~old0[15]&~m0[15]&data0[15]) ? 17'hffff : data0);
          
assign data1s=(old1[15]&m1[15]&~data1[15]) ? (17'h10000):
          ((~old1[15]&~m1[15]&data1[15]) ? 17'hffff : data1);
*/      
          
always @(*)
  case ({data0[16],data1[16]})
  2'b00:
    if(data0>data1)
       alpha=data0;
    else  
       alpha = data1;
  2'b01:
       alpha=data0;
  2'b10:
       alpha=data1;
  2'b11:
    if(data0>data1)
        alpha=data0;
    else 
        alpha = data1;
  default:
    alpha=data0;
  endcase

endmodule
