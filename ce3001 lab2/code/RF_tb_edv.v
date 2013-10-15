// testbench for Register File module
`include "RF.v"
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

Reg_File RF_inst (
		.Clock(clk),
		.Reset(rst),
		.Wen(wen),
		.RAddr1(RAddr1),
		.RAddr2(RAddr2),
		.WAddr(WAddr),
		.WData(WData),

		.RData1(RData1),
		.RData2(RData2)
		);

always #5 clk = ~clk;

integer i;
initial
begin
	clk = 0;
	rst = 1;
	wen = 0;
#5	rst = 0;
#10	rst = 1;
	wen = 1;

// write to RF
for (i=0; i<16; i=i+1)
begin
#2	WAddr = i;
	WData = i+16;
#8	$display("Writing: WAddr=%h, WData=%h\n",i ,i);
end

// read from RF
for (i=0; i<16; i=i+2)
begin
#2	RAddr1 = i;
	RAddr2 = i+1;
#8	$display("Reading: RData1=%h, RData2=%h\n",RData1, RData2);
end

#1000	$finish;

end

endmodule // end of RF_tb
