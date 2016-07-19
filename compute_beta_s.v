`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:28:33 06/06/2016 
// Design Name: 
// Module Name:    compute_beta_s 
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
module compute_beta_s(
clk,
state2,
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
  input state2;
  input [15:0] m11,m10,m00,m01;
  output  [15:0] beta0,beta1,beta2,beta3,beta4,beta5,beta6,beta7;  
  input wire [15:0] old0, old1, old2, old3, old4, old5, old6, old7;
  reg [15:0] old0_reg,old1_reg,old2_reg,old3_reg,old4_reg,old5_reg,old6_reg,old7_reg;
  wire [16:0] beta0t,beta1t,beta2t,beta3t,beta4t,beta5t,beta6t,beta7t;  

always @(posedge clk or posedge state2)
  begin
    if (state2==1)
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
        if(beta0t<32767 && beta1t<32767 && beta2t<32767 && beta3t<32767 && beta4t<32767 && beta5t<32767 && beta6t<32767 && beta7t<32767)
         begin
           old0_reg<=beta0t[15:0];  
           old4_reg<=beta4t[15:0];
           old1_reg<=beta1t[15:0];
           old5_reg<=beta5t[15:0];
           old2_reg<=beta2t[15:0];
           old6_reg<=beta6t[15:0];
           old3_reg<=beta3t[15:0];
           old7_reg<=beta7t[15:0];           
         end
       else if(beta0t[16]==0 && beta1t[16]==0 && beta2t[16]==0 && beta3t[16]==0 && beta4t[16]==0 && beta5t[16]==0 && beta6t[16]==0 && beta7t[16]==0)
         begin
           old0_reg[15]<=0;
           old1_reg[15]<=0;
           old2_reg[15]<=0;
           old3_reg[15]<=0;
           old4_reg[15]<=0;
           old5_reg[15]<=0;
           old6_reg[15]<=0;
           old7_reg[15]<=0;
           old0_reg[14:0]<=beta0t[14:0];
           old1_reg[14:0]<=beta0t[14:0];
           old2_reg[14:0]<=beta0t[14:0];
           old3_reg[14:0]<=beta0t[14:0];
           old4_reg[14:0]<=beta0t[14:0];
           old5_reg[14:0]<=beta0t[14:0];
           old6_reg[14:0]<=beta0t[14:0];
           old7_reg[14:0]<=beta0t[14:0];
         end
      else
         begin
           old0_reg<=beta0t[15:0];  
           old4_reg<=beta4t[15:0];
           old1_reg<=beta1t[15:0];
           old5_reg<=beta5t[15:0];
           old2_reg<=beta2t[15:0];
           old6_reg<=beta6t[15:0];
           old3_reg<=beta3t[15:0];
           old7_reg<=beta7t[15:0];
         end   
        /*
       old0_reg<=beta0t; 
       old4_reg<=beta4t;
       old1_reg<=beta1t;
       old5_reg<=beta5t;
       old2_reg<=beta2t;
       old6_reg<=beta6t;
       old3_reg<=beta3t;
       old7_reg<=beta7t;
       */
     end
   end
   
  assign beta0=old0_reg;
  assign beta1=old1_reg;
  assign beta2=old2_reg;
  assign beta3=old3_reg;
  assign beta4=old4_reg;
  assign beta5=old5_reg;
  assign beta6=old6_reg;
  assign beta7=old7_reg;

TMAX tmax0(.old0(old0_reg),.old1(old4_reg),.m0(m00),.m1(m11),.alpha(beta0t));
TMAX tmax4(.old0(old6_reg),.old1(old2_reg),.m0(m10),.m1(m01),.alpha(beta4t));
TMAX tmax1(.old0(old4_reg),.old1(old0_reg),.m0(m00),.m1(m11),.alpha(beta1t));
TMAX tmax5(.old0(old6_reg),.old1(old2_reg),.m0(m01),.m1(m10),.alpha(beta5t));
TMAX tmax2(.old0(old5_reg),.old1(old1_reg),.m0(m01),.m1(m10),.alpha(beta2t));
TMAX tmax6(.old0(old7_reg),.old1(old3_reg),.m0(m00),.m1(m11),.alpha(beta6t));
TMAX tmax3(.old0(old5_reg),.old1(old1_reg),.m0(m10),.m1(m01),.alpha(beta3t));
TMAX tmax7(.old0(old7_reg),.old1(old3_reg),.m0(m11),.m1(m00),.alpha(beta7t));

endmodule
