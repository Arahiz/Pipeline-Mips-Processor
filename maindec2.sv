module maindec2(input logic [5:0] op,
               output logic regwrited, memtoregd, memwrited, 
               alusrcd, regdstd, branchd,
               output logic [1:0] aluop);
  logic [7:0] controls;
  assign {regwrited, memtoregd, memwrited, alusrcd, regdstd, branchd, aluop} = controls;
  always_comb
    case(op)
      6'b000000: controls <= 8'b10001010; // RTYPE
      6'b100011: controls <= 8'b11010000; // LW
      6'b101011: controls <= 8'b00110000; // SW
      6'b000100: controls <= 8'b00000101; // BEQ
      6'b001000: controls <= 8'b10010000; // ADDI
      default: controls <= 8'bxxxxxxxx; // illegal op
    endcase
endmodule
