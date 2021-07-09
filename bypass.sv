module bypass (input logic branchdtobp, regwriteetobp, memtoregetobp, regwritemtobp, 
              memtoregmtobp, regwritewtobp,
              input logic [4:0] rsdtobp, rtdtobp, rsetobp,rtetobp, writeregetobp, writeregmtobp,writeregwtobp,
              output logic stallf, stalld, flushe, forwardad, forwardbd,
              output logic [1:0] forwardae, forwardbe);
logic lwstall, branchstall, stallf0, stalld0;

    assign stallf0 = branchstall| lwstall;
    assign stalld0 = branchstall| lwstall; 
    assign stallf = ~stallf0;
    assign stalld = ~stalld0;
    assign flushe = lwstall | branchstall;
always_comb
   begin
    if ((rsdtobp!= 0) & (rsdtobp == writeregmtobp) & regwritemtobp) forwardad = 1'b1;
    else forwardad = 1'b0;

    if ((rtdtobp!= 0) & (rtdtobp == writeregmtobp) & regwritemtobp) forwardbd = 1'b1;
    else forwardbd = 1'b0;

    if ((branchdtobp & regwriteetobp & ((writeregetobp == rsdtobp) | (writeregetobp == rtdtobp)))|
    (branchdtobp & memtoregmtobp & ((writeregmtobp == rsdtobp | writeregmtobp == rtdtobp)))) branchstall = 1'b1;
    else branchstall = 1'b0;
     
    if (((rsdtobp == rtetobp)|(rtdtobp == rtetobp))& memtoregetobp) lwstall = 1'b1;
    else lwstall = 1'b0;

    if ((rsetobp!= 5'b0) & (rsetobp == writeregmtobp)& regwritemtobp) forwardae = 2'b10;
    else if ((rsetobp != 5'b0) & (rsetobp == writeregwtobp) & regwritewtobp) forwardae = 2'b01;
    else forwardae = 2'b00;

    if ((rtetobp!= 5'b0) & (rtetobp == writeregmtobp)& regwritemtobp) forwardbe = 2'b10;
    else if ((rtetobp != 5'b0) & (rtetobp == writeregwtobp) & regwritewtobp) forwardbe = 2'b01;
    else forwardbe = 2'b00; 
  end
endmodule 
  


   

   //