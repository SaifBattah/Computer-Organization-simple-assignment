module Verilog2(
    input clk,
    output wire [15:0] result
);

reg [15:0] memory[127:0];
reg [15:0] R0, R1;
reg [7:0] PC;

always @(posedge clk) begin
    PC <= PC + 1;
    case(PC)
        // LOAD R0, [30]
        8'h0A: begin
            R0 <= memory[30];
        end
        // LOAD R1, [31]
        8'h0B: begin
            R1 <= memory[31];
        end
        // MUL R1, R2
        8'h0C: begin
            R1 <= R1 * memory[32];
        end
        // ADD R0, R1
        8'h0D: begin
            R0 <= R0 + R1;
        end
        // SUB R0, 1
        8'h0E: begin
            R0 <= R0 - 1;
        end
        // LOAD R1, [33]
        8'h0F: begin
            R1 <= memory[33];
        end
        // SUB R1, R2
        8'h10: begin
            R1 <= R1 - memory[34];
        end
        // DIV R0, R1
        8'h11: begin
            R0 <= R0 / R1;
        end
        // STORE R0, [35]
        8'h12: begin
            memory[35] <= R0;
        end
    endcase
end

assign result = memory[35];

initial begin
    memory[30] = -1;
    memory[31] = 3;
    memory[32] = 5;
    memory[33] = 8;
    memory[34] = 4;
    PC = 10;
end

endmodule
