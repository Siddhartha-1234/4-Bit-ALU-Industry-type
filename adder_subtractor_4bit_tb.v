`timescale 1ns/1ps
`include "adder_subtractor_4bit.v"

module adder_subtractor_4bit_tb;

    reg  [3:0] a, b;
    reg        sub;
    wire [3:0] sum;
    wire       cout, overflow;

    integer i;
    reg [4:0] expected;   // 5 bits to catch carry-out
    reg [4:0] a_ext, b_ext;

    adder_subtractor_4bit DUT (
        .a(a), .b(b), .sub(sub),
        .sum(sum), .cout(cout), .overflow(overflow)
    );

    initial begin
        $dumpfile("adder_subtractor_4bit.vcd");
        $dumpvars(0, adder_subtractor_4bit_tb);

        $display("---- Directed tests ----");
        a = 4'd5;  b = 4'd3;  sub = 0; #10;  // 5 + 3 = 8
        $display("ADD: %0d + %0d = %0d (cout=%b)", a, b, sum, cout);

        a = 4'd7;  b = 4'd2;  sub = 1; #10;  // 7 - 2 = 5
        $display("SUB: %0d - %0d = %0d (cout=%b)", a, b, sum, cout);

        a = 4'd3;  b = 4'd9;  sub = 1; #10;  // 3 - 9 = -6 -> wraps in 4-bit
        $display("SUB (negative): %0d - %0d = %0d (two's complement)", a, b, sum);

        a = 4'd15; b = 4'd1;  sub = 0; #10;  // overflow of unsigned range
        $display("ADD (carry out): %0d + %0d = %0d (cout=%b)", a, b, sum, cout);

        $display("---- Randomized / exhaustive-ish tests ----");
        for (i = 0; i < 50; i = i + 1) begin
            a   = $random;
            b   = $random;
            sub = $random;
            #10;
            //   ADD: zero-extend both operands and add -> bit 4 is real carry-out
            //   SUB: 4-bit wraparound subtraction; cout=1 means a>=b (no borrow)
            if (sub) begin
                expected = {1'b0, a - b};
                expected[4] = (a >= b);
            end else begin
                a_ext = {1'b0, a};
                b_ext = {1'b0, b};
                expected = a_ext + b_ext;
            end
            if ({cout, sum} !== expected)
                $display("MISMATCH: a=%0d b=%0d sub=%b -> got %0d(cout=%b) expected %0d(cout=%b)",
                          a, b, sub, sum, cout, expected[3:0], expected[4]);
        end
        $finish;
    end

endmodule
