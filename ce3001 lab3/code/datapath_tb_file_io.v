// file_io.test
// test file for I/O functions
`include "datapath.v"
`timescale 1ns / 10ps
`define EOF 32'hFFFF_FFFF
`define NULL 0
`define MAX_LINE_LENGTH 1000
`define ISIZE 16
`define DSIZE 16

module datapath_tb_fileio;
    
  reg                        clk_half;
  reg                        clk;
  reg                        rst;
  
  reg                        InitSel;
  reg [`ISIZE-1:0]           Instruction;
  reg [`DSIZE-1:0]           DataInit;
  
  integer                    file_input, file_output , file_gold, c, r;
  reg [15:0]                 exp;
  reg [8*`MAX_LINE_LENGTH:0] line;
  wire [`DSIZE-1:0]          ALUOut;
  
  datapath datapath_inst (
                          .clk(clk),
                          .reset(rst),
                          .Instruction(Instruction),
                          .InitSel(InitSel),
                          .DataInit(DataInit),		                      
                          .ALUOut(ALUOut)
                          );
  
  // generate the clk
  always #5 clk = ~clk;
  // clk_half: divide the clk by 2
  always@(posedge clk)
    clk_half <= ~clk_half;
  
  
  
  initial
    begin
      file_input  = $fopen("input.txt","r");
      file_output = $fopen("output.txt","w");
      file_gold   = $fopen("gold.txt","r");
      clk = 0;
      clk_half =0;
      rst = 1;
      #5 rst = 0;
      #10 rst = 1;
      InitSel = 0;
      
      while (!$feof(file_input))
        begin
          c = $fgetc(file_input);
          // check for comment
          if (c == "/" | c == "#" | c == "%")
            r = $fgets(line, file_input);
          else
            begin
              // Push the character back to the file then read the next time
              r = $ungetc(c, file_input);
              r = $fscanf(file_input, "%h %h %b", Instruction, DataInit, InitSel);
            end
          #20; // 20ns for each iteration
        end // while (!$feof(file_input))
      
      $fclose(file_input);
      $fclose(file_gold);
      $fclose(file_output);
      #100 $finish;
    end	// end of initial
  
  
  always@(posedge clk_half)
    if (InitSel)
      begin
        $fwrite(file_output, "%h\n", ALUOut);
        r = $fscanf(file_gold, "%h\n", exp);
        if (ALUOut != exp)
          begin
            // $fdisplay(file_output, "Error: Got %h", ALUOut);
            $fdisplay(file_output, "Error: expected: %h\n", exp);
          end
        else
          $fdisplay(file_output, "Matched: %h", ALUOut);
      end
endmodule // datapath_tb_fileio

