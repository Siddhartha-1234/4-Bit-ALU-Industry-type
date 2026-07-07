`timescale 1ns/1ps
`include "full_adder.v"

module full_adder_tb;

    reg  a, b, cin;
    wire sum, cout;
    integer i;

    full_adder DUT (
        .a(a), .b(b), .cin(cin),
        .sum(sum), .cout(cout)
    );

    initial begin
        $dumpfile("full_adder.vcd");
        $dumpvars(0, full_adder_tb);
        $display("Full adder test complete.");
        $finish;
    end

endmodule
