module Control_tb();
  reg [3:0] control_input;
  wire WriteEn;
  wire [2:0] ALUOp;
  
  Control C0(
             control_input,
             WriteEn,
             ALUOp
             );
  
  initial
    begin
      control_input = 0;
      #10 control_input = 4'b1010;
      #10 control_input = 4'b1100;
      repeat (10) begin
        #10 control_input = $random;
      end
      #10 $finish;
    end
endmodule // Control_tb
