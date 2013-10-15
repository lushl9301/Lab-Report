`define RSIZE 4
`define DSIZE 16
`timescale 1ns / 100ps

module RF_tb ();
  reg clk;
  reg rst;
  reg wen;
  reg [`RSIZE-1:0] RAddr1;
  reg [`RSIZE-1:0] RAddr2;
  reg [`RSIZE-1:0] WAddr;
  reg [`DSIZE-1:0] WData;
  
  wire [`DSIZE-1:0] RData1;
  wire [`DSIZE-1:0] RData2;
  integer           i;    
  Reg_File RF_inst (
                    .Clock(clk), .Reset(rst), .Wen(wen),
                    .RAddr1(RAddr1), .RAddr2(RAddr2),
                    .WAddr(WAddr), .WData(WData),
                    .RData1(RData1), .RData2(RData2)
                    );
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    rst = 1;
    wen = 0;
    #5 rst = 0;
    #10 rst = 1;
    wen = 1;

    // write to RF
    for (i=0; i<16; i=i+1) begin
      #5 WAddr = i;
      WData = i+16;
      #10 $display("Writing: WAddr=%h, WData=%h\n",WAddr ,WData);
    end
    $display("=============================");
    // read from RF
    for (i=0; i<16; i=i+2)
      begin
        #5 RAddr1 = i;
        RAddr2 = i+1;
        #10 $display("Reading: RData1=%h, RData2=%h\n",RData1, RData2);
      end
    $display("=============================");
    for (i=0; i<14; i=i+2)
      begin
        #5 RAddr1 = i;
        RAddr2 = i+1;
        WAddr = i+2;
        WData = 5;
        #10 $display("Reading: RData1=%h, RData2=%h\n",RData1, RData2);
      end
    #1000 $finish;
  end
endmodule // end of RF_tb
