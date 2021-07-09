module mux4 # (parameter N=8)
              (input logic [N-1:0] a0, a1, a2, a3,
               input logic [1:0] s,
               output logic [N-1:0] aout);
  always_comb
    case(s)
      2'b00 : aout <= a0;
      2'b01 : aout <= a1;
      2'b10 : aout <= a2;
      2'b11 : aout <= a3;
      default: aout <= 32'bx;
    endcase
endmodule
      
