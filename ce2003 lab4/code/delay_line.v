module delay_line(
                  input            clk,
                  input            rst,
                  input [7:0]      in_r,
                  input [7:0]      in_g,
                  input [7:0]      in_b,
                  input [2:0]      in_c,
                  output reg [7:0] out_r,
                  output reg [7:0] out_g,
                  output reg [7:0] out_b,
                  output reg [2:0] out_c
                  );
  
  reg [7:0]                        in_r_p1;
  reg [7:0]                        in_r_p2;
  reg [7:0]                        in_r_p3;
  reg [7:0]                        in_r_p4;
  reg [7:0]                        in_g_p1;
  reg [7:0]                        in_g_p2;
  reg [7:0]                        in_g_p3;
  reg [7:0]                        in_g_p4;
  reg [7:0]                        in_b_p1;
  reg [7:0]                        in_b_p2;
  reg [7:0]                        in_b_p3;
  reg [7:0]                        in_b_p4;
  reg [2:0]                        in_c_p1;
  reg [2:0]                        in_c_p2;
  reg [2:0]                        in_c_p3;
  reg [2:0]                        in_c_p4;
  //Generate delays to match with the latency required for YUV generation.
  always @(posedge clk) begin
    if(rst) begin
      in_r_p1 <=8'd0;
      in_r_p2 <= 8'd0;
      in_r_p3 <= 8'd0;
      in_r_p4 <= 8'd0;
      out_r <= 8'd0;
      
      in_g_p1 <=8'd0;
      in_g_p2 <= 8'd0;
      in_g_p3 <= 8'd0;
      in_g_p4 <= 8'd0;
      out_g <= 8'd0;
      
      in_b_p1 <=8'd0;
      in_b_p2 <= 8'd0;
      in_b_p3 <= 8'd0;
      in_b_p4 <= 8'd0;
      out_b <= 8'd0;
      
      in_c_p1 <=8'd0;
      in_c_p2 <= 8'd0;
      in_c_p3 <= 8'd0;
      in_c_p4 <= 8'd0;
      out_c <= 8'd0;
    end else begin
      in_r_p1 <= in_r;
      in_r_p2 <= in_r_p1;
      in_r_p3 <= in_r_p2;
      in_r_p4 <= in_r_p3;
      out_r   <= in_r_p3;
		  
      in_g_p1 <= in_g;
      in_g_p2 <= in_g_p1;
      in_g_p3 <= in_g_p2;
      in_g_p4 <= in_g_p3;
      out_g   <= in_g_p4;
      
      in_b_p1 <= in_b;
      in_b_p2 <= in_b_p1;
      in_b_p3 <= in_b_p2;
      in_b_p4 <= in_b_p3;
      out_b   <= in_b_p4;
      
      in_c_p1 <= in_c;
      in_c_p2 <= in_c_p1;
      in_c_p3 <= in_c_p2;
      in_c_p4 <= in_c_p3;
      out_c   <= in_c_p4;
    end // else: !if(rst)
  end // always @ (posedge clk)
endmodule // delay_line

