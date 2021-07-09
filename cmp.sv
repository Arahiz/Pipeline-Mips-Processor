module cmp #(parameter N=4)(input logic [N-1:0] a,b,
                            output logic equal);
assign equal = (a==b)? 1'b1: 1'b0;
endmodule
