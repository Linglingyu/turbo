`define CODELENGTH 256
`define f1 15
`define f2 32
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:31:06 06/06/2016 
// Design Name: 
// Module Name:    interleaver 
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
module interleaver(
clk,
rst,
interleaver_output
);
input clk;
input rst;
output [15:0]interleaver_output;

wire [15:0]interleaver_output;
reg [15:0] out;
reg [15:0]interleaver_temp;
//parameter f1=15;
//parameter f2=32;
//parameter K=256;

always @(posedge clk or posedge rst)
begin
  if(rst==1)
    begin
     out<=0;
     interleaver_temp<=0;
    end
  else
    begin
     interleaver_temp<=interleaver_temp+`f2*2;
     out<=(out+interleaver_temp+`f1+`f2)%`CODELENGTH;
    end
end

assign interleaver_output=out;

endmodule
