module alu #(parameter N=32)(input logic [N-1:0] srca, srcb,
            input logic [2:0] alucontrol,
            output logic [N-1:0] aluout,
            output logic zero);
logic [N-1:0] nsrcb;
logic [N-1:0] sub;
assign nsrcb = ~srcb;
assign sub = srca-srcb;
always_comb 
  case(alucontrol)
    3'b000: aluout <= srca&srcb;
    3'b001: aluout <= srca|srcb;
    3'b010: aluout <= srca+srcb;
    3'b100: aluout <= srca&nsrcb;
    3'b101: aluout <= srca|nsrcb;
    3'b110: aluout <= sub;   
    3'b111: aluout <= {31'b0000000000000000000000000000000, sub[31]};   
    default: aluout <= {N{1'bx}};
  endcase
assign zero = aluout ? 1'b0: 1'b1;
endmodule    
    