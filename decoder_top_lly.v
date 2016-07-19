`define CODELENGTH 256
`define DATALENGTH 64
`define ADDRLENGTH 9
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:25:12 06/06/2016 
// Design Name: 
// Module Name:    decoder_top 
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
module decoder_top_lly(
     	           clk, //125M
					  clk_dp,
//					  areset,//(rst_tx_fifo),												
		           data_in,//rx_dat_fifo_dout
		           data_out, //mhd_dout_wdata
		           rst,
		           we_decode
    );
	 
	 input           clk; //125M
	 input           clk_dp;
//	 input				areset,//(rst_tx_fifo),												
	 input           data_in;//rx_dat_fifo_dout
	 output          data_out; //mhd_dout_wdata
	 input           rst;
	 output          we_decode;
	 
	 wire clk;
	 wire clk_dp;
    wire rst;
	 wire [`DATALENGTH-1:0]data_in;
	 wire [`DATALENGTH-1:0]data_out;
	 wire we_decode;


    (* keep="true" *)reg [47:0] data_in_chan;
    (* keep="true" *)wire [47:0] data_out_chan;
    (* keep="true" *)reg [`ADDRLENGTH-1:0] addr_in_chan;
	 reg we_chan;

    reg enable;
	 (* keep="true" *)reg rst_turbo;
	 reg [47:0]data_in_turbo;
	 wire [`ADDRLENGTH-1:0]addr_out_turbo;
	 wire [`DATALENGTH-1:0]data_out_turbo;
	 
    (* keep="true" *)reg [20:0]counter;
	 always@(posedge clk_dp)
	 begin
		if(!rst)
			begin
			   counter <= 0; 
			end
		else
			begin
				counter <= counter + 1; 
			end
	 end
     
    dist_mem_gen_0 channel_output(
              .clk(clk_dp),
              .i_ce(1'b1),
              .we(we_chan),
              .a(addr_in_chan),
              .d(data_in_chan),
              .spo(data_out_chan)
              );
	  
    always@(posedge clk_dp)
	 begin
		if(!rst)
			begin			   
				data_in_chan <= data_in[47:0];
			end
		else if(counter<263)
			begin
				data_in_chan <= data_in[47:0];
			end
		else 
			begin
			end
	 end
	
   always@(posedge clk_dp)
	 begin
	  if(counter==1)
	   begin
			addr_in_chan <= 0;
		end
	  else if(counter<263)
	   begin
			addr_in_chan <= addr_in_chan + 1;
		end
	  else 
		begin
			addr_in_chan <= addr_out_turbo;
		end
		
    end	 

	 
	 always@(posedge clk_dp)
	 begin
		if(!rst)
			begin
			   we_chan <= 1;
			end
		else if(counter==263)
			begin
				we_chan <= 0;
			end
		else 
		   begin
			end
	 end
	 
	 always@(posedge clk_dp)
	 begin
		if(counter == 263)
			begin
			   rst_turbo <= 0; 
			end
		else if(counter == 264)
			begin
				rst_turbo <= 1; 
			end
	 end
	 
 

//	 wire we_decode;
	 
	 
//	 assign data_in_turbo = data_out_chan ;
	 assign data_out = data_out_turbo;

    turbo_top turbo_top1(
      .enable(1'b1),
      .clk(clk_dp),
      .rst(rst_turbo),
      .data_in(data_in_turbo),
      .addr_out(addr_out_turbo),
      .data_out(data_out_turbo),
		.we_decode(we_decode)
      );
		
	 always@(posedge clk_dp)
	 begin
		data_in_turbo <= data_out_chan ;
	 end


endmodule
