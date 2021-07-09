module mips2(input logic clk,reset,
             input logic [31:0] instrf, readdatam,
             output logic [31:0] pcf, aluoutm, writedatam,
             output logic regwritew, memwritem);
logic pcsrcd0, pcsrcd, stallf, stalld, flushe, flushetoc, regdste, forwardad,forwardbd, alusrcbe, memtoregw,equald;
logic [1:0] forwardae,forwardbe;
logic [2:0] alucontrole;
logic [31:0]instrd;
logic [4:0] rsdtobp, rtdtobp, rsetobp,rtetobp, writeregetobp, writeregmtobp,writeregwtobp;
logic branchdtobp,regwriteetobp, memtoregetobp, regwritemtobp, memtoregmtobp, regwritewtobp;
assign flushetoc = flushe;

 datapath2 dp(clk, reset,pcsrcd0, pcsrcd, stallf, stalld, regwritew, 
              flushe, regdste, forwardad,forwardbd, alusrcbe, memtoregw, 
              forwardae,forwardbe,
              alucontrole, 
              instrf, readdatam,
              equald,
              rsdtobp, rtdtobp, rsetobp,rtetobp, writeregetobp, writeregmtobp,writeregwtobp,
              pcf, aluoutm, writedatam, instrd);

 controller2 contr(clk,instrd[31:26], instrd[5:0], 
                   equald, flushetoc,
                   pcsrcd0, pcsrcd, regdste,alusrcbe,memwritem, regwritew, memtoregw,
                   branchdtobp,regwriteetobp, memtoregetobp, regwritemtobp, memtoregmtobp, regwritewtobp,
                   alucontrole);
 bypass hazard(branchdtobp, regwriteetobp, memtoregetobp, regwritemtobp,
               memtoregmtobp, regwritewtobp,
               rsdtobp, rtdtobp, rsetobp,rtetobp, writeregetobp, writeregmtobp,writeregwtobp,
               stallf, stalld, flushe, forwardad, forwardbd,
               forwardae, forwardbe);

endmodule
