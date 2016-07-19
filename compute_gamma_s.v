`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:21:13 06/06/2016 
// Design Name: 
// Module Name:    compute_gamma_s 
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
module compute_gamma_s(
	m11,
	m10,
	m00,
	m01,
	systematic,
	yparity
   );
	
output [15:0]m11,m10,m00,m01;
input [15:0]systematic,yparity;

wire [16:0] temp11,temp10,systematic_t,yparity_t;
  

assign systematic_t={systematic[15],systematic};
assign yparity_t={yparity[15],yparity};

assign temp11=(systematic_t+yparity_t);
assign temp10=(systematic_t-yparity_t);

 assign m11=(temp11[16]&temp11[0])?(temp11[16:1]+1):temp11[16:1];
 assign m10=(temp10[16]&temp10[0])?(temp10[16:1]+1):temp10[16:1];
 assign m00=-m11;
 assign m01=-m10; 

endmodule
