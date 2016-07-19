`define CODELENGTH 256
`define ADDRLENGTH 9
`define DATALENGTH 64
`define BITLENGTH 16
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:10:18 06/06/2016 
// Design Name: 
// Module Name:    turbo_top 
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
module turbo_top(
  enable,
  clk,
  rst,
  data_in,
  addr_out,
  data_out,
  we_decode
  );
  input enable;
  input clk;
  input rst;
  input [`DATALENGTH-1:0]data_in;
  output [`ADDRLENGTH-1:0]addr_out;
  output [`DATALENGTH-1:0]data_out;
  output we_decode;
  
  reg we_decode = 1'b0;
  (* keep="true" *)reg [`DATALENGTH-1:0]data_out=0;
  reg [`ADDRLENGTH-1:0]addr_out;
  wire[`BITLENGTH-1:0] systematic0;
  wire[`BITLENGTH-1:0] yparity1;
  wire[`BITLENGTH-1:0] yparity2;
  
  reg signed[`BITLENGTH-1:0] systematic1;
  reg signed[`BITLENGTH-1:0] systematic2;
  wire [`BITLENGTH-1:0] ext;
  (* keep="true" *)wire [`BITLENGTH-1:0] ext2;
  (* keep="true" *)wire [`BITLENGTH-1:0] ext3;
  reg state3,state4,state5;
  reg state_pi,state_pi_2,state_pi_3;
  wire [`BITLENGTH-1:0]pi,pi_2,pi_3;
  reg [`BITLENGTH-1:0]p;
  (* keep="true" *)reg [3:0]a;
  (* keep="true" *)reg [`CODELENGTH-1:0]decoded_bytes;
//  reg cen;
  
  assign systematic0=data_in[47:32];
  assign yparity1=data_in[31:16];
  assign yparity2=data_in[15:0];
  
  log_map_memory log_map_memory1(
.clk(clk),
.systematic(systematic0),
.yparity(yparity1),
.ext(ext),
.state3(state3)
);

  log_map_memory log_map_memory2(
.clk(clk),
.systematic(systematic2),
.yparity(yparity2),
.ext(ext2),
.state3(state4)
);

  log_map_memory log_map_memory3(
.clk(clk),
.systematic(systematic1),
.yparity(yparity1),
.ext(ext3),
.state3(state5)
);

 interleaver interleaver1(
.clk(clk),
.rst(state_pi),
.interleaver_output(pi)
);

interleaver interleaver2(
.clk(clk),
.rst(state_pi_2),
.interleaver_output(pi_2)
);

interleaver interleaver3(
.clk(clk),
.rst(state_pi_3),
.interleaver_output(pi_3)
);

 (* keep="true" *) reg [20:0]tt;
  
  always@(posedge clk)
  begin
    if(rst==0 && enable ==1)//
      begin
         tt<=0;
			
       end
    else if(tt==`CODELENGTH*7+63+`CODELENGTH+20+`CODELENGTH+4+1)//2392
       begin
         tt<=`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2;//797
        end
	 else if(a>6)
      begin
		   tt<=65535;
      end
	 else
      begin
         tt<=tt+1;
      end
  end  //counter
  
  
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
 

  reg wen_systematic;
  reg [`BITLENGTH-1:0]data_in_systematic;
  wire [`BITLENGTH-1:0]data_out_systematic;
  reg [`ADDRLENGTH-1:0]addr_in_systematic;


 blk_mem_gen_0 systematic_a(
    .clka(clk),
    .ena(1'b1),
    .wea(wen_systematic),
    .addra(addr_in_systematic),
    .dina(data_in_systematic),
    .douta(data_out_systematic)
);

always@(posedge clk)
begin
  if(tt==3)
    begin
      wen_systematic<=1;
      addr_in_systematic<=0;
    end
  else if(tt>3&&tt<`CODELENGTH+9)
    begin
      addr_in_systematic<=addr_in_systematic+1;
    end
  else if(tt>`CODELENGTH*3+30&&tt<`CODELENGTH*3+30+`CODELENGTH+1)//798,1055 tt=ii+3
    begin
      wen_systematic<=0;
      addr_in_systematic<=pi;
    end
  else if(tt==`CODELENGTH*4+31)//1055
    begin
      addr_in_systematic<=`CODELENGTH;//256
    end
  else if(tt>`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1&&tt<`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1)//1334,1591
    begin
      wen_systematic<=0;
      addr_in_systematic<=pi;
    end
  else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1)//1591
    begin
      addr_in_systematic<=`CODELENGTH;//256
    end
  else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1)//1592
    begin
      addr_in_systematic<=`CODELENGTH+1;//257
    end
  else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1)//1593
    begin
      addr_in_systematic<=`CODELENGTH+2;//258
    end
end


  reg wen_systematic2;
  reg [`BITLENGTH-1:0]data_in_systematic2;
  wire [`BITLENGTH-1:0]data_out_systematic2;
  reg [`ADDRLENGTH-1:0]addr_in_systematic2;

 blk_mem_gen_0 systematic2_a(
   .clka(clk),
   .ena(1'b1),
   .wea(wen_systematic2),
   .addra(addr_in_systematic2),
   .dina(data_in_systematic2),
   .douta(data_out_systematic2)
);


always@(posedge clk)
begin
  if(tt==`CODELENGTH*3+32)//800
    begin
      wen_systematic2<=1;
      addr_in_systematic2<=0;
    end
  else if(tt>`CODELENGTH*3+32&&tt<`CODELENGTH*3+32+`CODELENGTH+3+1)//800,1060
    begin
      addr_in_systematic2<=addr_in_systematic2+1;
    end
  else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17)//1333
    begin
      wen_systematic2<=0;
      addr_in_systematic2<=0;
    end
  else if(tt>`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17&&tt<`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1)//1333,1593
    begin
      addr_in_systematic2<=addr_in_systematic2+1;
    end
end


  reg wen_systematic1;
  reg [`BITLENGTH-1:0]data_in_systematic1;
  wire [`BITLENGTH-1:0]data_out_systematic1;
  reg [`ADDRLENGTH-1:0]addr_in_systematic1;

blk_mem_gen_0 systematic1_(
   .clka(clk),
   .ena(1'b1),
   .wea(wen_systematic1),
   .addra(addr_in_systematic1),
   .dina(data_in_systematic1),
   .douta(data_out_systematic1)
);

always@(posedge clk)
begin
  if(tt>`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1&&tt<`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1)//1334,1593
    begin
      wen_systematic1<=1;
      addr_in_systematic1<=pi_2;
    end
  else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1)//1593
    begin
      addr_in_systematic1<=`CODELENGTH;//256
    end
  else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+1)//1594
    begin
      addr_in_systematic1<=`CODELENGTH+1;//257
    end
  else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+1+1)//1595
    begin
      addr_in_systematic1<=`CODELENGTH+2;//258
    end
  else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+1+1+1)//1596
    begin
      wen_systematic1<=0;
      addr_in_systematic1<=0;
    end  
  else if(tt>`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+1+1+1&&tt<`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+1+1+1+`CODELENGTH+3)//1596,1855
    begin
      addr_in_systematic1<=addr_in_systematic1+1;
    end
  else if(tt==`CODELENGTH*7+63+`CODELENGTH+20)//2131
    begin
      wen_systematic1<=0;
      addr_in_systematic1<=0;
    end
  else if(tt>`CODELENGTH*7+63+`CODELENGTH+20&&tt<`CODELENGTH*7+63+`CODELENGTH+20+`CODELENGTH+4)//2131,2391
    begin
      addr_in_systematic1<=addr_in_systematic1+1;
    end
end




 
 
  reg wen_ext;
  reg [`BITLENGTH-1:0]data_in_ext;
  wire [`BITLENGTH-1:0]data_out_ext;
  reg [`ADDRLENGTH-1:0]addr_in_ext;


blk_mem_gen_0 ext_(
   .clka(clk),
   .ena(1'b1),
   .wea(wen_ext),
   .addra(addr_in_ext),
   .dina(data_in_ext),
   .douta(data_out_ext)
);

always@(posedge clk)
begin
  if(tt==`CODELENGTH*2+26)//538
    begin
      wen_ext<=1;
      addr_in_ext<=0;
    end
  else if(tt>`CODELENGTH*2+26&&tt<`CODELENGTH*2+26+`CODELENGTH+3)//538,797
    begin
      addr_in_ext<=addr_in_ext+1;
    end
  else if(tt==`CODELENGTH*3+30)//798
    begin
      wen_ext<=0;
      addr_in_ext<=pi;
    end
  else if(tt>`CODELENGTH*3+30&&tt<`CODELENGTH*3+30+`CODELENGTH+1)//798,1055
    begin
      addr_in_ext<=pi;
    end
  else if(tt==`CODELENGTH*7+63+`CODELENGTH+20+3)//2134
    begin
      wen_ext<=1;
      addr_in_ext<=0;
    end
  else if(tt>`CODELENGTH*7+63+`CODELENGTH+20+2&&tt<`CODELENGTH*7+63+`CODELENGTH+20+`CODELENGTH+4+2)//2133,2393
    begin
      addr_in_ext<=addr_in_ext+1;
    end

end


  always@(posedge clk)
  begin
    if(tt<`CODELENGTH+6-1+2)//2 clocks delay while reading from channel_output_memory
      begin
        data_in_systematic<=systematic0;//systematic_a[tt-3]<=systematic0;
      end
  end
 
 
  always@(posedge clk or negedge rst)
  begin
    if(rst==0)
      begin
        addr_out<=0;
      end
    else if(tt<`CODELENGTH+6-1)//6 systematics & 3 yparity1s & 3 yparity2s stored in channel_output_memory after 256 systematics,yparity1s,yparity2s
      begin
        addr_out<=addr_out+1;
      end
    else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+2)//534
      begin
        addr_out <= 0;
      end
    else if(tt>`CODELENGTH+16+`CODELENGTH+2+1+1+2&&tt<`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1)//when computing ext at the end of the 1st log_map//534,798
      begin
        addr_out<=addr_out+1;
      end
    else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1)//798
      begin
        addr_out<=0;
      end
    else if(tt>`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1&&tt<`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH)//798,1053
      begin
        addr_out<=addr_out+1;
      end
    else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH)//1053
      begin
        addr_out<=addr_out+4;//input systematic[259~261]
      end
    else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1)//1054
      begin
        addr_out<=addr_out+1;
      end
    else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+1)//1055
      begin
        addr_out<=addr_out+1;
      end
    else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+1+1)//1056
      begin
        addr_out<=addr_out+1;
      end//
    else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+1+1)//1595
      begin
        addr_out <= 0;
      end
    else if(tt>`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+1+1&&tt<`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+1+1+1+`CODELENGTH+3+2)//1595,1857
      begin
        addr_out <= addr_out +1;
      end
    else
      begin
      end 
  end

   
  always@(posedge clk)
  begin
    if(tt==1)
      begin
        state3<=1;
		 
      end
    else
      begin
        state3<=0;
      end
  end
  
  
//  reg [10:0]l;
  always@(posedge clk)
  begin
    if(tt>`CODELENGTH*7+63+`CODELENGTH+20+1&&tt<`CODELENGTH*7+63+`CODELENGTH+20+`CODELENGTH+4+2)//2132,2393
      begin
        data_in_ext<=ext3;//ext_[tt-2133]<=ext3;
      end
    else if(tt>`CODELENGTH+16+`CODELENGTH+2+1+1+4&&tt<`CODELENGTH*2+20+`CODELENGTH+6+1+2)//536
      begin
        data_in_ext<=ext;//ext_[tt-538]<=ext;
      end
          
  end //systematic0
   
//above 1st log_map
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

  always @(posedge clk)
  begin
    case(tt)
//      1:
//      begin
//        a<=0;
//      end      
      `CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2://797
      begin
        state_pi<=1;
      end
      `CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1://798
      begin
        state_pi<=0;
        p<=0;
      end
      `CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17://1333
      begin
        state_pi<=1;
      end
      `CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1://1334
      begin
        state_pi<=0;
        p<=0;
      end
      `CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+2://1335
      begin
        state_pi_2<=1;
      end
      `CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+3://1336
      begin
        state_pi_2<=0;
      end      
//      `CODELENGTH*7+63+`CODELENGTH+20+`CODELENGTH+4+1://2392
//      begin
//        a<=a+1;
//      end
      
      default:
      begin
        p<=p+1;
      end
    endcase
  end
  
 always@(posedge clk)
   begin
   if(!rst)
	 begin
		a<=0;
	 end
	else if(a>6)
	 begin
		a<=7;
	 end
	else if(tt==`CODELENGTH*7+63+`CODELENGTH+20+`CODELENGTH+4+1)
	 begin
	   a<=a+1;
	 end
  end
 
 always @(posedge clk)
  begin
    case(tt)
      `CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+2://1335
      begin
        state_pi_3<=1;
      end
      `CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+3://1336
      begin
        state_pi_3<=0;
      end
      default:
      begin
      end
    endcase
  end
 
 
 
  always@(posedge clk)
  begin
    if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+2)//800
      begin
        state4<=1;
      end
    else
      begin
        state4<=0;
      end
  end
  
  always@(posedge clk)
  begin
    if(tt>`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+2&&tt<`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+1+1)//800,1057
      begin
        systematic2<=data_out_ext+ data_out_systematic;//systematic2<=ext_[pi]+ systematic_a[pi];
        data_in_systematic2<=data_out_ext+ data_out_systematic;//data_in_systematic2<=ext_[pi]+ systematic_a[pi];
      end
    else if(tt>`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+1&&tt<`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+1+4)//1056,1060
      begin
        systematic2<=0; 
        data_in_systematic2<=0;
      end//
    else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+3)//1336
      begin
        systematic2 <=data_out_systematic2;
      end
    else if(tt>`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+3&&tt<`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1)//1336,1593
      begin
        systematic2 <=data_out_systematic2;
        data_in_systematic1<=ext2+data_out_systematic;//systematic1_[pi] <= ext2+ systematic_a[pi];
      end
    else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1)//1593
      begin
        systematic2 <=data_out_systematic2;
        data_in_systematic1<=data_out_systematic;//systematic1_[257] <= systematic_a[257];//
      end                                                                    
    else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+1)//1594
      begin
        systematic2 <=data_out_systematic2;
        data_in_systematic1<=data_out_systematic;//systematic1_[258] <= systematic_a[258];//
      end
    else if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+1+1)//1595
      begin
        systematic2 <=data_out_systematic2;
        data_in_systematic1<=data_out_systematic;//systematic1_[258] <= systematic_a[258];//
      end 
  end
  
  //above 2nd log_map
 ///////////////////////////////////////////////////////////// 
 /////////////////////////////////////////////////////////////

  always@(posedge clk)
  begin
     if(tt>`CODELENGTH*7+63+`CODELENGTH+20+1&&tt<`CODELENGTH*7+63+`CODELENGTH+20+`CODELENGTH+4+1)//2132,2392
      begin
        systematic1<=data_out_systematic1;//systematic1<=systematic1_[tt-2132];
      end
    else if(tt>`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+1+1+2&&tt<`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+1+1+1+`CODELENGTH+3+2)//1597,1857
      begin
        systematic1<=data_out_systematic1;//systematic1<=systematic1_[tt-1597];
      end
  end
  
  always@(posedge clk)
  begin
    if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+1+1+2)//1597
      begin
        state5<=1;
      end
    else
      begin
        state5<=0;
      end
  end

  //above 3rd log_map
 //////////////////////////////////////////////////////////////
 ////////////////////////////////////////////////////////////// 
  
  reg sum;
  
  always@(posedge clk)
  begin
    if(a==5 && tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+2)//1335
      begin
        decoded_bytes[`CODELENGTH-1:0]<=0;//255
      end 
    else if(a==5 && tt>`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+3&&tt<`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1)//1336,1593
      begin
        case({systematic2[`BITLENGTH-1],ext2[`BITLENGTH-1]})
        2'b00:
        if(systematic2[`BITLENGTH-1:0]+ext2[`BITLENGTH-1:0]==16'h0000)
          begin
            sum=0;//
          end
        else
          begin
            sum=1;//
            decoded_bytes[(pi_3>>3)*8+(7-(pi_3&7))]<=1;
          end
        2'b01:
          begin
           if(systematic2[`BITLENGTH-1:0]+ext2[`BITLENGTH-1:0]==16'h0000)
          begin
            sum=0;//
          end
        else if(systematic2[`BITLENGTH-1:0]+ext2[`BITLENGTH-1:0]>16'h8000)
          begin
           sum=0;//
          end
        else
          begin
           sum=1;//
           decoded_bytes[(pi_3>>3)*8+(7-(pi_3&7))]<=1;
          end
        end              
        2'b10:
        begin
        if(systematic2[`BITLENGTH-1:0]+ext2[`BITLENGTH-1:0]==16'h0000)
          begin
            sum=0;
          end
        else if(systematic2[`BITLENGTH-1:0]+ext2[`BITLENGTH-1:0]>16'h8000)
          begin
           sum=0;//
          end
        else
          begin 
           sum=1;//
           decoded_bytes[(pi_3>>3)*8+(7-(pi_3&7))]<=1;
          end
        end        
        2'b11:
        begin
          sum=0;//
        end
        default:
        begin
          sum=0;//
        end
        endcase     
    end
  end
 
  always@(posedge clk)
  begin
/*    if(a==5&&tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+10+1)
		begin
			data_out <= 64'h5678;
		end
    else 
	 if(a==5&&tt>`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+10)
		begin
			data_out <= 64'h0000;
		end
	 else */
	 if(a==5)
	   begin
      case(tt)
        `CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+7://1600
        begin
          data_out <= decoded_bytes[63:0];
        end
        `CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+8://1601
        begin
          data_out <= decoded_bytes[127:64];
		  end
        `CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+9://1602
        begin
          data_out <= decoded_bytes[191:128];
        end
        `CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+10://1603
        begin
          data_out <= decoded_bytes[255:192];			 
        end
      endcase
		end
	else if(a==6)
		begin
			data_out <= 64'h0123;
		end
  end
  
  always@(posedge clk)
  begin
	if(a==5&&tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+7)
	 begin
		we_decode <= 1'b1;
	 end
	else if(a==5&&tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+12)//(a==7)
	 begin
		we_decode <= 1'b0;
	 end
  end
 

 
  reg [10:0]pp; 
  always@(posedge clk)
  begin
    if(tt==`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+7&&a==5)//1600
      begin
       pp=0;
       $display("%d ", decoded_bytes[8*(pp+1)-1-:8]);
      end 
    else if(tt>`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+7&&a==5&&tt<`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+6+1+2+1+`CODELENGTH+1+5+`CODELENGTH+17+1+`CODELENGTH+1+1+1+7+32) //1600,1632
       begin
       pp=pp+1;
       $display("%d ", decoded_bytes[8*(pp+1)-1-:8]);
       end  
  end

endmodule
