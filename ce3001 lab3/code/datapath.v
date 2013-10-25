module datapath(input [15:0] Instruction, DataInit, input InitSel, input clk, reset, output [15:0] ALUOut);

  wire [15:0] WData;
  wire [15:0] RData1, RData2;
  wire [3:0] RAddr1, RAddr2, WAddr;
  wire [2:0] ALUop;
  wire Wen;
  
  
  assign  RAddr1 = Instruction[7:4];
  assign  RAddr2 = Instruction[3:0];
  assign  WAddr = Instruction[11:8];
  assign  WData = InitSel ? ALUOut : DataInit;
  
  Control Con(.ControlInput(Instruction[15:12]), .WriteEn(Wen), .ALUop(ALUop));
  Reg_File Reg(.RAddr1(RAddr1), .RAddr2(RAddr2), .WAddr(WAddr), .WData(WData),
               .Wen(Wen), .Clock(clk), .Reset(reset), .RData1(RData1), .RData2(RData2)); 
  alu a0(.A(RData1), .B(RData2), .op(ALUop), .out(ALUOut), .imm(RAddr2));
endmodule
