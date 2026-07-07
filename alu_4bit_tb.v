`include "alu_4bit.v"
`timescale 1ns/1ps

module alu_4bit_tb;

    reg  [3:0] a, b;
    reg  [2:0] sel;
    wire [3:0] result;
    wire       zero, carry_out, overflow;

    integer i;
    reg [3:0] expected;

    alu_4bit DUT (
        .a(a), .b(b), .sel(sel),
        .result(result), .zero(zero),
        .carry_out(carry_out), .overflow(overflow)
    );

    task show;
        begin
            $display("sel=%b a=%0d b=%0d -> result=%0d (bin=%b) zero=%b cout=%b ovf=%b",
                       sel, a, b, result, result, zero, carry_out, overflow);
        end
    endtask

    initial begin
        $dumpfile("alu_4bit.vcd");
        $dumpvars(0, alu_4bit_tb);

        a = 4'd6; b = 4'd3;

        sel = 3'b000; #10; show; // ADD -> 9
        sel = 3'b001; #10; show; // SUB -> 3
        sel = 3'b010; #10; show; // AND -> 2
        sel = 3'b011; #10; show; // OR  -> 7
        sel = 3'b100; #10; show; // XOR -> 5
        sel = 3'b101; #10; show; // NOR
        sel = 3'b110; #10; show; // SLT -> 0 (6 is not < 3)
        sel = 3'b111; #10; show; // PASS -> b = 3

        // SLT is a SIGNED compare. b=9 (0b1001) as a signed 4-bit value is -7,
        // so 2 < -7 is FALSE -> result should be 0. Use signed-friendly values
        // to show the "true" case instead:
        a = 4'd2; b = 4'd5;
        sel = 3'b110; #10; show; // SLT -> 1 (2 < 5, both positive)

        a = 4'd15; b = 4'd2; // a = -1 signed, b = +2 signed
        sel = 3'b110; #10; show; // SLT -> 1 (-1 < 2)

        a = 4'd0; b = 4'd0;
        sel = 3'b000; #10; show; // ADD -> zero flag should be 1

        $display("---- Randomized ADD/SUB check against behavioral model ----");
        for (i = 0; i < 30; i = i + 1) begin
            a   = $random;
            b   = $random;
            sel = $random & 3'b001; // 0 = ADD, 1 = SUB
            #10;
            expected = sel ? (a - b) : (a + b);
            if (result !== expected)
                $display("MISMATCH: sel=%b a=%0d b=%0d -> got %0d expected %0d",
                           sel, a, b, result, expected);
        end

        $display("ALU test complete.");
        $finish;
    end

endmodule
