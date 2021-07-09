module top2(input logic clk, reset);
  
 logic [31:0] instrf, readdatam, pcf, writedatam, aluoutm;
 logic regwritew, memwritem;
// instantiate processor and memories
  mips2 mips(clk, reset, 
            instrf, readdatam, 
            pcf, aluoutm, writedatam,
            regwritew, memwritem);
  imem imem(pcf[7:2], instrf);
  dmem dmem(clk, memwritem, aluoutm, writedatam, readdatam);
endmodule
