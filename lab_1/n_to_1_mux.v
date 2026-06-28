`timescale 1ns/1ps
module mux_n_to_1 #(
    parameter N    = 4,                   
    parameter W    = 8,                   
    parameter SEL  = $clog2(N)            
)(
    input  wire [N*W-1:0] inputs,         
    input  wire [SEL-1:0] sel,
    output reg  [W-1:0]   y
);
    integer i;

    always @(*) begin
        y = {W{1'b0}};
        for (i = 0; i < N; i = i + 1) begin
            if (sel == i)
                y = inputs[i*W +: W];
            end
    end
endmodule