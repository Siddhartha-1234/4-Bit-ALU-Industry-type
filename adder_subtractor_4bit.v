`include "full_adder.v"

module adder_subtractor_4bit (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire       sub,        // 0 = add, 1 = subtract
    output wire [3:0] sum,
    output wire       cout,
    output wire       overflow    // signed overflow flag
);

    wire [3:0] b_mod = b ^ {4{sub}};
    wire [3:0] carry;             // internal carry chain

    full_adder fa0 (.a(a[0]), .b(b_mod[0]), .cin(sub),     .sum(sum[0]), .cout(carry[0]));
    full_adder fa1 (.a(a[1]), .b(b_mod[1]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
    full_adder fa2 (.a(a[2]), .b(b_mod[2]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
    full_adder fa3 (.a(a[3]), .b(b_mod[3]), .cin(carry[2]), .sum(sum[3]), .cout(carry[3]));

    assign cout     = carry[3];
    // Signed overflow: carry into MSB differs from carry out of MSB
    assign overflow = carry[3] ^ carry[2];

endmodule
