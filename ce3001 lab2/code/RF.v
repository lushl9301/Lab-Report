module Reg_File (RAddr1, RAddr2, WAddr, WData,
                 Wen, Clock, Reset, RData1, RData2);
  input [3:0]  RAddr1;
  input [3:0]  RAddr2;
  input [3:0]  WAddr;
  input [15:0] WData;
  input        Wen, Clock, Reset;
  
  output reg [15:0] RData1, RData2;
  reg [15:0]        regFile [0:15];
  integer           i;
  
  always @(!Reset) begin
    for (i = 0; i < 8; i = i + 1) begin
      regFile[i] <= 16'b0;
    end
  end
  
  always @(posedge Clock) begin
    if (Reset) begin
      if (Wen) regFile[WAddr] <= WData;
      regFile[0] = 0;    
      RData1 = regFile[RAddr1];
      RData2 = regFile[RAddr2];
    end
  end
endmodule // Reg_File