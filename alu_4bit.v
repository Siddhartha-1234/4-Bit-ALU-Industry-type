`include "adder_subtractor_4bit.v"
module alu_4bit (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire [2:0] sel,
    output reg  [3:0] result,
    output wire       zero,
    output wire       carry_out,
    output wire       overflow
);

    wire [3:0] as_result;
    wire as_cout, as_ovf;

    adder_subtractor_4bit MAIN_ADDER (
        .a(a), .b(b), .sub(sel[0]),
        .sum(as_result), .cout(as_cout), .overflow(as_ovf)
    );

    wire [3:0] cmp_result;
    wire       cmp_cout, cmp_ovf;

    adder_subtractor_4bit CMP_SUBTRACTOR (
        .a(a), .b(b), .sub(1'b1),
        .sum(cmp_result), .cout(cmp_cout), .overflow(cmp_ovf)
    );

    wire slt = cmp_result[3] ^ cmp_ovf;  // MIPS-style sign-XOR-overflow trick
    //operation selection mux
    always @(*) begin
        case (sel)
            3'b000: result = as_result;          // ADD
            3'b001: result = as_result;          // SUB
            3'b010: result = a & b;              // AND
            3'b011: result = a | b;              // OR
            3'b100: result = a ^ b;              // XOR
            3'b101: result = ~(a | b);           // NOR
            3'b110: result = {3'b000, slt};      // SLT
            3'b111: result = b;                  // PASS-THROUGH
            default: result = 4'b0000;
        endcase
    end

    assign zero      = (result == 4'b0000);
    assign carry_out = as_cout;
    assign overflow  = as_ovf;

endmodule
