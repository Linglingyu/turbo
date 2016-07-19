`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:25:52 06/06/2016 
// Design Name: 
// Module Name:    compute_alpha_termination 
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
module compute_alpha_termination(
clk,
state,
m00,
m01,
m10,
m11,
alpha0,
alpha1,
alpha2,
alpha3,
alpha4,
alpha5,
alpha6,
alpha7,
old0, 
old1, 
old2, 
old3, 
old4, 
old5, 
old6,
old7
);

  input clk;
  input state;
  input [15:0] m11,m10,m00,m01;
  output  [15:0] alpha0,alpha1,alpha2,alpha3,alpha4,alpha5,alpha6,alpha7;  
  input wire [15:0] old0, old1, old2, old3, old4, old5, old6, old7;
  reg [15:0] old0_reg,old1_reg,old2_reg,old3_reg,old4_reg,old5_reg,old6_reg,old7_reg;
  wire [16:0] alpha0t,alpha1t,alpha2t,alpha3t,alpha4t,alpha5t,alpha6t,alpha7t; 

  always @(posedge clk)
  begin
    if (state==1)
      begin
        old0_reg <= old0;
        old1_reg <= old1;
        old2_reg <= old2;
        old3_reg <= old3;
        old4_reg <= old4;
        old5_reg <= old5;
        old6_reg <= old6;
        old7_reg <= old7;
      end
    else
      begin
        if(alpha0t<32767 && alpha1t<32767 && alpha2t<32767 && alpha3t<32767)
         begin
           old0_reg<=alpha0t[15:0];  
           old1_reg<=alpha1t[15:0];
           old2_reg<=alpha2t[15:0];
           old3_reg<=alpha3t[15:0];          
         end
         else if(alpha0t[16]==0 && alpha1t[16]==0 && alpha2t[16]==0 && alpha3t[16]==0 && alpha4t[16]==0 && alpha5t[16]==0 && alpha6t[16]==0 && alpha7t[16]==0)
         begin
           old0_reg[15]<=0;
           old1_reg[15]<=0;
           old2_reg[15]<=0;
           old3_reg[15]<=0;
           old0_reg[14:0]<=alpha0t[14:0];
           old1_reg[14:0]<=alpha0t[14:0];
           old2_reg[14:0]<=alpha0t[14:0];
           old3_reg[14:0]<=alpha0t[14:0];
         end
         else
         begin
           old0_reg<=alpha0t[15:0];
           old1_reg<=alpha1t[15:0];
           old2_reg<=alpha2t[15:0];
           old3_reg<=alpha3t[15:0];
         end   
        /*
       old0_reg<=alpha0t; 
       old4_reg<=old4_reg;
       old1_reg<=alpha1t;
       old5_reg<=old5_reg;
       old2_reg<=alpha2t;
       old6_reg<=old6_reg;
       old3_reg<=alpha3t;
       old7_reg<=old7_reg;
       */
     end
   end
   
  assign alpha0=old0_reg;
  assign alpha1=old1_reg;
  assign alpha2=old2_reg;
  assign alpha3=old3_reg;
  assign alpha4=old4_reg;
  assign alpha5=old5_reg;
  assign alpha6=old6_reg;
  assign alpha7=old7_reg;
  
TMAX tmax0(.old0(old0_reg),.old1(old1_reg),.m0(m00),.m1(m00),.alpha(alpha0t));
TMAX tmax1(.old0(old3_reg),.old1(old2_reg),.m0(m01),.m1(m01),.alpha(alpha1t));
TMAX tmax2(.old0(old5_reg),.old1(old4_reg),.m0(m01),.m1(m01),.alpha(alpha2t));
TMAX tmax3(.old0(old7_reg),.old1(old6_reg),.m0(m00),.m1(m00),.alpha(alpha3t));





endmodule
