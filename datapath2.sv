module datapath2(input logic clk, reset,
                 input logic pcsrcd0, pcsrcd, stallf, stalld, regwritew, 
                 flushe, regdste, forwardad,forwardbd, alusrcbe, memtoregw,
                 input logic [1:0] forwardae,forwardbe,
                 input logic [2:0] alucontrole,  
                 input logic [31:0] instrf, readdatam,
                 output logic equald,
                 output logic [4:0] rsdtobp, rtdtobp, rsetobp,rtetobp, writeregetobp, writeregmtobp,writeregwtobp,
                 output logic [31:0] pcf, aluoutm, writedatam, instrd);
logic [31:0] pc, pcftoadd4, pcplus4f, pcplus4tod, pcbranchd, pcplus4dreg, pcplus4d, rdd1, rdd2,
rdd1tomux, rdd2tomux,ratocmp, rbtocmp, aluoutmtod, aluoutmtoda, aluoutmtodb, signimmd,signimmdtosl2,sl2d1res,
rde1, rde2,signimme,resultw, aluoute, aluoutmtoea, aluoutmtoeb, resultwtoea, resultwtoeb, srcae, srcbe0, srcbe, writedatae, aluoutmtow,
readdataw, aluoutw;
logic [4:0] rsd, rtd, rdd, rse, rte, rde, writerege,  writeregm, writeregw;
logic zero;

assign rsd = instrd[25:21];
assign rtd = instrd[20:16];
assign rdd = instrd[15:11];
assign rdd1tomux = rdd1;
assign rdd2tomux = rdd2;
assign pcftoadd4 = pcf;
assign pcplus4tod = pcplus4f;
assign aluoutmtod = aluoutm;
assign aluoutmtoda = aluoutmtod;
assign aluoutmtodb = aluoutmtod;
assign signimmdtosl2 = signimmd;
assign rsdtobp = rsd;
assign rtdtobp = rtd;
assign rsetobp = rse;
assign rtetobp = rte;
assign writeregetobp = writerege;
assign aluoutmtoea = aluoutmtod;
assign aluoutmtoeb = aluoutmtod;
assign resultwtoea = resultw;
assign resultwtoeb = resultw;
assign writedatae = srcbe0;
assign writeregmtobp = writeregm;
assign aluoutmtow = aluoutmtod;
assign writeregwtobp = writeregw;

//fetch logic
flopu #(32) pcregf(clk, reset, 1'b0, stallf, pc, pcf);
adder pcaddf (pcftoadd4, 32'b100, pcplus4f);
mux2 #(32) muxpcf(pcplus4f, pcbranchd, pcsrcd0, pc);
//decode logic
flopu #(32) instrregd(clk,1'b0,pcsrcd,stalld, instrf, instrd);
flopu #(32) pcplus4fregd(clk,1'b0,pcsrcd,stalld,pcplus4tod, pcplus4d);
regfile2 rfd (clk, regwritew, instrd[25:21], instrd[20:16], writeregw, resultw, rdd1, rdd2);
mux2 #(32) muxad(rdd1tomux, aluoutmtoda, forwardad, ratocmp);
mux2 #(32) muxbd(rdd2tomux, aluoutmtodb, forwardbd, rbtocmp);
cmp #(32) cmpd(ratocmp,rbtocmp, equald);
signext sed(instrd[15:0], signimmd);
sl2 sl2d1 (signimmdtosl2, sl2d1res);
adder adderd1 (sl2d1res, pcplus4d, pcbranchd);
//execute logic
flopu #(32) rd1erege(clk,1'b0,flushe,1'b1,rdd1, rde1);
flopu #(32) rd2erege(clk,1'b0,flushe,1'b1,rdd2, rde2);
flopu #(5) rserege(clk,1'b0,flushe,1'b1,rsd, rse);
flopu #(5) rterege(clk,1'b0,flushe,1'b1,rtd, rte);
flopu #(5) rderege(clk,1'b0,flushe,1'b1,rdd, rde);
flopu #(32) signimmerege(clk,1'b0,flushe,1'b1,signimmd, signimme);
mux2 #(5) writeregemuxe(rte, rde, regdste, writerege);
mux4 #(32) srcamuxe(rde1, resultwtoea, aluoutmtoea, 32'b0, forwardae, srcae);
mux4 #(32) srcb0muxe(rde2, resultwtoeb, aluoutmtoeb, 32'b0, forwardbe, srcbe0);
mux2 #(32) srcbmuxe(srcbe0, signimme, alusrcbe, srcbe);
alu #(32) alue(srcae, srcbe, alucontrole, aluoute, zero);
//memory logic
flopu #(32) aluouteregm(clk,1'b0,1'b0,1'b1,aluoute, aluoutm);
flopu #(32) writedataeregm(clk,1'b0,1'b0,1'b1,writedatae, writedatam);
flopu #(5) writeregeregm(clk,1'b0,1'b0,1'b1, writerege, writeregm);
//wtiteback logic
flopu #(32) readdatawregw(clk,1'b0,1'b0,1'b1,readdatam, readdataw);
flopu #(32) aluoutmregw(clk,1'b0,1'b0,1'b1,aluoutmtow, aluoutw);
flopu #(5) writeregmregw(clk,1'b0,1'b0,1'b1, writeregm, writeregw);
mux2 #(32) resultwmuxw(aluoutw,readdataw,memtoregw, resultw);
endmodule 