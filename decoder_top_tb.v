`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:51:59 06/16/2016 
// Design Name: 
// Module Name:    decoder_top_tb 
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
module decoder_top_tb;

reg clk_inter;//125M
reg clk_dp;
reg areset;
reg [63:0]data_in[52400:0];
wire [63:0]data_out;
reg tx_dat_fifo_rclk_rst_n;
reg rx_dat_fifo_wclk_rst_n;
reg [63:0]data_in_decoder;
reg reset;

//reg rst_decoder_top_lly;

reg rx_dat_fifo_wren; 
reg rx_dat_fifo_full;
 
decoder_top decoder_top1(
							.clk_inter(clk_dp),//125M,using with decoder
							.clk_dp(clk_dp), //62.5M, 1/4 of clk_trn
							.areset(areset), //0
							.tx_dat_fifo_rclk(clk_dp),//62.5MHz
							.tx_dat_fifo_rclk_rst_n(tx_dat_fifo_rclk_rst_n),
							.tx_dat_fifo_rden(1'b1),
							.tx_dat_fifo_dout(data_out),
							.mhd_dout_wdata(),
							.mhd_dout_wvalid(),
							//========================== rx fifo interface
							.rx_dat_fifo_wclk(clk_dp),//62.5MHz
							.rx_dat_fifo_wclk_rst_n(rx_dat_fifo_wclk_rst_n),
							.rx_dat_fifo_wren(rx_dat_fifo_wren),
							.rx_dat_fifo_din(data_in_decoder),
							.rx_dat_fifo_full(rx_dat_fifo_full)
//							.rst_decoder_top_lly(rst_decoder_top_lly)
						);
					
always #8 	clk_dp = ~clk_dp;
always #4 	clk_inter = ~clk_inter;					

initial
	begin
		clk_dp <= 0;
		clk_inter <= 0;
		areset <= 0;
		reset <= 0;
	end
	
	
  reg [20:0]q;
  
   initial
   begin
   $readmemh("D://channel_output_new2_l_ld.txt",data_in);
	rx_dat_fifo_wren <= 1'b1;
   for(q=0;q<52400;q=q+1)
   #16
	begin
	data_in_decoder <= data_in[q];
	end
	rx_dat_fifo_wren <= 1'b0;
/*	
	#160000
	rx_dat_fifo_wren <= 1'b1;
   for(q=0;q<262;q=q+1)
   #16
	begin
	data_in_decoder <= data_in[q+263];
	end
	rx_dat_fifo_wren <= 1'b0;
 */ 
  end
  

endmodule
