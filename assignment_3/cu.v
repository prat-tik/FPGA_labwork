`timescale 1ps/1ps

module control_unit (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [15:0] instruction,

    output reg  [7:0]  pc,
    output reg  [2:0]  readreg1,
    output reg  [2:0]  readreg2,
    output reg  [2:0]  writereg,
    output reg         writeenable,

    output reg  [7:0]  immediate,
    output reg         sel_2s_complement,
    output reg         sel_operand1,
    output reg  [2:0]  alu_op
);

    wire [3:0] opcode      = instruction[15:12];
    wire [2:0] source1     = instruction[11:9];
    wire [2:0] source2     = instruction[8:6];
    wire [2:0] destination = instruction[5:3];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            pc <= 8'd0;
        else
            pc <= pc + 8'd1;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            readreg1          <= 3'd0;
            readreg2          <= 3'd0;
            writereg          <= 3'd0;
            writeenable       <= 1'b0;
            alu_op            <= 3'd0;
            immediate         <= 8'd0;
            sel_2s_complement <= 1'b0;
            sel_operand1      <= 1'b0;
        end else begin
            readreg1          <= 3'd0;
            readreg2          <= 3'd0;
            writereg          <= 3'd0;
            writeenable       <= 1'b0;
            alu_op            <= 3'd0;
            immediate         <= 8'd0;
            sel_2s_complement <= 1'b0;
            sel_operand1      <= 1'b0;

            case (opcode)
                4'b0000: begin
                    readreg1    <= source1;
                    readreg2    <= source2;
                    writereg    <= destination;
                    writeenable <= 1'b1;
                    alu_op      <= 3'b000;
                end
                4'b0001: begin
                    readreg1          <= source1;
                    readreg2          <= source2;
                    writereg          <= destination;
                    writeenable       <= 1'b1;
                    alu_op            <= 3'b001;
                    sel_2s_complement <= 1'b1;
                end
                4'b0010: begin
                    readreg1    <= source1;
                    readreg2    <= source2;
                    writereg    <= destination;
                    writeenable <= 1'b1;
                    alu_op      <= 3'b010;
                end
                4'b0011: begin
                    readreg1    <= source1;
                    readreg2    <= source2;
                    writereg    <= destination;
                    writeenable <= 1'b1;
                    alu_op      <= 3'b011;
                end
                4'b0100: begin
                    readreg1    <= source1;
                    readreg2    <= source2;
                    writereg    <= destination;
                    writeenable <= 1'b1;
                    alu_op      <= 3'b100;
                end
                4'b0101: begin
                    readreg1    <= source1;
                    writereg    <= source1;
                    writeenable <= 1'b1;
                    alu_op      <= 3'b101;
                end
                4'b0110: begin
                    readreg1    <= source1;
                    writereg    <= source1;
                    writeenable <= 1'b1;
                    alu_op      <= 3'b110;
                end
                4'b0111: begin
                    readreg1          <= source1;
                    readreg2          <= source2;
                    writeenable       <= 1'b0;
                    alu_op            <= 3'b111;
                    sel_2s_complement <= 1'b1;
                end
                4'b1000: begin
                    writereg    <= destination;
                    writeenable <= 1'b1;
                    immediate   <= instruction[11:4];
                    sel_operand1<= 1'b1;
                    alu_op      <= 3'b000;
                end
                default: begin
                    writeenable <= 1'b0;
                end
            endcase
        end
    end
endmodule
