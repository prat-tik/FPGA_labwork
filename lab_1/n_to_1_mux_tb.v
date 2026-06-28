`timescale 1ns/1ps
module tb_mux_n_to_1;
    parameter N   = 4;
    parameter W   = 8;
    parameter SEL = $clog2(N);

    reg  [N*W-1:0] inputs;
    reg  [SEL-1:0] sel;
    wire [W-1:0]   y;

    mux_n_to_1 #(.N(N), .W(W)) dut (.inputs(inputs), .sel(sel), .y(y));

    integer i;

    initial begin
        $dumpfile("mux_n_to_1.vcd");
        $dumpvars(0, tb_mux_n_to_1);

        inputs[0*W +: W] = 8'hAA;
        inputs[1*W +: W] = 8'hBB;
        inputs[2*W +: W] = 8'hCC;
        inputs[3*W +: W] = 8'hDD;

        for (i = 0; i < N; i = i + 1) begin
            sel = i; #10;
            $display("sel=%0d | y=%h | expect=%h | %s",
                sel, y, inputs[i*W +: W],
                (y === inputs[i*W +: W]) ? "PASS" : "FAIL");
        end

        $finish;
    end
endmodule