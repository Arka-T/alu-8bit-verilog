# 8-bit ALU (Verilog)

8-bit Arithmetic Logic Unit implemented in Verilog.

This ALU was written by me as the final project for a VLSI design course
(course-defined specification, independent RTL implementation and verification).

## Files
- `rtl/ALU_8b.v` – ALU RTL (opcode-based operations)
- `tb/tb_ALU_8b.v` – Testbench with basic checks (Vivado simulation)

## Operations (opcode)
- `000` ADD (with carry out)
- `001` SUB
- `010` MUL (16-bit result)
- `011` Left shift
- `100` Right shift
- `101` AND
- `110` OR
- `111` XOR
