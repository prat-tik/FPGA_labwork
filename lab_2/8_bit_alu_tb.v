`timescale 1ns/1ps

module alu_tb;
    reg  [7:0] a, b;
    reg  [2:0] op;
    reg        en;
    wire [7:0] out;

    // Instantiate the ALU
    alu uut (
        .a(a),
        .b(b),
        .op(op),
        .en(en),
        .out(out)
    );

    initial begin
        $dumpfile("alu_wave.vcd");
        $dumpvars(0, alu_tb);

        // Initialize
        a = 8'd10; b = 8'd3; en = 1;

        // Test each operation
        op = 3'b000; #10; // add
        op = 3'b001; #10; // subtract
        op = 3'b010; #10; // AND
        op = 3'b011; #10; // OR
        op = 3'b100; #10; // XOR
        op = 3'b101; #10; // NOT a
        op = 3'b110; #10; // increment a
        op = 3'b111; #10; // decrement a

        // Disable ALU
        en = 0; op = 3'b000; #10;

        $finish;
    end

    initial begin
        $monitor("time=%0t en=%b op=%b a=%d b=%d out=%d",
                  $time, en, op, a, b, out);
    end
endmodule
