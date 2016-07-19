`define CODELENGTH 256
`define ADDRLENGTH 9
`define DATALENGTH 64
`define BITLENGTH 16
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:17:29 06/06/2016 
// Design Name: 
// Module Name:    log_map_memory 
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
module log_map_memory(
clk,
systematic,
yparity,
ext,
state3
);


  input clk;
  input state3;
  input [`BITLENGTH-1:0]systematic;
  input [`BITLENGTH-1:0]yparity;
  output [`BITLENGTH-1:0]ext;
  
  reg [20:0]ii; //counter1
  reg state,state1,state2;
  
  
  reg wen;
  reg [`DATALENGTH-1:0]data_in_gamma;
  wire [`DATALENGTH-1:0]data_out_gamma;
  reg [`ADDRLENGTH-1:0]addr_in_gamma;
  
  reg wen2;
  reg [`DATALENGTH-1:0]data_in_alpha1;
  reg [`DATALENGTH-1:0]data_in_alpha2;
  wire [`DATALENGTH-1:0]data_out_alpha1;
  wire [`DATALENGTH-1:0]data_out_alpha2;
  reg [`ADDRLENGTH-1:0]addr_in_alpha;

  reg wen3;
  reg [`DATALENGTH-1:0]data_in_beta1;
  reg [`DATALENGTH-1:0]data_in_beta2;
  wire [`DATALENGTH-1:0]data_out_beta1;
  wire [`DATALENGTH-1:0]data_out_beta2;
  reg [`ADDRLENGTH-1:0]addr_in_beta;
  
  wire [`BITLENGTH-1:0]m11,m10,m00,m01;
  reg [`BITLENGTH-1:0]m11t,m10t,m00t,m01t;
  reg [`BITLENGTH-1:0]m11tb,m10tb,m00tb,m01tb;
  reg [`BITLENGTH-1:0]m11b,m10b,m00b,m01b;
  wire [`BITLENGTH-1:0]alpha0,alpha1,alpha2,alpha3,alpha4,alpha5,alpha6,alpha7;
  wire [`BITLENGTH-1:0]alpha0t,alpha1t,alpha2t,alpha3t,alpha4t,alpha5t,alpha6t,alpha7t;
  wire [`BITLENGTH-1:0]beta0t,beta1t,beta2t,beta3t,beta4t,beta5t,beta6t,beta7t;
  wire [`BITLENGTH-1:0]beta0,beta1,beta2,beta3,beta4,beta5,beta6,beta7;
  reg [`BITLENGTH-1:0]m11e,m10e,m00e,m01e;
  reg [`BITLENGTH-1:0]alpha0e,alpha1e,alpha2e,alpha3e,alpha4e,alpha5e,alpha6e,alpha7e;
  reg [`BITLENGTH-1:0]beta0e,beta1e,beta2e,beta3e,beta4e,beta5e,beta6e,beta7e;
  reg [`BITLENGTH-1:0] old0, old1, old2, old3, old4, old5, old6, old7;
  reg [`BITLENGTH-1:0] old0b, old1b, old2b, old3b, old4b, old5b, old6b, old7b;
  
//  reg cen2;


blk_mem_gen_1 gamma_memory(
    .clka(clk),
    .ena(1'b1),
    .wea(wen),
    .addra(addr_in_gamma),
    .dina(data_in_gamma),
    .douta(data_out_gamma)
    );
 
  compute_gamma_s gamma_s(
.m11(m11),
.m10(m10),
.m00(m00),
.m01(m01),
.systematic(systematic),
.yparity(yparity)
);


blk_mem_gen_1 alpha_memory1(
    .clka(clk),
    .ena(1'b1),
    .wea(wen2),
    .addra(addr_in_alpha),
    .dina(data_in_alpha1),
    .douta(data_out_alpha1)
    );
    
blk_mem_gen_1 alpha_memory2(
        .clka(clk),
        .ena(1'b1),
        .wea(wen2),
        .addra(addr_in_alpha),
        .dina(data_in_alpha2),
        .douta(data_out_alpha2)
        );

  compute_alpha_s alpha_s(
.clk(clk),
.state3(state3),
.m00(m00),
.m01(m01),
.m10(m10),
.m11(m11),
.alpha0(alpha0),
.alpha1(alpha1),
.alpha2(alpha2),
.alpha3(alpha3),
.alpha4(alpha4),
.alpha5(alpha5),
.alpha6(alpha6),
.alpha7(alpha7)
);

  compute_alpha_termination alpha_termination(
.clk(clk),
.state(state),
.m00(m00t),
.m01(m01t),
.m10(m10t),
.m11(m11t),
.alpha0(alpha0t),
.alpha1(alpha1t),
.alpha2(alpha2t),
.alpha3(alpha3t),
.alpha4(alpha4t),
.alpha5(alpha5t),
.alpha6(alpha6t),
.alpha7(alpha7t),
.old0(old0),
.old1(old1),
.old2(old2),
.old3(old3),
.old4(old4),
.old5(old5),
.old6(old6),
.old7(old7)
);

blk_mem_gen_1 beta_memory1(
    .clka(clk),
    .ena(1'b1),
    .wea(wen3),
    .addra(addr_in_beta),
    .dina(data_in_beta1),
    .douta(data_out_beta1)
    );
    
 blk_mem_gen_1 beta_memory2(
        .clka(clk),
        .ena(1'b1),
        .wea(wen3),
        .addra(addr_in_beta),
        .dina(data_in_beta2),
        .douta(data_out_beta2)
        );

  compute_beta_termination beta_termination(
.clk(clk),
.state1(state1),
.m00(m00tb),
.m01(m01tb),
.m10(m10tb),
.m11(m11tb),
.beta0(beta0t),
.beta1(beta1t),
.beta2(beta2t),
.beta3(beta3t),
.beta4(beta4t),
.beta5(beta5t),
.beta6(beta6t),
.beta7(beta7t)
);

  compute_beta_s beta_s(
.clk(clk),
.state2(state2),
.m00(m00b),
.m01(m01b),
.m10(m10b),
.m11(m11b),
.beta0(beta0),
.beta1(beta1),
.beta2(beta2),
.beta3(beta3),
.beta4(beta4),
.beta5(beta5),
.beta6(beta6),
.beta7(beta7),
.old0(old0b),
.old1(old1b),
.old2(old2b),
.old3(old3b),
.old4(old4b),
.old5(old5b),
.old6(old6b),
.old7(old7b)
);

  compute_ext_s ext_s(
.clk(clk),
.m00(m00e),
.m01(m01e),
.m10(m10e),
.m11(m11e),
.beta0(beta0e),
.beta1(beta1e),
.beta2(beta2e),
.beta3(beta3e),
.beta4(beta4e),
.beta5(beta5e),
.beta6(beta6e),
.beta7(beta7e),
.alpha0(alpha0e),
.alpha1(alpha1e),
.alpha2(alpha2e),
.alpha3(alpha3e),
.alpha4(alpha4e),
.alpha5(alpha5e),  
.alpha6(alpha6e),
.alpha7(alpha7e),
.ext(ext),
.systematic(systematic)
);
  
  
always@(posedge clk)
begin
  if(state3==1)
    begin
      ii <= 0;
    end
  else
    begin
      ii <= ii+1;
    end
end

always@(posedge clk)
begin
  if(state3==1)
    begin
      wen <= 1;
      wen2 <= 1;
    end
  else if(ii==`CODELENGTH+3)//259
    begin
      wen2 <= 0;
      wen <= 0;
    end
  else if(ii==`CODELENGTH+6)//262
    begin
      wen2 <= 1'b1;
    end
  else if(ii==`CODELENGTH+11)//267
    begin
      wen3 <= 1'b1;
    end
  else if(ii==`CODELENGTH+16+`CODELENGTH+2+1)//531
    begin
      wen <= 1'b0;
      wen2 <= 1'b0;
      wen3 <= 1'b0;
    end
  else
    begin
    end
end

always@(posedge clk)
begin
  if(ii==0)     
    begin    
      addr_in_gamma <= 0;
      data_in_gamma <= {m00,m01,m10,m11};
    end
  else if(ii<`CODELENGTH+3)//259 256+3 systematics,yparitys
    begin
      addr_in_gamma <= addr_in_gamma+1;
      data_in_gamma <= {m00,m01,m10,m11};
    end
  else if(ii==`CODELENGTH+3)//259
    begin
      addr_in_gamma <= `CODELENGTH;//256
    end
  else if(ii<`CODELENGTH+6)//262
    begin
      addr_in_gamma <= addr_in_gamma+1;
    end 
  else if(ii==`CODELENGTH+6+1+1) //264   
    begin
      addr_in_gamma <= `CODELENGTH+2;//258
    end
  else if(ii>`CODELENGTH+6+1+1&&ii<`CODELENGTH+6+1+1+3) //264,267
    begin
      addr_in_gamma <= addr_in_gamma-1;
    end
  else if(ii>`CODELENGTH+6+1+1+4&&ii<`CODELENGTH+12+`CODELENGTH+1)  //268,525
    begin
      addr_in_gamma <= addr_in_gamma-1;
    end
  else if(ii==`CODELENGTH+16+`CODELENGTH+2+1+1) //532
    begin
      addr_in_gamma <= 0;
    end
  else if(ii>`CODELENGTH+16+`CODELENGTH+2+1+1&&ii<`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+3) //532,791
    begin
      addr_in_gamma <= addr_in_gamma+1;
    end
  else
    begin
    end 
end


always @(posedge clk )
  begin
    case (ii)
      `CODELENGTH+3://259
      state <= 1'b1;
      `CODELENGTH+5://261
      state <= 1'b0;
      `CODELENGTH+9://265
      state1 <= 1'b1;
      `CODELENGTH+10://266
      state1 <= 1'b0;
      `CODELENGTH+14://270:
      state2 <= 1'b1;
      `CODELENGTH+15://271:
      state2 <= 1'b0;
      default:
      begin
      end
    endcase
  end 

always@(posedge clk)
  begin
    if(ii==0)     
    begin    
      addr_in_alpha <= 0;
      data_in_alpha2 <= {alpha0,alpha1,alpha2,alpha3};
      data_in_alpha1 <= {alpha4,alpha5,alpha6,alpha7};
    end
  else if(ii<`CODELENGTH+1)//257
    begin
      addr_in_alpha <= addr_in_alpha+1;
      data_in_alpha2 <= {alpha0,alpha1,alpha2,alpha3};
      data_in_alpha1 <= {alpha4,alpha5,alpha6,alpha7};
    end
  else if(ii>`CODELENGTH+2&&ii<`CODELENGTH+10)//258,266
    begin
      case(ii)
        `CODELENGTH+3://259
        begin
           addr_in_alpha <= `CODELENGTH;//256
        end
        `CODELENGTH+7://263
        begin
          addr_in_alpha <= addr_in_alpha+1;
          data_in_alpha2 <= {alpha0t,alpha1t,alpha2t,alpha3t};
          data_in_alpha1 <= {alpha4t,alpha5t,alpha6t,alpha7t};
        end
        `CODELENGTH+8://264
        begin
          addr_in_alpha <= addr_in_alpha+1;
          data_in_alpha2 <= {alpha0t,alpha1t,alpha2t,alpha3t};
          data_in_alpha1 <= {alpha4t,alpha5t,alpha6t,alpha7t};
        end
        `CODELENGTH+9://265
        begin
          addr_in_alpha <= addr_in_alpha+1;
          data_in_alpha2 <= {alpha0,alpha1,alpha2,alpha3};
          data_in_alpha1 <= {alpha4,alpha5,alpha6,alpha7};
        end       
        default:
        begin
        end        
      endcase
    end
  else if(ii==`CODELENGTH+16+`CODELENGTH+2+1)//531
    begin
      addr_in_alpha <= 0;
    end
  else if(ii>`CODELENGTH+16+`CODELENGTH+2+1&&ii<`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+3)//531,791
    begin
      addr_in_alpha <= addr_in_alpha+1;
    end
  else
    begin
    end
  end

always@(posedge clk)
  begin
    case (ii)
      `CODELENGTH+3://259
      begin        
        old0 <= data_out_alpha2[63:48];
	      old1 <= data_out_alpha2[47:32];
	      old2 <= data_out_alpha2[31:16]; 
	      old3 <= data_out_alpha2[15:0];
	      old4 <= data_out_alpha1[63:48]; 
	      old5 <= data_out_alpha1[47:32];
	      old6 <= data_out_alpha1[31:16]; 
	      old7 <= data_out_alpha1[15:0];	      
      end
      `CODELENGTH+5://261
      begin
        m11t <= data_out_gamma[15:0];
        m10t <= data_out_gamma[31:16];
        m01t <= data_out_gamma[47:32];
        m00t <= data_out_gamma[63:48];
      end
      `CODELENGTH+6://262
      begin
        m11t <= data_out_gamma[15:0];
        m10t <= data_out_gamma[31:16];
        m01t <= data_out_gamma[47:32];
        m00t <= data_out_gamma[63:48];        
      end
      `CODELENGTH+7://263
      begin
        m11t <= data_out_gamma[15:0];
        m10t <= data_out_gamma[31:16];
        m01t <= data_out_gamma[47:32];
        m00t <= data_out_gamma[63:48];
      end
      `CODELENGTH+10://266
      begin                
        m11tb <= data_out_gamma[15:0];
        m10tb <= data_out_gamma[31:16];
        m01tb <= data_out_gamma[47:32];
        m00tb <= data_out_gamma[63:48];        
      end
      `CODELENGTH+11://267
      begin
        m11tb <= data_out_gamma[15:0];
        m10tb <= data_out_gamma[31:16];
        m01tb <= data_out_gamma[47:32];
        m00tb <= data_out_gamma[63:48];        
      end
      `CODELENGTH+12://268
      begin
        m11tb <= data_out_gamma[15:0];
        m10tb <= data_out_gamma[31:16];
        m01tb <= data_out_gamma[47:32];
        m00tb <= data_out_gamma[63:48];
      end
       `CODELENGTH+14://270
      begin
        old0b <= beta0t;
	      old1b <= beta1t;
	      old2b <= beta2t; 
        old3b <= beta3t;
        old4b <= beta4t; 
        old5b <= beta5t;
        old6b <= beta6t; 
        old7b <= beta7t;
      end
      default:
      begin 
      end 
    endcase
  end
  
always @(posedge clk )
begin
  if(ii==`CODELENGTH+11)//267
      begin
        addr_in_beta <= `CODELENGTH+3; //259     
        data_in_beta2 <= {beta0t,beta1t,beta2t,beta3t};
        data_in_beta1 <= {beta4t,beta5t,beta6t,beta7t};
      end      
    else if(ii>`CODELENGTH+11&&ii<`CODELENGTH+15)//267,271
      begin
        addr_in_beta <= addr_in_beta - 1;
        data_in_beta2 <= {beta0t,beta1t,beta2t,beta3t};
        data_in_beta1 <= {beta4t,beta5t,beta6t,beta7t};
      end


    else if(ii==`CODELENGTH+16+`CODELENGTH+2+1)//531
      begin
        addr_in_beta <= 1;
      end
    else if(ii>`CODELENGTH+16+`CODELENGTH+2+1&&ii<`CODELENGTH+16+`CODELENGTH+2+1+1+`CODELENGTH+2)//531,790
      begin
        addr_in_beta <= addr_in_beta+1;
      end//
      
      
   else if(ii==`CODELENGTH+15)//271
    begin
      m11b <= data_out_gamma[15:0];
      m10b <= data_out_gamma[31:16];
      m01b <= data_out_gamma[47:32];
      m00b <= data_out_gamma[63:48];
    end
    else if(ii==`CODELENGTH+16)//272
    begin
      m11b <= data_out_gamma[15:0];
      m10b <= data_out_gamma[31:16];
      m01b <= data_out_gamma[47:32];
      m00b <= data_out_gamma[63:48];
    end
    else if(ii>`CODELENGTH+16 && addr_in_beta>=0 && ii<`CODELENGTH+16+`CODELENGTH+2)//272,530
    begin
      m11b <= data_out_gamma[15:0];
      m10b <= data_out_gamma[31:16];
      m01b <= data_out_gamma[47:32];
      m00b <= data_out_gamma[63:48];     
      addr_in_beta <= addr_in_beta - 1;
      data_in_beta2 <= {beta0,beta1,beta2,beta3};
      data_in_beta1 <= {beta4,beta5,beta6,beta7};
    end
    else
      begin
      end
end 


always @(posedge clk)
  begin
    if(ii>`CODELENGTH+16+`CODELENGTH+2+1+1&&ii<`CODELENGTH*2+20+`CODELENGTH+6+1)//532,795
      begin
        m11e <= data_out_gamma[15:0];
        m10e <= data_out_gamma[31:16];
        m01e <= data_out_gamma[47:32];
        m00e <= data_out_gamma[63:48];
        alpha0e <= data_out_alpha2[63:48];
        alpha1e <= data_out_alpha2[47:32];
        alpha2e <= data_out_alpha2[31:16];
        alpha3e <= data_out_alpha2[15:0];
        alpha4e <= data_out_alpha1[63:48];
        alpha5e <= data_out_alpha1[47:32];
        alpha6e <= data_out_alpha1[31:16];
        alpha7e <= data_out_alpha1[15:0];
        beta0e <= data_out_beta2[63:48];
        beta1e <= data_out_beta2[47:32];
        beta2e <= data_out_beta2[31:16];
        beta3e <= data_out_beta2[15:0];
        beta4e <= data_out_beta1[63:48];
        beta5e <= data_out_beta1[47:32];
        beta6e <= data_out_beta1[31:16];
        beta7e <= data_out_beta1[15:0];        
      end
    else
      begin
      end
  end 


endmodule
