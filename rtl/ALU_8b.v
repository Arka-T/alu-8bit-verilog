`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2025 17:02:58
// Design Name: 
// Module Name: ALU_8b
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU_8b (input [7:0] a, [7:0] b, [2:0] opcode, output reg [15:0] outALU, cout);

    parameter [2:0] add         = 3'b000,
                    sub         = 3'b001,
                    mul         = 3'b010,
                    l_shift     = 3'b011,
                    r_shift     = 3'b100,
                    AND         = 3'b101,
                    OR          = 3'b110,
                    XOR         = 3'b111;
                    
    always @ (*)
    begin
        
        outALU = 16'h0000;
        cout   = 1'b0;
        
        case (opcode)
            
            add:
                begin
                    outALU = a + b;
                    cout = outALU [8];
                end
            
            sub: outALU = a - b;
            
            mul: outALU = a * b;
            
            l_shift: outALU = a << b;
            
            r_shift: outALU = a >> b;
            
            AND: outALU = a & b;
            
            OR: outALU = a | b;
            
            XOR: outALU = a ^ b;
                            
        endcase
    end                    

endmodule
