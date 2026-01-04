`timescale 1ns/1ps

module tb_alu_8b;

    reg  [7:0]  a;
    reg  [7:0]  b;
    reg  [2:0]  opcode;

    wire [15:0] outALU;
    wire        cout;

    // DUT
    ALU_8b dut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .outALU(outALU),
        .cout(cout)
    );

    // --- opcodes (same names + same values) ---
    localparam [2:0] add     = 3'b000,
                     sub     = 3'b001,
                     mul     = 3'b010,
                     l_shift = 3'b011,
                     r_shift = 3'b100,
                     AND     = 3'b101,
                     OR      = 3'b110,
                     XOR     = 3'b111;

    // apply inputs + check
    task check;
        input [2:0]  op;
        input [7:0]  aa;
        input [7:0]  bb;
        input [15:0] exp_out;
        input        exp_cout;
    begin
        opcode = op; a = aa; b = bb;
        #1; // settle combinational logic

        if (outALU !== exp_out || cout !== exp_cout) begin
            $display("FAIL op=%b a=%h b=%h | got out=%h cout=%b | exp out=%h cout=%b",
                     op, aa, bb, outALU, cout, exp_out, exp_cout);
            $fatal;
        end else begin
            $display("PASS op=%b a=%h b=%h -> out=%h cout=%b", op, aa, bb, outALU, cout);
        end
    end
    endtask

    initial begin
        // --- ADD (expect carry) ---
        // F0 + 30 = 120 -> outALU[7:0]=20, carry=1
        check(add, 8'hF0, 8'h30, 16'h0120, 1'b1);

        // --- SUB ---
        check(sub, 8'h50, 8'h10, 16'h0040, 1'b0);

        // --- MUL (16-bit product) ---
        check(mul, 8'h10, 8'h04, 16'h0040, 1'b0);

        // --- Shifts ---
        // NOTE: your ALU uses a << b and a >> b (full 8-bit shift amount)
        check(l_shift, 8'h01, 8'h03, 16'h0008, 1'b0);
        check(r_shift, 8'h80, 8'h03, 16'h0010, 1'b0);

        // --- Logic ---
        check(AND, 8'hAA, 8'h0F, 16'h000A, 1'b0);
        check(OR , 8'hA0, 8'h0F, 16'h00AF, 1'b0);
        check(XOR, 8'hFF, 8'h0F, 16'h00F0, 1'b0);

        $display("ALL TESTS PASSED");
        $finish;
    end

endmodule