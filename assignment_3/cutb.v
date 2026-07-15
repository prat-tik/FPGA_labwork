`timescale 1ps/1ps

module cu_tb;
    reg clk, rst_n;
    reg [15:0] instruction;

    wire [7:0] pc;
    wire [2:0] readreg1, readreg2, writereg;
    wire       writeenable;
    wire [7:0] immediate;
    wire       sel_2s_complement, sel_operand1;
    wire [2:0] alu_op;

    control_unit uut (
        .clk(clk),
        .rst_n(rst_n),
        .instruction(instruction),
        .pc(pc),
        .readreg1(readreg1),
        .readreg2(readreg2),
        .writereg(writereg),
        .writeenable(writeenable),
        .immediate(immediate),
        .sel_2s_complement(sel_2s_complement),
        .sel_operand1(sel_operand1),
        .alu_op(alu_op)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("cu.vcd");
        $dumpvars(0, cu_tb);

        $monitor("t=%0t | inst=%b | rd1=%d rd2=%d wr=%d we=%b | alu_op=%d | imm=%d | sel_op1=%b sel_2s=%b | pc=%d",
                 $time, instruction,
                 readreg1, readreg2, writereg, writeenable,
                 alu_op, immediate, sel_operand1, sel_2s_complement, pc);

        clk = 0; rst_n = 0; instruction = 16'h0000;
        #12 rst_n = 1;

        instruction = 16'b0000_001_010_011_000; #10; // ADD
        instruction = 16'b0001_001_010_100_000; #10; // SUB
        instruction = 16'b0010_001_010_101_000; #10; // AND
        instruction = 16'b0011_001_010_110_000; #10; // OR
        instruction = 16'b0100_001_010_111_000; #10; // XOR
        instruction = 16'b0101_001_000_000_000; #10; // INC
        instruction = 16'b0110_010_000_000_000; #10; // DEC
        instruction = 16'b0111_001_010_000_000; #10; // CMP
        instruction = 16'b1000_0000_1111_0110; #10; // LOAD

        #20 $finish;
    end
endmodule
