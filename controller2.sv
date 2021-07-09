module controller2(input clk,
                   input logic [5:0] op, funct,
                   input logic equald,flushe,
                   output logic pcsrcd0, pcsrcd, regdste,alusrcbe,memwritem, regwritew, memtoregw,
                   branchdtobp,regwriteetobp, memtoregetobp, regwritemtobp, memtoregmtobp, regwritewtobp,
                   output [2:0] alucontrole);
  logic [1:0] aluop;
  logic [2:0] alucontrold;
  logic regwrited, memtoregd,  memwrited, alusrcbd, regdstd, branchd,regwritee,memtorege, memwritee, regwritem,memtoregm;  
  assign pcsrcd0= pcsrcd;
  assign branchdtobp = branchd;  
  assign regwriteetobp = regwritee;
  assign memtoregetobp = memtorege;
  assign regwritemtobp = regwritem;
  assign memtoregmtobp = memtoregm;
  assign regwritewtobp = regwritew;
  always_comb
   begin
   if (branchd&equald) pcsrcd = 1'b1;
   else pcsrcd = 1'b0;
   end
  maindec2 md(op, regwrited, memtoregd,  memwrited,
             alusrcbd, regdstd, branchd, aluop);
  aludec2 ad(funct, aluop, alucontrold);
  flopu #(8) controllrege(clk,1'b0,flushe,1'b1,{regwrited,memtoregd, memwrited,alucontrold, alusrcbd, regdstd}, {regwritee,memtorege, memwritee,alucontrole, alusrcbe, regdste}); 
  flopu #(3) controllregm(clk,1'b0,1'b0,1'b1,{regwritee,memtorege, memwritee}, {regwritem,memtoregm, memwritem}); 
  flopu #(3) controllregw(clk,1'b0,1'b0,1'b1,{regwritem,memtoregm}, {regwritew,memtoregw}); 

endmodule 