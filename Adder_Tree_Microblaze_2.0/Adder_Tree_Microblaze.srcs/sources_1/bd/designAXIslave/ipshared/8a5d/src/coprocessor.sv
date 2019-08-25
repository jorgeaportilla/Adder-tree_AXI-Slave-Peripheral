`timescale 1ns / 1ps

module coprocessor #(
parameter WORDSIZE = 8,
parameter NINPUTS =  512,
parameter NSTAGES = $clog2(NINPUTS),
parameter PWIDTH = 2**NSTAGES,
parameter NSUMS  = PWIDTH-1)
(   input  [NINPUTS/2*WORDSIZE-1 : 0] d1,
    input  [NINPUTS/2*WORDSIZE-1 : 0] d2,
    output reg [NINPUTS/2*WORDSIZE-1 : 0] d3,
    output reg [NINPUTS/2*WORDSIZE-1 : 0] d4,
    output [17 : 0] sum);

genvar i, j;

reg [7: 0] pipeline [NINPUTS/2-1 : 0];   // Pipeline array
reg [17: 0] pipeline2 [NSUMS-NINPUTS/2-1 : 0];   // Pipeline array

generate //Vec2
    for (i = 0; i < NINPUTS/2; i++) begin
     assign pipeline[i] = (d1[((i+1) * WORDSIZE)-1 -:8] > d2[((i+1) * WORDSIZE)-1 -:8])?(d1[((i+1) * WORDSIZE)-1 -:8]-d2[((i+1) * WORDSIZE)-1 -:8]):(d2[((i+1) * WORDSIZE)-1 -:8]-d1[((i+1) * WORDSIZE)-1 -:8]); 
    end
endgenerate

generate // Manhattam 
    for (i = 0; i < NINPUTS/4; i++) begin     
       assign pipeline2[i] = pipeline[i*2]  +pipeline[i*2 + 1] ;
    end
endgenerate
generate // Manhattam 
    for (i = 0; i <NSUMS; i++) begin
       assign pipeline2[NINPUTS/4+i] = pipeline2[i*2] + pipeline2[i*2 + 1];
    end
endgenerate
assign sum = pipeline2[NSUMS-NINPUTS/2-1]; 

generate // Sum
    for (i = 0; i < NINPUTS/2; i++) begin
       assign  d3[((i+1) * WORDSIZE)-1 -:8] = d1[((i+1) * WORDSIZE)-1 -:8] + d2[((i+1) * WORDSIZE)-1 -:8];
       assign  d4[((i+1) * WORDSIZE)-1 -:8] = (d3[((i+1) * WORDSIZE)-1 -:8])/2;
    end
endgenerate

endmodule