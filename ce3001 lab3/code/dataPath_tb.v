module dataPath_tb();
  reg [15:0] Instruction, DataInit;
  reg InitSel, clk, reset;
  wire [15:0] ALUOut;
  datapath dp1(.Instruction(Instruction),
                     .DataInit(DataInit),
                     .InitSel(InitSel),
                     .clk(clk),
                     .reset(reset),
                     .ALUOut(ALUOut)
                     );
  always #5 clk = ~clk;
  initial begin
    reset = 0;
    clk = 0;
    #20 reset = 1;
    repeat (10000) begin
      #10 InitSel = 0;
      {DataInit, Instruction} = $random;
    end
    repeat (15) begin
      {Instruction, DataInit} = $random;
      InitSel = $random;
      #10 $display("Instruction = %b, ALUOut = %b", Instruction, ALUOut);
    end
    $finish;
  end // initial begin
endmodule // dataPath_tb
