`timescale 1ns / 1ps
module rgbyuv(
              input               clk,
              input               rst,
              input signed [17:0] i_red,
              input signed [17:0] i_grn,
              input signed [17:0] i_blu,
              output reg [7:0]    o_y,
              output reg [7:0]    o_u,
              output reg [7:0]    o_v,
              output reg          skind
              );

  reg signed [17:0]               red_r, grn_r, blu_r;
  reg signed [35:0]               ry, gy, by, ru, gu, bu, rv, gv, bv;
  reg signed [35:0]               ry1, ru1, rv1, ry2, ru2, rv2, ry3, ru3, rv3;
  reg [7:0]                       p_y, p_u, p_v;

  parameter signed [17:0]	
    RY_COEF = 'd66, GY_COEF = 'd129, BY_COEF = 'd25,
    RU_COEF = -'d38, GU_COEF = -'d74, BU_COEF = 'd112,
    RV_COEF = 'd112, GV_COEF = -'d94, BV_COEF = -'d18;
  
  always @(posedge clk) begin
    if(rst) begin
      red_r <= 18'd0;
      grn_r <= 18'd0;
      blu_r <= 18'd0;
      o_y <= 8'd0;
      o_u <= 8'd0;
      o_v <= 8'd0;
    end else begin
      red_r <= i_red;
      grn_r <= i_grn;
      blu_r <= i_blu;
      //ry <= RY_COEF * red_r + GY_COEF * grn_r + BY_COEF * blu_r;
      //ru <= RU_COEF * red_r + GU_COEF * grn_r + BU_COEF * blu_r;
      //rv <= RV_COEF * red_r + GV_COEF * grn_r + BV_COEF * blu_r;
      ry1 <= RY_COEF * red_r;
      ry2 <= GY_COEF * grn_r;
      ry3 <= BY_COEF * blu_r;
      ru1 <= RU_COEF * red_r;
      ru2 <= GU_COEF * grn_r;
      ru3 <= BU_COEF * blu_r;
      rv1 <= RV_COEF * red_r;
      rv2 <= GV_COEF * grn_r;
      rv3 <= BV_COEF * blu_r;
      ry <= ry1 + ry2 + ry3;
      ru <= ru1 + ru2 + ru3;
      rv <= rv1 + rv2 + rv3;
      p_y <= (ry >>> 8) + 16;
      p_u <= (ru >>> 8) + 128;
      p_v <= (rv >>> 8) + 128;
      o_y <= p_y; o_u <= p_u; o_v <= p_v;
    end
  end // always @ (posedge clk)
  
  always @(posedge clk) begin
    if (rst) begin
      skind <= 1'b0;
    end else begin
      if (73 <= p_u && p_u <= 122 && 132 <= p_v && p_v <= 173) begin
        skind <= 1'b1;
      end else begin
        skind <= 1'b0;
      end
    end
  end // always @ (posedge clk)
endmodule // rgbyuv

