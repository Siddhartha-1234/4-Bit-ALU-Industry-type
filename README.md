<<<<<<< HEAD
# 4-bit ALU

A 4-bit ALU built bottom-up from a single full-adder cell - arithmetic
does **not** use Verilog's `+`/`-` operators anywhere in the design
(only inside testbenches, as an independent reference model to check
against).

## Files

| File | Purpose |
|---|---|
| `full_adder.v` | 1-bit full adder, built from raw gate equations |
| `adder_subtractor_4bit.v` | 4-bit ripple-carry adder/subtractor made of 4 full adders |
| `alu_4bit.v` | Top-level ALU: 8 operations, uses the adder/subtractor for ADD/SUB and SLT |

## ALU opcode table (`sel[2:0]`)

| sel | Operation | Result |
|---|---|---|
| 000 | ADD | a + b |
| 001 | SUB | a - b |
| 010 | AND | a & b |
| 011 | OR  | a \| b |
| 100 | XOR | a ^ b |
| 101 | NOR | ~(a \| b) |
| 110 | SLT | 1 if a < b (signed), else 0 |
| 111 | PASS | b |

Flags `zero`, `carry_out`, `overflow` are meaningful for ADD/SUB;
for pure logic ops `carry_out`/`overflow` just reflect the idle
adder path and can be ignored (this is normal - real ALUs do the same
and let the control unit decide which flags to look at per opcode).
=======
# 4-Bit-ALU-Industry-type
A 4-bit Arithmetic Logic Unit (ALU) built from scratch in Verilog. Includes a full adder, a 4-bit adder/subtractor, and a top-level ALU supporting 8 operations (ADD, SUB, AND, OR, XOR, NOR, SLT, PASS), each verified with its own testbench.
>>>>>>> ac33a2d0888c08712f9bb53af84a92377d2fab10
