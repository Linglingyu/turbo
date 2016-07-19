`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:14:13 05/27/2014 
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
module decoder_top(
							input					clk_inter,//125M,using with decoder
//							input					clk_inter_d,
							input					clk_dp, //62.5M, 1/4 of clk_trn
							input					areset, //0
							input					tx_dat_fifo_rclk,//62.5MHz
							input					tx_dat_fifo_rclk_rst_n,
							input					tx_dat_fifo_rden,
							output	[63:0]	tx_dat_fifo_dout,
							output	[63:0]	mhd_dout_wdata,
							output 			mhd_dout_wvalid,
							output 			tx_dat_fifo_empty,
							//========================== rx fifo interface
							input					rx_dat_fifo_wclk,//62.5MHz
							input					rx_dat_fifo_wclk_rst_n,
							input					rx_dat_fifo_wren,
							output 			rx_dat_fifo_empty,
							input	[63:0]	rx_dat_fifo_din,
							output			rx_dat_fifo_full
                     //input             rst_decoder_top_lly
						);

//items of data in
//wire				tx_empty;
wire				rx_empty;
//wire				rx_dat_fifo_empty;
(* keep="true" *)wire	[63:0]	rx_dat_fifo_dout;

//items of data out
(* keep="true" *)reg	[63:0]	tx_dat_fifo_din;

wire				tx_dat_fifo_full;
wire				dout_out_handshake;
assign			dout_out_handshake = (mhd_dout_wvalid && (~tx_dat_fifo_full));
(* keep="true" *)wire mhd_dout_wvalid;

//logic to fill 0 to tx fifo and reset
	

always@(posedge clk_dp)
	begin	
		if(mhd_dout_wvalid)
			tx_dat_fifo_din			<= mhd_dout_wdata;
	end

wire	[63:0]	tx_dat_fifo_dout_reverse;


assign			tx_dat_fifo_dout[0] = tx_dat_fifo_dout_reverse[39];
assign			tx_dat_fifo_dout[1] = tx_dat_fifo_dout_reverse[38];
assign			tx_dat_fifo_dout[2] = tx_dat_fifo_dout_reverse[37];
assign			tx_dat_fifo_dout[3] = tx_dat_fifo_dout_reverse[36];
assign			tx_dat_fifo_dout[4] = tx_dat_fifo_dout_reverse[35];
assign			tx_dat_fifo_dout[5] = tx_dat_fifo_dout_reverse[34];
assign			tx_dat_fifo_dout[6] = tx_dat_fifo_dout_reverse[33];
assign			tx_dat_fifo_dout[7] = tx_dat_fifo_dout_reverse[32];

assign			tx_dat_fifo_dout[8] = tx_dat_fifo_dout_reverse[47];
assign			tx_dat_fifo_dout[9] = tx_dat_fifo_dout_reverse[46];
assign			tx_dat_fifo_dout[10] = tx_dat_fifo_dout_reverse[45];
assign			tx_dat_fifo_dout[11] = tx_dat_fifo_dout_reverse[44];
assign			tx_dat_fifo_dout[12] = tx_dat_fifo_dout_reverse[43];
assign			tx_dat_fifo_dout[13] = tx_dat_fifo_dout_reverse[42];
assign			tx_dat_fifo_dout[14] = tx_dat_fifo_dout_reverse[41];
assign			tx_dat_fifo_dout[15] = tx_dat_fifo_dout_reverse[40];

assign			tx_dat_fifo_dout[16] = tx_dat_fifo_dout_reverse[55];
assign			tx_dat_fifo_dout[17] = tx_dat_fifo_dout_reverse[54];
assign			tx_dat_fifo_dout[18] = tx_dat_fifo_dout_reverse[53];
assign			tx_dat_fifo_dout[19] = tx_dat_fifo_dout_reverse[52];
assign			tx_dat_fifo_dout[20] = tx_dat_fifo_dout_reverse[51];
assign			tx_dat_fifo_dout[21] = tx_dat_fifo_dout_reverse[50];
assign			tx_dat_fifo_dout[22] = tx_dat_fifo_dout_reverse[49];
assign			tx_dat_fifo_dout[23] = tx_dat_fifo_dout_reverse[48];

assign			tx_dat_fifo_dout[24] = tx_dat_fifo_dout_reverse[63];
assign			tx_dat_fifo_dout[25] = tx_dat_fifo_dout_reverse[62];
assign			tx_dat_fifo_dout[26] = tx_dat_fifo_dout_reverse[61];
assign			tx_dat_fifo_dout[27] = tx_dat_fifo_dout_reverse[60];
assign			tx_dat_fifo_dout[28] = tx_dat_fifo_dout_reverse[59];
assign			tx_dat_fifo_dout[29] = tx_dat_fifo_dout_reverse[58];
assign			tx_dat_fifo_dout[30] = tx_dat_fifo_dout_reverse[57];
assign			tx_dat_fifo_dout[31] = tx_dat_fifo_dout_reverse[56];

assign			tx_dat_fifo_dout[32] = tx_dat_fifo_dout_reverse[7];
assign			tx_dat_fifo_dout[33] = tx_dat_fifo_dout_reverse[6];
assign			tx_dat_fifo_dout[34] = tx_dat_fifo_dout_reverse[5];
assign			tx_dat_fifo_dout[35] = tx_dat_fifo_dout_reverse[4];
assign			tx_dat_fifo_dout[36] = tx_dat_fifo_dout_reverse[3];
assign			tx_dat_fifo_dout[37] = tx_dat_fifo_dout_reverse[2];
assign			tx_dat_fifo_dout[38] = tx_dat_fifo_dout_reverse[1];
assign			tx_dat_fifo_dout[39] = tx_dat_fifo_dout_reverse[0];

assign			tx_dat_fifo_dout[40] = tx_dat_fifo_dout_reverse[15];
assign			tx_dat_fifo_dout[41] = tx_dat_fifo_dout_reverse[14];
assign			tx_dat_fifo_dout[42] = tx_dat_fifo_dout_reverse[13];
assign			tx_dat_fifo_dout[43] = tx_dat_fifo_dout_reverse[12];
assign			tx_dat_fifo_dout[44] = tx_dat_fifo_dout_reverse[11];
assign			tx_dat_fifo_dout[45] = tx_dat_fifo_dout_reverse[10];
assign			tx_dat_fifo_dout[46] = tx_dat_fifo_dout_reverse[9];
assign			tx_dat_fifo_dout[47] = tx_dat_fifo_dout_reverse[8];

assign			tx_dat_fifo_dout[48] = tx_dat_fifo_dout_reverse[23];
assign			tx_dat_fifo_dout[49] = tx_dat_fifo_dout_reverse[22];
assign			tx_dat_fifo_dout[50] = tx_dat_fifo_dout_reverse[21];
assign			tx_dat_fifo_dout[51] = tx_dat_fifo_dout_reverse[20];
assign			tx_dat_fifo_dout[52] = tx_dat_fifo_dout_reverse[19];
assign			tx_dat_fifo_dout[53] = tx_dat_fifo_dout_reverse[18];
assign			tx_dat_fifo_dout[54] = tx_dat_fifo_dout_reverse[17];
assign			tx_dat_fifo_dout[55] = tx_dat_fifo_dout_reverse[16];

assign			tx_dat_fifo_dout[56] = tx_dat_fifo_dout_reverse[31];
assign			tx_dat_fifo_dout[57] = tx_dat_fifo_dout_reverse[30];
assign			tx_dat_fifo_dout[58] = tx_dat_fifo_dout_reverse[29];
assign			tx_dat_fifo_dout[59] = tx_dat_fifo_dout_reverse[28];
assign			tx_dat_fifo_dout[60] = tx_dat_fifo_dout_reverse[27];
assign			tx_dat_fifo_dout[61] = tx_dat_fifo_dout_reverse[26];
assign			tx_dat_fifo_dout[62] = tx_dat_fifo_dout_reverse[25];
assign			tx_dat_fifo_dout[63] = tx_dat_fifo_dout_reverse[24];
// reg tx_dat_empty;

wire tx_dat_fifo_empty;
reg rst_tx_fifo;


//assign tx_out_empty = tx_dat_fifo_empty ;
/*
always@(posedge tx_dat_fifo_rclk)
	begin	
		if(!tx_dat_fifo_empty_r && tx_dat_fifo_empty)
			rst_tx_fifo 			<= 1'b1;
		else
			rst_tx_fifo 			<= 1'b0;
	end
	*/
//interface of fifos with independent clock
//tx fifo
tx_decoder_fifo tx_fifo_dclk(
								.rst(areset),// || rst_tx_fifo
								.wr_clk(clk_dp),
								.rd_clk(tx_dat_fifo_rclk),
								.din(tx_dat_fifo_din),
								.wr_en(mhd_dout_wvalid),// || mhd_dout_wvalid_r
								.full(tx_dat_fifo_full),
								.dout(tx_dat_fifo_dout_reverse),
								.rd_en(tx_dat_fifo_rden),
								.empty(tx_dat_fifo_empty)
								);

reg [63:0]rx_dat_fifo_din_r;
always@(posedge clk_dp)
	begin
		rx_dat_fifo_din_r<=rx_dat_fifo_din;
	end
wire rx_dat_wren;
assign rx_dat_wren = (rx_dat_fifo_wren && (rx_dat_fifo_din_r||rx_dat_fifo_din));
reg rst_rx_fifo;

wire				data_in_handshake;
assign			data_in_handshake = ~rx_dat_fifo_empty;


//rx fifo
reg rx_dat_fifo_rden;
//assign rx_dat_fifo_rden=~rx_dat_fifo_empty;

always@(posedge clk_dp)
	begin
		if(count_clk==1)
			begin
				rx_dat_fifo_rden <= 1;
			end
		else if(count_dout==260)
			begin
				rx_dat_fifo_rden <= 0;
			end
	end
	


(* keep="true" *)reg [15:0]count_clk;
	
always@(posedge clk_dp)
	begin
		if(rx_dat_fifo_empty)
			begin
				count_clk <= 0;
			end
		else if(count_clk==11000)//10261
			begin
				count_clk <= 0;
			end
		else
			begin
				count_clk <= count_clk + 1;
			end
	end


rx_decoder_fifo rx_fifo_dclk(
								.rst(areset),// || rst_rx_fifo),
								.wr_clk(rx_dat_fifo_wclk),
								.rd_clk(clk_dp),
								.din(rx_dat_fifo_din),
								.wr_en(rx_dat_wren),
								.full(rx_dat_fifo_full),
								.dout(rx_dat_fifo_dout),
								.rd_en(rx_dat_fifo_rden),//data_in_handshake
								.empty(rx_dat_fifo_empty)
								);

//interface of turbo decoder

(* keep="true" *) reg rst_decoder_top_lly = 1'b0;

wire rx_dat_rden;
assign rx_dat_rden = rx_dat_fifo_rden&&rx_dat_fifo_dout;
always@(posedge clk_dp)
    begin
		if(rx_dat_rden)//rx_dat_fifo_rden
			begin
				rst_decoder_top_lly 			<= 1;
//				count_dout <=0 ;
			end
		else if(!tx_dat_fifo_empty)
			begin
			   rst_decoder_top_lly 			<= 0;
			end
		else 
			begin
			end
	 end
	 
reg [10:0]count_dout;
always@(posedge clk_dp)
		begin
			if(rst_decoder_top_lly==0)
				begin
					count_dout<=0;
				end
			else if(count_dout==261)
				begin
					count_dout<=261;
				end
			else
				begin
					count_dout<=count_dout+1;
				end
		end

	 
	 
reg [63:0]rx_dat_fifo_dout_r;
reg [63:0]rx_dat_fifo_dout_r2;

always@(posedge clk_dp)
    begin
		rx_dat_fifo_dout_r<=rx_dat_fifo_dout;
		rx_dat_fifo_dout_r2<=rx_dat_fifo_dout_r;
    end

(* keep="true" *)wire [63:0]mhd_dout_wdata;
decoder_top_lly decoder_top_lly(   
                                   .clk(clk_dp), //125M
											  .clk_dp(clk_dp),
			               //         .areset(areset),//(rst_tx_fifo),												
	                                .data_in(rx_dat_fifo_dout_r2),//rx_dat_fifo_dout
		                             .data_out(mhd_dout_wdata), //mhd_dout_wdata
	                                .rst(rst_decoder_top_lly),
	                                .we_decode(mhd_dout_wvalid)
												);



endmodule
