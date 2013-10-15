module alu_tb;
  reg [15:0] A, B;
  reg [2:0] op;
  reg [3:0] imm;
  
  wire [15:0] out;
  
  alu alu0(.A(A), .B(B), .op(op), .out(out), .imm(imm));
  
  initial
    begin
      A = 16'd0; B = 16'd0; op = 3'b000; imm = 4'd0;
      #10 A = 16'h130f; B = 16'h5701; op = 3'b000;
      #10 A = 16'hfedc; B = 16'hab98; op = 3'b001;
      #10 A = 16'hcdef; B = 16'h89ab; op = 3'b010;
      #10 A = 16'hcdef; B = 16'h89ab; op = 3'b011;
      #10 A = 16'hb042; imm = 4'd1; op = 3'b100;
      #10 A = 16'hb042; imm = 4'd1; op = 3'b101;
      #10 A = 16'hb742; imm = 4'd4; op = 3'b110;
      #10 A = 16'hb742; imm = 4'd4; op = 3'b111;
      
      #10 $finish;
    end
endmodule
