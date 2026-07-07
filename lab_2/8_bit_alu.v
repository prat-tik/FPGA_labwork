`timescale 1ns/1ps

module alu (
    input  [7:0] a,
    input  [7:0] b,
    input  [2:0] op,
    input        en,
    output reg [7:0] out
);

always @(*) begin
    if (en) begin
        case (op)
            3'b000: out = a + b;
            3'b001: out = a - b;
            3'b010: out = a & b;
            3'b011: out = a | b;
            3'b100: out = a ^ b;
            3'b101: out = ~a;
            3'b110: out = a + 8'd1;
            3'b111: out = a - 8'd1;
            default: out = 8'b0000_0000;
        endcase
    end
    else begin
        out = 8'b0000_0000;
    end
end

endmodule
